import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talkam/common/widgets/custom_dialogs.dart';
import 'package:talkam/common/widgets/empty_state.dart';
import 'package:talkam/core/constants/package_exports.dart';
import 'package:talkam/core/di/injector.dart';
import 'package:talkam/features/post/data/models/get_comments_response.dart';
import 'package:talkam/features/post/data/models/talk_am_comment.dart';
import 'package:talkam/features/profile/presentation/bloc/user_profile_comments_cubit/user_profile_comments_cubit.dart';
import 'package:talkam/features/profile/presentation/widgets/profile_comment_tile.dart';
import 'package:talkam/features/profile/presentation/widgets/refresh_post_listener.dart';

class UserProfileCommentsTab extends StatefulWidget {
  const UserProfileCommentsTab({super.key, required this.userID});

  final String userID;

  @override
  State<UserProfileCommentsTab> createState() => _UserProfileCommentsTabState();
}

class _UserProfileCommentsTabState extends State<UserProfileCommentsTab> with AutomaticKeepAliveClientMixin {
  final UserProfileCommentsCubit _cubit = injector.get();
  List<TalkAmComment> _comments = [];
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    _cubit.fetchUserComments(widget.userID);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return RefreshPostListener(
      onRefresh: () {
        _cubit.fetchUserComments(widget.userID);

      },
      child: BlocConsumer<UserProfileCommentsCubit, UserProfileCommentsState>(
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
                return RefreshIndicator(
                  onRefresh: () async {
                    _cubit.fetchUserComments(widget.userID);
                  },
                  child: ListView(
                    children: [
                      60.verticalSpace,
                      const EmptyState(
                        title: 'No comments yet',
                        subtitle: "Comments will appear here if any ",
                      ),
                    ],
                  ),
                );
              }
              return RefreshIndicator(
                onRefresh: () async {
                  _cubit.fetchUserComments(widget.userID);
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
                    if (state is UserProfileCommentLoadingMoreTabState)
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
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
