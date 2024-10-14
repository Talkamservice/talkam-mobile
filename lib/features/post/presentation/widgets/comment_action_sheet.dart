import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talkam/common/widgets/block_reason_sheet.dart';
import 'package:talkam/common/widgets/custom_dialogs.dart';
import 'package:talkam/common/widgets/image_widget.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/_core.dart';
import 'package:talkam/core/constants/package_exports.dart';
import 'package:talkam/core/di/injector.dart';
import 'package:talkam/core/services/network/url_config.dart';
import 'package:talkam/core/theme/pallets.dart';
import 'package:talkam/core/utils/extensions/context_extension.dart';
import 'package:talkam/core/utils/extensions/int_extension.dart';
import 'package:talkam/core/utils/guest_user_helper.dart';
import 'package:talkam/features/post/data/models/get_comments_response.dart';
import 'package:talkam/features/post/data/models/talk_am_comment.dart';
import 'package:talkam/features/post/presentation/bloc/post/post_bloc.dart';
import 'package:talkam/features/post/presentation/widgets/confirm_report_dialog.dart';
import 'package:talkam/features/post/presentation/widgets/report_sucess_dialog.dart';
import 'package:talkam/features/profile/presentation/bloc/profile_bloc/profile_bloc.dart';
import 'package:talkam/gen/assets.gen.dart';

class CommentActionSheet extends StatelessWidget {
  CommentActionSheet(
      {super.key,
      required this.comment,
      required this.postId,
      required this.onDeleted});

  final PostComment comment;
  final String postId;
  final VoidCallback onDeleted;
  final profileBloc = ProfileBloc(injector.get());
  final postBloc = PostBloc(injector.get());

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
      decoration: BoxDecoration(
          color: context.theme.cardColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(8.r),
            topRight: Radius.circular(8.r),
          )),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _CommentAction(
            imagePath: Assets.images.svgs.link01,
            tittle: "Copy link",
            onTap: () {
              Helpers.copy("${UrlConfig.webUrl}${comment.id}");
              context.pop();
            },
          ),
          _CommentAction(
            imagePath: Assets.images.svgs.copy07,
            tittle: "Copy comment text",
            onTap: () {
              Helpers.copy(comment.comment);
              context.pop();
            },
          ),

          GuestUserHelper.guestUserWidget(widget:  Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _CommentAction(
                imagePath: Assets.images.svgs.bellPlus,
                tittle: "Get notifications for this comment",
                onTap: () {},
              ),
              if (!comment.isAnonymous.toBool && !commentIsFromLoggedInUser)
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
                      context.pop();
                      context.pop();
                      CustomDialogs.success("User Blocked");
                    }
                  },
                  child: _CommentAction(
                    imagePath: Assets.images.svgs.slashCircle01,
                    tittle: "Block ${comment.user?.name ?? comment.user?.username}",
                    onTap: () {
                      blockUser(context);
                    },
                  ),
                ),
              if (!commentIsFromLoggedInUser)
                BlocListener<PostBloc, PostState>(
                  bloc: postBloc,
                  listener: (context, state) {
                    state.maybeWhen(
                      orElse: () => null,
                      reportCommentSuccess: () async {
                        await CustomDialogs.showCustomDialog(
                            const ReportSuccessDialog(), context);
                        context.pop();
                        context.pop();
                      },
                      reportCommentFailure: (error) {
                        context.pop();
                        CustomDialogs.error(error);
                      },
                      reportCommentLoading: () {
                        CustomDialogs.showLoading(context);
                      },
                    );
                  },
                  child: _CommentAction(
                    imagePath: Assets.images.svgs.slashCircle01,
                    tittle: "Report this comment",
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
                          postBloc.add(PostEvent.reportComment(
                              postId, comment.id.toString(), reason));
                        }
                      }

                      // context.pop();
                    },
                  ),
                ),
              if (commentIsFromLoggedInUser)
                BlocListener<PostBloc, PostState>(
                  bloc: postBloc,
                  listener: (context, state) {
                    state.maybeWhen(
                      orElse: () => null,
                      deleteCommentSuccess: () async {
                        CustomDialogs.success("Comment deleted");
                        context.pop();
                        context.pop();
                        onDeleted();
                      },
                      deleteCommentFailure: (error) {
                        context.pop();
                        CustomDialogs.error(error);
                      },
                      deleteCommentLoading: () {
                        CustomDialogs.showLoading(context);
                      },
                    );
                  },
                  child: _CommentAction(
                    imagePath: Assets.images.svgs.icDelete,
                    tittle: "Delete this comment",
                    color: Pallets.boldRedV2,
                    onTap: () async {
                      CustomDialogs.showConfirmDialog(context, onYes: () {
                        context.pop();
                        postBloc
                            .add(PostEvent.deleteComment(comment.id.toString()));
                      },
                          tittle: 'Delete comment',
                          message:
                          'Are you sure uou want to delete this comment ? ');

                      // context.pop();
                    },
                  ),
                ),
            ],),
          guestWidget: 0.verticalSpace
          )


        ],
      ),
    );
  }

  bool get commentIsFromLoggedInUser =>
      comment.user.id == injector.get<ProfileBloc>().appUser?.id;

  void blockUser(BuildContext context) async {
    var reason =
        await CustomDialogs.showCustomDialog(BlockReasonSheet(), context);
    if (reason != null) {
      profileBloc.add(BlockUerEvent(comment.user!.id.toString()));
    }
  }
}

class _CommentAction extends StatelessWidget {
  const _CommentAction(
      {super.key,
      required this.imagePath,
      required this.tittle,
      required this.onTap,
      this.color});

  final String imagePath;
  final String tittle;
  final Color? color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 10),
            child: Row(
              children: [
                ImageWidget(imageUrl: imagePath),
                18.horizontalSpace,
                TextView(
                  text: tittle,
                  fontSize: 16,
                  color: color,
                  fontWeight: FontWeight.w500,
                )
              ],
            ),
          ),
          const Divider(
              // thickness: 1,
              )
        ],
      ),
    );
  }
}
