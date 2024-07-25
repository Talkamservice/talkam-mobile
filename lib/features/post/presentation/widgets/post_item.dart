import 'package:flutter/material.dart';
import 'package:talkam/common/widgets/custom_dialogs.dart';
import 'package:talkam/core/constants/package_exports.dart';
import 'package:talkam/core/di/injector.dart';
import 'package:talkam/core/navigation/route_url.dart';
import 'package:talkam/core/utils/extensions/context_extension.dart';
import 'package:talkam/core/utils/extensions/int_extension.dart';
import 'package:talkam/features/post/data/models/get_posts_response.dart';
import 'package:talkam/features/post/data/models/post_filter_model.dart';
import 'package:talkam/features/post/presentation/bloc/featured_posts/featured_post_cubit.dart';
import 'package:talkam/features/post/presentation/widgets/post_action_sheet.dart';
import 'package:talkam/features/post/presentation/widgets/post_content.dart';
import 'package:talkam/features/post/presentation/widgets/post_item_components.dart';

class PostItem extends StatelessWidget {
  const PostItem({super.key, required this.post});

  final TalkamPost post;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.pushNamed(PageUrl.postDetailsScreen, extra: post);
      },
      child: Container(
        color: context.theme.cardColor,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              PostHeader(
                userName: userName,
                post: post,
                category: post.category,
                onMenuTap: () => CustomDialogs.showBottomSheet(
                    context,
                    PostActionSheet(
                      post: post,
                    )),
              ),
              10.verticalSpace,
              PostContent(
                post: post,
              ),

              12.verticalSpace,
              const Divider(thickness: 1),
              10.verticalSpace,
              PostActions(
                onCommentTap: () {},
                onLikeTap: () {},
                onShareTap: () {},
                post: post,
              ), // Implement PostActions here
            ],
          ),
        ),
      ),
    );
  }

  String get userName =>
      post.isAnonymous.toBool ? "Anonymous" : post.user.usersName;
}
