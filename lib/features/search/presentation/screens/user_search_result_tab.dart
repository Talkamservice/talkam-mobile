import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:talkam/common/widgets/custom_dialogs.dart';
import 'package:talkam/common/widgets/error_widget.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/di/injector.dart';
import 'package:talkam/features/post/presentation/widgets/post_item.dart';
import 'package:talkam/features/search/presentation/blocs/post_search/post_search_cubit.dart';
import 'package:talkam/features/search/presentation/blocs/user_search/user_search_cubit.dart';
import 'package:talkam/features/search/presentation/widget/user_search_result_item.dart';
import 'package:talkam/features/settings/presentation/screens/blocked_users_screen.dart';

import '../../../post/presentation/widgets/post_loading_shimmer.dart';

class UserSearchResultTab extends StatefulWidget {
  const UserSearchResultTab({super.key, required this.query});

  final String query;

  @override
  State<UserSearchResultTab> createState() => _UserSearchResultTabState();
}

class _UserSearchResultTabState extends State<UserSearchResultTab>
    with AutomaticKeepAliveClientMixin {
  final bloc = UserSearchCubit(injector.get());

  @override
  void initState() {
    super.initState();
    bloc.searchUser(widget.query);
    _scrollController = ScrollController()..addListener(_onScroll);
  }

  late ScrollController _scrollController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
              child: BlocConsumer<UserSearchCubit, UserSearchState>(
                bloc: bloc,
                listener: (context, state) {},
                builder: (context, state) {
                  return state.maybeWhen(
                    orElse: () => 0.verticalSpace,
                    getUserSearchLoading: () =>  Center(
                      child: CustomDialogs.getLoading(size: 40),
                    ),
                    userSearchLoaded: (users, paginationMeta) {
                      if (users.isEmpty) {
                        return const Center(
                          child: TextView(text: "No Results Found"),
                        );
                      }
                      return RefreshIndicator(
                        onRefresh: () async {
                          bloc.searchUser(widget.query);
                        },
                        child: ListView.builder(
                          controller: _scrollController,
                          itemCount: paginationMeta.canLoadMore
                              ? users.length + 1
                              : users.length,
                          itemBuilder: (context, index) {
                            if (index >= users.length) {
                              return const Center(
                                  child: CircularProgressIndicator());
                            }
                            return Padding(
                              padding: const EdgeInsets.only(top: 8.0,left: 16,right: 16),
                              child: UserSearchResultItem(userSearchResult: users[index]),
                            );
                          },
                        ),
                      );
                    },
                    getUserSearchFailed: (error) => AppErrorWidget(
                      onTap: () {
                        bloc.searchUser(widget.query);
                      },
                    ),
                  );
                },
              ))
        ],
      ),
    );
  }

  void _onScroll() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      bloc.fetchNextPage(widget.query);
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  bool get wantKeepAlive => true;
}
