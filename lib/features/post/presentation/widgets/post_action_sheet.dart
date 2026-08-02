import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talkam/common/widgets/block_reason_sheet.dart';
import 'package:talkam/common/widgets/custom_dialogs.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/constants/package_exports.dart';
import 'package:talkam/core/di/injector.dart';
import 'package:talkam/core/utils/extensions/context_extension.dart';
import 'package:talkam/core/utils/extensions/int_extension.dart';
import 'package:talkam/core/utils/guest_user_helper.dart';
import 'package:talkam/features/post/data/models/get_posts_response.dart';
import 'package:talkam/features/post/dormain/mixins/refresh_posts_mixin.dart';
import 'package:talkam/features/post/presentation/bloc/post/post_bloc.dart';
import 'package:talkam/features/post/presentation/widgets/confirm_report_dialog.dart';
import 'package:talkam/features/post/presentation/widgets/report_sucess_dialog.dart';
import 'package:talkam/features/profile/presentation/bloc/profile_bloc/profile_bloc.dart';

class PostActionSheet extends StatelessWidget with RefreshPostsMixin {
  PostActionSheet({
    super.key,
    required this.post,
    required this.onPostDeleted,
  });

  TalkamPost post;
  final profileBloc = ProfileBloc(injector.get());
  final postBloc = PostBloc(injector.get());
  final VoidCallback onPostDeleted;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 24.h),
      decoration: BoxDecoration(
        color: context.theme.cardColor,
        borderRadius: BorderRadius.circular(24.r),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _PostAction(
            title: "Not Interested in the post",
            onTap: () => context.pop(),
          ),
          GuestUserHelper.guestUserWidget(
            widget: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _PostAction(
                  title: "Mute ${post.user.usersName}",
                  onTap: () {
                    context.pop();
                    CustomDialogs.success("${post.user.usersName} muted");
                  },
                ),
                if (!post.isAnonymous.toBool && !postIsFromLoggedInUser)
                  BlocListener<ProfileBloc, ProfileState>(
                    bloc: profileBloc,
                    listener: (context, state) {
                      if (state is BlockUserLoadingState) {
                        CustomDialogs.showLoading(context);
                      }

                      if (state is BlockUserFailureState) {
                        context.pop();
                        CustomDialogs.error(state.error);
                      }
                      if (state is BlockUserSuccessState) {
                        refreshPost(reload: false);
                        context.pop();
                        context.pop();
                        CustomDialogs.success("User Blocked");
                      }
                    },
                    child: _PostAction(
                      title: "Block ${post.user.usersName}",
                      onTap: () {
                        blockUser(context);
                      },
                    ),
                  ),
                if (!postIsFromLoggedInUser && !(post.isReported ?? false))
                  BlocListener<PostBloc, PostState>(
                    bloc: postBloc,
                    listener: (context, state) {
                      state.maybeWhen(
                        orElse: () => null,
                        getPostDetailsSuccess: (response) {
                          post = response.data;
                        },
                        reportPostSuccess: () async {
                          refreshPost(reload: false);

                          await CustomDialogs.showCustomDialog(
                              const ReportSuccessDialog(), context);
                          context.pop();
                          context.pop(true);
                        },
                        reportPostFailure: (error) {
                          context.pop();
                          CustomDialogs.error(error);
                        },
                        reportPostLoading: () {
                          CustomDialogs.showLoading(context);
                        },
                      );
                    },
                    child: _PostAction(
                      title: "Report Post",
                      onTap: () async {
                        var reason = await CustomDialogs.showCustomDialog(
                            BlockReasonSheet(), context);
                        if (reason != null) {
                          var report = await CustomDialogs.showCustomDialog(
                              ConfirmReportDialog(
                                reason: reason!,
                              ),
                              context);

                          if (report) {
                            postBloc.add(PostEvent.reportPost(
                                post.id.toString(), reason));
                          }
                        }
                      },
                    ),
                  ),
              ],
            ),
            guestWidget: 0.verticalSpace,
          ),
        ],
      ),
    );
  }

  void blockUser(BuildContext context) async {
    var reason =
        await CustomDialogs.showCustomDialog(BlockReasonSheet(), context);
    if (reason != null) {
      profileBloc.add(BlockUerEvent(post.user.id.toString()));
    }
  }

  bool get postIsFromLoggedInUser =>
      post.user.id == injector.get<ProfileBloc>().appUser?.id;
}

class _PostAction extends StatelessWidget {
  const _PostAction({required this.title, required this.onTap});

  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 20.h),
        child: TextView(
          text: title,
          fontSize: 18,
          fontWeight: FontWeight.w400,
          color: Colors.black87,
        ),
      ),
    );
  }
}
