import 'package:flutter/material.dart';

import 'package:talkam/common/widgets/image_widget.dart';
import 'package:talkam/common/widgets/text_view.dart';

import 'package:talkam/core/constants/package_exports.dart';

import 'package:talkam/core/navigation/route_url.dart';
import 'package:talkam/core/theme/pallets.dart';

import 'package:talkam/core/utils/extensions/context_extension.dart';
import 'package:talkam/features/ads/presentation/screens/empty_ad_page.dart';
import 'package:talkam/features/ads/presentation/screens/ads_review_screen.dart';

import 'package:talkam/features/post/dormain/mixins/refresh_posts_mixin.dart';

import 'package:talkam/gen/assets.gen.dart';

class MyProfileSheet extends StatelessWidget with RefreshPostsMixin {
  MyProfileSheet({
    super.key,
  });

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
            imagePath: Assets.images.svgs.icPersonEdit,
            tittle: "Edit Profile",
            onTap: () {
              context.pop();
              context.pushNamed(PageUrl.editProfileScreen);
            },
          ),
          _PostAction(
            imagePath: Assets.images.svgs.bellPlus,
            tittle: "My Scheduled posts",
            onTap: () {
              context.pop();
              context.pushNamed(PageUrl.userScheduledPosts);
            },
          ),
          // _PostAction(
          //   imagePath: Assets.images.svgs.infoCircle,
          //
          //   iconColor: Pallets.black,
          //   tittle: "Ads",
          //   onTap: () {
          //     context.pop();
          //     context.pushNamed(PageUrl.adsPage);
          //
          //
          //
          //
          //   },5531 8866 5214 2950
          // ),
        ],
      ),
    );
  }
}

class _PostAction extends StatelessWidget {
  const _PostAction({super.key, required this.imagePath, required this.tittle, required this.onTap, this.iconColor});

  final String imagePath;
  final String tittle;
  final VoidCallback onTap;
  final Color? iconColor;

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
                ImageWidget(imageUrl: imagePath,color: iconColor,),
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
