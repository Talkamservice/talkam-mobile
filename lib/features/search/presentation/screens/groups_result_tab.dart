import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:talkam/common/widgets/custom_dialogs.dart';
import 'package:talkam/common/widgets/error_widget.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/constants/dialog_texts.dart';
import 'package:talkam/core/di/injector.dart';
import 'package:talkam/core/navigation/route_url.dart';
import 'package:talkam/features/post/presentation/widgets/post_item.dart';
import 'package:talkam/features/search/presentation/blocs/groups_search/groups_search_cubit.dart';
import 'package:talkam/features/search/presentation/blocs/post_search/post_search_cubit.dart';
import 'package:talkam/features/search/presentation/widget/group_result_item.dart';

class GroupsResultTab extends StatefulWidget {
  const GroupsResultTab({super.key, required this.query});

  final String query;

  @override
  State<GroupsResultTab> createState() => _GroupsResultTabState();
}

class _GroupsResultTabState extends State<GroupsResultTab> with AutomaticKeepAliveClientMixin {
  final bloc = GroupsSearchCubit(injector.get());

  @override
  void initState() {
    super.initState();
    bloc.searchGroup(widget.query);
    _scrollController = ScrollController()..addListener(_onScroll);
  }

  late ScrollController _scrollController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
              child: BlocConsumer<GroupsSearchCubit, GroupsSearchState>(
            bloc: bloc,
            listener: (context, state) {},
            builder: (context, state) {
              return state.maybeWhen(
                orElse: () => 0.verticalSpace,
                getGroupSearchLoading: () => Center(
                  child: CustomDialogs.getLoading(size: 50),
                ),
                groupSearchLoaded: (posts, paginationMeta) {
                  if (posts.isEmpty) {
                    return const Center(
                      child: TextView(text: "No Results Found"),
                    );
                  }
                  return RefreshIndicator(
                    onRefresh: () async {
                      bloc.searchGroup(widget.query);
                    },
                    child: ListView.builder(
                      controller: _scrollController,
                      physics: const AlwaysScrollableScrollPhysics(),
                      itemCount: paginationMeta.canLoadMore! ? posts.length + 1 : posts.length,
                      itemBuilder: (context, index) {
                        if (index >= posts.length) {
                          return const Center(child: CircularProgressIndicator());
                        }
                        return InkWell(
                          onTap: () {
                            if (posts[index].isSuspended ?? false) {
                              CustomDialogs.error("You have been suspended from this group");
                            } else if (!posts[index].isPublic && !(posts[index].isFollowing ?? false)) {
                              CustomDialogs.showInfoMessage(context, privateGroupViewText);
                            } else {
                              context.pushNamed(PageUrl.groupsInfoScreen, extra: posts[index].id.toString());
                            }

                          },
                          child: GroupResultItem(
                            group: posts[index],
                            onJoinStateChanged: () {
                              bloc.searchGroup(widget.query, shouldRefresh: false);
                            },
                          ),
                        );
                      },
                    ),
                  );
                },
                getGroupSearchFailed: (error) => AppErrorWidget(
                  onTap: () {
                    bloc.searchGroup(widget.query);
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
    if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
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
