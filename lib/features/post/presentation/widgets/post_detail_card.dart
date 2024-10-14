import 'package:flutter/material.dart';
import 'package:talkam/common/widgets/custom_dialogs.dart';
import 'package:talkam/core/constants/package_exports.dart';
import 'package:talkam/core/services/network/url_config.dart';
import 'package:talkam/core/utils/extensions/context_extension.dart';
import 'package:talkam/core/utils/extensions/int_extension.dart';
import 'package:talkam/core/utils/helper_utils.dart';
import 'package:talkam/features/post/data/models/get_posts_response.dart';
import 'package:talkam/features/post/presentation/widgets/post_action_sheet.dart';
import 'package:talkam/features/post/presentation/widgets/post_content.dart';
import 'package:talkam/features/post/presentation/widgets/post_detail_action.dart';
import 'package:talkam/features/post/presentation/widgets/post_item_components.dart';

class PostDetailCard extends StatelessWidget {
  const PostDetailCard({super.key, required this.post});

  final TalkamPost post;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: context.theme.cardColor,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PostHeader(
              userName: userName,
              category: post.category,
              onMenuTap: () async {
                var isReported = await CustomDialogs.showBottomSheet(
                    context,
                    PostActionSheet(
                      post: post, onPostDeleted: () {
                        context.pop();
                    },
                    ));
                if (isReported ?? false) {
                  post.isReported = true;
                }
              },
              post: post,
            ),
            10.verticalSpace,
            PostContent(
              post: post,
            ),
            12.verticalSpace,
            const Divider(thickness: 1),
            10.verticalSpace,
            PostDetailActions(
              commentCount: post.commentsCount,
              likeCount: post.likesCount ?? 0,
              onCommentTap: () {},
              onLikeTap: () {},
              onShareTap: () {
                Helpers.share("${UrlConfig.webUrl}/comments/${post.id}");
              },
              dislikeCount: 3,
              post: post,
            ), //

            // Implement PostActions here
          ],
        ),
      ),
    );
  }

  String get userName =>
      post.isAnonymous.toBool ? "Anonymous" : post.user.usersName;
}

class CommentField extends StatelessWidget {
  const CommentField({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
