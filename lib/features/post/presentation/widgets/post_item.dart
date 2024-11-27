import 'package:flutter/material.dart';
import 'package:talkam/common/widgets/custom_dialogs.dart';
import 'package:talkam/core/_core.dart';
import 'package:talkam/core/constants/package_exports.dart';
import 'package:talkam/core/di/injector.dart';
import 'package:talkam/core/navigation/route_url.dart';
import 'package:talkam/core/services/network/url_config.dart';
import 'package:talkam/core/utils/extensions/context_extension.dart';
import 'package:talkam/core/utils/extensions/int_extension.dart';
import 'package:talkam/features/ads/data/models/update_stat_payload.dart';
import 'package:talkam/features/ads/presentation/blocs/ads/ads_cubit.dart';
import 'package:talkam/features/ads/presentation/widgets/ad_indicator.dart';
import 'package:talkam/features/post/data/models/get_posts_response.dart';
import 'package:talkam/features/post/presentation/widgets/post_action_sheet.dart';
import 'package:talkam/features/post/presentation/widgets/post_content.dart';
import 'package:talkam/features/post/presentation/widgets/post_item_components.dart';
import 'package:talkam/features/post/presentation/widgets/scheduled_post_pill.dart';

class PostItem extends StatelessWidget {
  PostItem({super.key, required this.post, this.showGroupAndCategory = true, this.showScheduledPost = false});

  final bool? showGroupAndCategory;
  final bool? showScheduledPost;
  final TalkamPost post;

  final AdsCubit adsCubit = AdsCubit(injector.get());

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.pushNamed(PageUrl.postDetailsScreen, extra: post.id.toString());
      },
      child: Padding(
        padding: EdgeInsets.only(bottom: post.isPromoted ? 8.0 : 0, left: 0),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              decoration: BoxDecoration(color: context.theme.cardColor, borderRadius: BorderRadius.circular(10)),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    PostHeader(
                      showGroupAndCategory: showGroupAndCategory,
                      userName: userName,
                      post: post,
                      category: post.category,
                      onMenuTap: () async {
                        var isReported = await CustomDialogs.showBottomSheet(
                            context,
                            PostActionSheet(
                              post: post,
                              onPostDeleted: () {},
                            ));
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
                    const Divider(thickness: 1),
                    4.verticalSpace,

                    PostActions(
                      onCommentTap: () {},
                      onLikeTap: () {},
                      onShareTap: () {
                        adsCubit.updateStats(UpdateStatPayLoad(postId: post.id,shares: true));
                        Helpers.share("${UrlConfig.webUrl}comment/${post.id}");
                      },
                      post: post,
                    ),
                    if (!showScheduledPost! && post.isPromoted) 25.verticalSpace,

                    if (showScheduledPost!) 4.verticalSpace,
                    if (shouldShowScheduledPost) const Divider(thickness: 1),
                    // 3.verticalSpace,
                    ScheduledPostPill(showScheduledPost: shouldShowScheduledPost, post: post),
                    if (showScheduledPost! && post.isPromoted) 25.verticalSpace
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

  bool get shouldShowScheduledPost => showScheduledPost! && post.isSchedulePost && (post.publishAt as DateTime).isAfter(DateTime.now());

  String get userName => post.isAnonymous.toBool ? "Anonymous" : post.user.usersName;
}
