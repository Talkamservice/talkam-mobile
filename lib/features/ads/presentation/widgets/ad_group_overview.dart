import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:talkam/common/widgets/custom_dialogs.dart';
import 'package:talkam/common/widgets/image_widget.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/navigation/route_url.dart';
import 'package:talkam/core/theme/pallets.dart';
import 'package:talkam/features/ads/presentation/widgets/promotion_sheet.dart';
import 'package:talkam/features/group/presentation/widgets/join_group_button.dart';
import 'package:talkam/features/search/data/models/get_group_response.dart';
import 'package:talkam/features/subscription/presentation/widgets/subscription_plan_card.dart';
import 'package:talkam/features/subscription/utils/subscription_helper.dart';
import 'package:talkam/gen/assets.gen.dart';

class AdGroupOverView extends StatelessWidget {
  const AdGroupOverView({
    super.key,
    this.showAbout = true,
    required this.data,
  });

  final TalkamGroup data;

  final bool? showAbout;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(

          children: [
            ImageWidget(
              imageUrl: data.category?.iconImage??Assets.images.png.appIcon.path,
              size: 40,
              fit: BoxFit.cover,
            ),
            10.horizontalSpace,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      TextView(
                        text: data.name??"",
                        fontSize: 16,
                      ),
                      8.horizontalSpace,
                      SizedBox(
                        width: 40,
                        height: 25,
                        child: TextButton(
                            style: TextButton.styleFrom(
                                padding: EdgeInsets.zero, shape: StadiumBorder(), backgroundColor: Pallets.adIndicator, foregroundColor: Pallets.black),
                            onPressed: () {},
                            child: TextView(
                              text: "Ad",
                              fontWeight: FontWeight.w700,
                              fontSize: 12,
                            )),
                      )

                    ],
                  ),
                  // 2.verticalSpace,
                  TextView(
                    text: formatFollowersCount(data.totalMembers??0),
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                  ),
                ],
              ),
            ),
            JoinGroupButton(
              group: data,
              onStateChanged: () {},
            )
          ],
        ),
        13.verticalSpace,
        TextView(
          text: data.about.toString(),
        )
      ],
    );
  }
}

formatFollowersCount(totalMembers) {
  if (totalMembers >= 1000) {
    return '${(totalMembers / 1000).toFixed(1)}k';
  } else if (totalMembers <= 1) {
    return "${totalMembers.toString()} Follower";
  } else {
    return "${totalMembers.toString()} Followers";
  }
}
