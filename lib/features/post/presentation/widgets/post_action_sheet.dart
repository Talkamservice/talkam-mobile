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
import 'package:talkam/core/utils/extensions/context_extension.dart';
import 'package:talkam/core/utils/extensions/int_extension.dart';
import 'package:talkam/core/utils/guest_user_helper.dart';
import 'package:talkam/features/ads/presentation/widgets/view_analytics_bottomsheet.dart';
import 'package:talkam/features/post/data/models/get_posts_response.dart';
import 'package:talkam/features/post/dormain/mixins/refresh_posts_mixin.dart';
import 'package:talkam/features/post/presentation/bloc/post/post_bloc.dart';
import 'package:talkam/features/post/presentation/widgets/confirm_report_dialog.dart';
import 'package:talkam/features/post/presentation/widgets/report_sucess_dialog.dart';
import 'package:talkam/features/profile/presentation/bloc/profile_bloc/profile_bloc.dart';
import 'package:talkam/gen/assets.gen.dart';

import '../../../ads/data/models/promotion_data.dart';
import '../../../ads/presentation/screens/ads_review_screens/view_analytics_page.dart';

class PostActionSheet extends StatelessWidget with RefreshPostsMixin {
  PostActionSheet({super.key, required this.post, required this.onPostDeleted,});

  TalkamPost post;
  final profileBloc = ProfileBloc(injector.get());
  final postBloc = PostBloc(injector.get());
  final VoidCallback onPostDeleted;

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
          _PostAction(
            imagePath: Assets.images.svgs.link01,
            tittle: "Copy link",
            onTap: () {
              Helpers.copy("${UrlConfig.coreBaseUrl}comment/${post.id}");
              context.pop();
            },
          ),
          _PostAction(
            imagePath: Assets.images.svgs.copy07,
            tittle: "Copy post text",
            onTap: () {
              Helpers.copy(post.body ?? post.title);
              context.pop();
            },
          ),
          GuestUserHelper.guestUserWidget(
              widget: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _PostAction(
                    imagePath: Assets.images.svgs.bellPlus,
                    tittle: "Get notifications for this post",
                    onTap: () {},
                  ),
                  // if (postIsFromLoggedInUser && post.isPromoted)
                  _PostAction(
                    imagePath: Assets.images.svgs.analytics,
                    tittle: "View analytics",
                    onTap: () async {
                      context.pop();
                       await CustomDialogs.showBottomSheet(
                          context,
                          ViewAnalyticsBottomSheet(postId: post.id.toString(),),
                          );
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
                        imagePath: Assets.images.svgs.slashCircle01,
                        tittle: "Block ${post.user?.usersName}",
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

                            // postBloc.add(
                            //     PostEvent.getPostDetails(post.id.toString()));
                            await CustomDialogs.showCustomDialog(const ReportSuccessDialog(), context);
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
                        imagePath: Assets.images.svgs.slashCircle01,
                        tittle: "Report this post",
                        onTap: () async {
                          var reason = await CustomDialogs.showCustomDialog(BlockReasonSheet(), context);
                          if (reason != null) {
                            var report = await CustomDialogs.showCustomDialog(
                                ConfirmReportDialog(
                                  reason: reason!,
                                ),
                                context);

                            if (report) {
                              postBloc.add(PostEvent.reportPost(post.id.toString(), reason));
                            }
                          }

                          // context.pop();
                        },
                      ),
                    ),
                  if (postIsFromLoggedInUser)
                    BlocListener<PostBloc, PostState>(
                      bloc: postBloc,
                      listener: (context, state) {
                        state.maybeWhen(
                          orElse: () => null,
                          deletePostLoading: () => CustomDialogs.showLoading(context),
                          deletePostSuccess: () {
                            // injector.get<ProfilePostsTabCubit>().fetchUserPosts();
                            context.pop();
                            context.pop();
                            onPostDeleted();
                            refreshPost(reload: false);
                            CustomDialogs.success("Post Deleted");
                          },
                        );
                      },
                      child: _PostAction(
                        imagePath: Assets.images.svgs.icDelete,
                        tittle: "Delete post",
                        onTap: () async {
                          CustomDialogs.showConfirmDialog(
                            context,
                            message: "Are you sure you want to delete this post ?",
                            tittle: "Delete post",
                            onYes: () {
                              context.pop();
                              postBloc.add(PostEvent.deletePost(post.id.toString()));
                            },
                          );
                        },
                      ),
                    ),
                ],
              ),
              guestWidget: 0.verticalSpace),
        ],
      ),
    );
  }

  void blockUser(BuildContext context) async {
    var reason = await CustomDialogs.showCustomDialog(BlockReasonSheet(), context);
    if (reason != null) {
      profileBloc.add(BlockUerEvent(post.user.id.toString()));
    }
  }

  bool get postIsFromLoggedInUser => post.user.id == injector.get<ProfileBloc>().appUser?.id;
}

class _PostAction extends StatelessWidget {
  const _PostAction({super.key, required this.imagePath, required this.tittle, required this.onTap});

  final String imagePath;
  final String tittle;
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
