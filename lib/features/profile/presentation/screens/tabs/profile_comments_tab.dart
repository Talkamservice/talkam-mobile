import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talkam/common/widgets/custom_dialogs.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/constants/package_exports.dart';
import 'package:talkam/core/di/injector.dart';
import 'package:talkam/features/post/data/models/talk_am_comment.dart';
import 'package:talkam/features/profile/presentation/bloc/profile_comment_tab_cubit/profile_comment_tab_cubit.dart';
import 'package:talkam/features/profile/presentation/widgets/profile_comment_tile.dart';

class ProfileCommentsTab extends StatefulWidget {
  const ProfileCommentsTab({super.key});

  @override
  State<ProfileCommentsTab> createState() => _ProfileCommentsTabState();
}

class _ProfileCommentsTabState extends State<ProfileCommentsTab>
    with AutomaticKeepAliveClientMixin {
  final ProfileCommentTabCubit _cubit = injector.get();
  List<TalkAmComment> _comments = [];
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    _cubit.fetchUserComments();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocConsumer<ProfileCommentTabCubit, ProfileCommentTabState>(
      bloc: _cubit,
      listener: (context, state) {
        state.maybeWhen(
          loaded: (List<TalkAmComment> comments) {
            _comments = comments;
            setState(() {});
          },
          orElse: () {},
        );
      },
      builder: (context, state) {
        return state.maybeWhen(
          loading: () => Center(
            child: CustomDialogs.getLoading(size: 50),
          ),
          error: () => const SizedBox.shrink(),
          orElse: () {
            if (_comments.isEmpty) {


              return const Center(

                child: TextView(
                  text: "No comments yet",
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              );
            }


            return RefreshIndicator(
              onRefresh: () async {
                _cubit.fetchUserComments();

              },
              child: ListView(
                controller: _scrollController,
                physics: const AlwaysScrollableScrollPhysics(),
                padding: EdgeInsets.only(top: 20.0.h),
                children: [
                  for (int i = 0; i < _comments.length; i++) ...[
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 14.w),
                      child: ProfileCommentTile(
                        talkAmComment: _comments[i],
                      ),
                    ),
                    24.verticalSpace,
                  ],
                  if (state is ProfileCommentLoadingMoreTabState)
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 16.h),
                      child: Center(child: CustomDialogs.getLoading(size: 50)),
                    )
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
