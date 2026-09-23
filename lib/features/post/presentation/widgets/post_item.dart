import 'package:flutter/material.dart';
import 'package:talkam/common/widgets/custom_dialogs.dart';
import 'package:talkam/core/_core.dart';
import 'package:talkam/core/constants/package_exports.dart';
import 'package:talkam/core/di/injector.dart';
import 'package:talkam/core/mock/mock_home_data.dart';
import 'package:talkam/core/navigation/route_url.dart';
import 'package:talkam/core/services/network/url_config.dart';
import 'package:talkam/core/utils/extensions/context_extension.dart';
import 'package:talkam/core/utils/extensions/int_extension.dart';
import 'package:talkam/features/ads/presentation/blocs/ads/ads_cubit.dart';
import 'package:talkam/features/ads/presentation/widgets/ad_indicator.dart';
import 'package:talkam/features/post/data/models/get_posts_response.dart';
import 'package:talkam/features/post/presentation/widgets/post_action_sheet.dart';
import 'package:talkam/features/post/presentation/widgets/post_content.dart';
import 'package:talkam/features/post/presentation/widgets/post_item_components.dart';
import 'package:talkam/features/post/presentation/widgets/scheduled_post_pill.dart';
import 'package:talkam/features/profile/presentation/bloc/profile_bloc/profile_bloc.dart';

class PostItem extends StatefulWidget {
  PostItem(
      {super.key,
      required this.post,
      this.showGroupAndCategory = true,
      this.showScheduledPost = false,
      this.isOwnPost = false});

  final bool? showGroupAndCategory;
  final bool? showScheduledPost;
  final TalkamPost post;

  /// Set by callers that already know every post they render is the
  /// logged-in user's own (e.g. the profile's own posts tab) — the only
  /// reliable signal for that on an anonymous post, since the backend
  /// nulls `post.user` for anonymous content and `post.user.id` collapses
  /// to the placeholder `PostCreator.anonymous()` (id 0) either way.
  final bool isOwnPost;

  @override
  State<PostItem> createState() => _PostItemState();
}

class _PostItemState extends State<PostItem> {
  // Deleting a post shouldn't force a refetch of whatever feed/list this
  // item lives in — the item just removes itself from view immediately.
  bool _deleted = false;

  final AdsCubit adsCubit = AdsCubit(injector.get());

  bool get showGroupAndCategory => widget.showGroupAndCategory ?? true;
  bool get showScheduledPost => widget.showScheduledPost ?? false;
  TalkamPost get post => widget.post;

  @override
  Widget build(BuildContext context) {
    if (_deleted) return const SizedBox.shrink();

    return InkWell(
      onTap: () {
        // Mock posts don't exist on the real backend — pass the post object
        // directly so the detail screen skips the network fetch for it.
        context.pushNamed(
          PageUrl.postDetailsScreen,
          extra: MockHomeData.isMockPostId(post.id) ? post : post.id.toString(),
        );
      },
      child: Padding(
        padding: EdgeInsets.only(bottom: post.isPromoted ? 8.0 : 0, left: 0),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              decoration: BoxDecoration(
                  color: context.theme.cardColor,
                  borderRadius: BorderRadius.circular(10)),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 4.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            PostHeader(
                              showGroupAndCategory: showGroupAndCategory,
                              userName: userName,
                              post: post,
                              category: post.category,
                              onMenuTap: () async {
                                var isReported =
                                    await CustomDialogs.showCustomDialog(
                                        PostActionSheet(
                                          post: post,
                                          isOwnPost: widget.isOwnPost,
                                          onPostDeleted: () =>
                                              setState(() => _deleted = true),
                                        ),
                                        context);
                                if (isReported ?? false) {
                                  post.isReported = true;
                                }
                              },
                            ),
                            10.verticalSpace,
                            PostContent(
                              post: post,
                            ),
                            4.verticalSpace,
                            PostActions(
                              onCommentTap: () {
                                debugPrint(
                                    '=== [TALKAM LOG] POST COMMENT ICON TAPPED ===');
                                debugPrint('Post ID: ${post.id}');
                                debugPrint('Author Name: ${post.user.name}');
                                debugPrint(
                                    'Author Username: ${post.user.username}');
                                debugPrint('Is Anonymous: ${post.isAnonymous}');
                                debugPrint('Avatar Raw: "${post.user.avatar}"');
                                debugPrint(
                                    'Avatar Resolved: "${Helpers.getAvatar(post.user.avatar, isAnonymous: post.isAnonymous.toBool)}"');
                                debugPrint(
                                    'Title: "${post.title}", Body: "${post.body}"');
                                context.pushNamed(
                                  PageUrl.postDetailsScreen,
                                  extra: MockHomeData.isMockPostId(post.id)
                                      ? post
                                      : post.id.toString(),
                                );
                              },
                              onLikeTap: () {},
                              onShareTap: () {
                                adsCubit.savePostShareStat(post.id.toString());
                                Helpers.share(
                                    "${UrlConfig.webUrl}comment/${post.id}");
                              },
                              post: post,
                            ),
                            // Rendered here (inside the same horizontally-
                            // padded column as the header/content/actions
                            // above) and above the divider below, so it
                            // lines up with the rest of the card instead
                            // of running edge-to-edge underneath it.
                            ScheduledPostPill(
                                showScheduledPost: shouldShowScheduledPost,
                                post: post),
                          ],
                        )),
                    4.verticalSpace,
                    const Divider(thickness: 1),
                    if (post.isPromoted) 25.verticalSpace,
                  ],
                ),
              ),
            ),
            if (post.isPromoted)
              Positioned(
                  left: 0,
                  bottom: 0,
                  child: AdIndicator(
                    promoter: post.user.usersName,
                  )),
          ],
        ),
      ),
    );
  }

  bool get shouldShowScheduledPost =>
      showScheduledPost &&
      post.isSchedulePost &&
      (post.publishAt as DateTime).isAfter(DateTime.now());

  String get userName {
    if (!post.isAnonymous.toBool) return post.user.usersName;
    final isMine = widget.isOwnPost ||
        post.user.id == injector.get<ProfileBloc>().appUser?.id;
    return isMine ? "Anonymous (You)" : "Anonymous";
  }
}
