import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:readmore/readmore.dart';
import 'package:talkam/common/widgets/custom_dialogs.dart';
import 'package:talkam/common/widgets/image_widget.dart';
import 'package:talkam/common/widgets/post_action.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/constants/package_exports.dart';
import 'package:talkam/core/di/injector.dart';
import 'package:talkam/core/theme/pallets.dart';
import 'package:talkam/core/utils/_utils.dart';
import 'package:talkam/core/utils/extensions/context_extension.dart';
import 'package:talkam/features/post/data/models/get_posts_response.dart';
import 'package:talkam/features/post/presentation/bloc/post/post_bloc.dart';
import 'package:talkam/features/post/presentation/bloc/post/post_bloc.dart';
import 'package:talkam/features/post/presentation/widgets/post_content.dart';
import 'package:talkam/features/profile/presentation/bloc/profile_posts_tab_cubit/profile_posts_tab_cubit.dart';
import 'package:talkam/features/profile/presentation/bloc/user_profile_posts_cubit/user_profile_posts_cubit.dart';
import 'package:talkam/gen/assets.gen.dart';

class ProfilePostItemTile extends StatelessWidget {
  final String categoryIconImageUrl;
  final String categoryName;
  final String formattedPostTime;
  final String postTitle;
  final String postContent;
  final String username;
  final List<String> categories;
  final bool isScheduledPost;
  final DateTime? scheduledDate;
  final int postId;
  final int userId;
  final TalkamPost post;
  final bool isPublicProfile;

  const ProfilePostItemTile({
    super.key,
    required this.categoryIconImageUrl,
    required this.categoryName,
    required this.formattedPostTime,
    required this.postContent,
    required this.postTitle,
    required this.username,
    required this.categories,
    required this.postId,
    required this.isScheduledPost,
    this.scheduledDate,
    this.isPublicProfile = false,
    required this.userId,
    required this.post,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 4.0),
                child: ImageWidget(
                  imageUrl: categoryIconImageUrl,
                  height: 32.h,
                  width: 32.w,
                  shape: BoxShape.circle,
                ),
              ),
              12.horizontalSpace,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextView(
                        text: categoryName,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        color: Pallets.boldBlackV2,
                        textOverflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 2, left: 6.w),
                        child: TextView(
                          text: formattedPostTime.capitalizeFirst!,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w600,
                          color: Pallets.primary400,
                        ),
                      ),
                    ],
                  ),
                  2.verticalSpace,
                  TextView(
                    text: "Posted by $username",
                    fontSize: 12.sp,
                    color: Pallets.grey500,
                  ),
                ],
              ),
              const Spacer(),
              IconButton(
                padding: EdgeInsets.zero,
                icon: const Icon(Icons.more_vert_rounded,
                    color: Pallets.boldBlackV2),
                onPressed: () {
                  CustomDialogs.showBottomSheet(
                    context,
                    _PostInfoBottomSheet(
                      postContent:
                          postContent.isEmpty ? postTitle : postContent,
                      postId: postId,
                      isPublicProfile: isPublicProfile,
                      userId: userId,
                    ),
                  );
                },
              )
            ],
          ),
          // if (post.attachments.is)
          // Padding(
          //   padding: EdgeInsets.only(top: 12.h, right: 12.w),
          //   child: TextView(
          //     text: postTitle,
          //     fontWeight: FontWeight.w500,
          //     color: Pallets.boldBlackV2,
          //     fontSize: 16.sp,
          //   ),
          // ),
          // if (post.attachments.isEmpty)
          //   Padding(
          //     padding: EdgeInsets.only(top: 12.h, right: 12.w),
          //     child: ReadMoreText(
          //       postContent,
          //       trimLines: 5,
          //       trimCollapsedText: "Read more",
          //       trimExpandedText: "Show less",
          //       style: GoogleFonts.nunito(
          //         color: Pallets.boldBlackV2,
          //         fontWeight: FontWeight.w400,
          //         fontSize: 14.sp,
          //       ).copyWith(inherit: true),
          //       moreStyle: GoogleFonts.nunito(
          //         color: Pallets.primary400,
          //         fontWeight: FontWeight.w500,
          //         fontSize: 14.sp,
          //       ).copyWith(inherit: true),
          //     ),
          //   ),
          PostContent(post: post),
          20.verticalSpace,

          Container(
            height: 1,
            color: Pallets.borderGrey,
          ),
          if (isScheduledPost)
            Padding(
              padding: EdgeInsets.only(right: 12.w, top: 16.h),
              child: Container(
                width: double.infinity,
                height: 40.h,
                decoration: BoxDecoration(
                  color: Pallets.tabBarBlue,
                  borderRadius: BorderRadius.circular(40),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    TextView(
                      text: "Scheduled post",
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 13.sp,
                    ),
                    TextView(
                      text: DateFormat("dd MMMM, yyyy - hh:mm a")
                          .format(scheduledDate!),
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 13.sp,
                    ),
                  ],
                ),
              ),
            )
        ],
      ),
    );
  }
}

class _ChipItem extends StatelessWidget {
  final String title;

  const _ChipItem({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return UnconstrainedBox(
      child: Container(
        height: 23.h,
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(36),
          border: Border.all(
            color: const Color(0xFFD2D2D2),
          ),
        ),
        child: Center(
          child: TextView(
            text: title,
            fontSize: 13.sp,
            fontWeight: FontWeight.w500,
            color: Pallets.boldBlackV2,
          ),
        ),
      ),
    );
  }
}

class _PostInfoBottomSheet extends StatelessWidget {
  final int postId;
  final int userId;
  final String postContent;
  final bool isPublicProfile;

  final postBloc = PostBloc(injector.get());

  _PostInfoBottomSheet(
      {required this.postId,
      required this.postContent,
      required this.userId,
      required this.isPublicProfile});

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
          PostActionWidget(
            imagePath: Assets.images.svgs.link01,
            tittle: "Copy link",
            onTap: () {
              Helpers.copy("www.talkam.com/pos?id=$postId");
              context.pop();
            },
          ),
          PostActionWidget(
            imagePath: Assets.images.svgs.copy07,
            tittle: "Copy post text",
            onTap: () {
              Helpers.copy(postContent);
              context.pop();
            },
          ),
          PostActionWidget(
            imagePath: Assets.images.svgs.bellPlus,
            tittle: "Get notifications for this post",
            onTap: () {},
          ),
          if (!isPublicProfile)
            BlocListener<PostBloc, PostState>(
              bloc: postBloc,
              listener: (context, state) {
                state.maybeWhen(
                  orElse: () => null,
                  deletePostLoading: () => CustomDialogs.showLoading(context),
                  deletePostSuccess: () {
                    injector.get<ProfilePostsTabCubit>().fetchUserPosts();

                    context.pop();
                    context.pop();
                    CustomDialogs.success("Post Deleted");
                  },
                );
              },
              child: PostActionWidget(
                imagePath: Assets.images.svgs.icDelete,
                tittle: "Delete post",
                textColor: Pallets.boldRedV2,
                onTap: () {
                  CustomDialogs.showConfirmDialog(
                    context,
                    message: "Are you sure you want to delete this post ?",
                    tittle: "Delete post",
                    onYes: () {
                      context.pop();
                      postBloc.add(PostEvent.deletePost(postId.toString()));
                    },
                  );
                  // context.pop();
                },
              ),
            ),
        ],
      ),
    );
  }
}
