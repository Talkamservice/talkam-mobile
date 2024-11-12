import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:talkam/features/ads/presentation/widgets/ad_group_header.dart';
import 'package:talkam/features/ads/presentation/widgets/ad_group_overview.dart';
import 'package:talkam/features/search/data/models/get_group_response.dart';


class AdGroupResultItem extends StatelessWidget {
  const AdGroupResultItem({super.key, required this.group, required this.onJoinStateChanged, this.imageRadius});

  final TalkamGroup group;
  final BorderRadius? imageRadius;

  final Function() onJoinStateChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [

        AdGroupHeader(
          group: group,
          imageRadius: imageRadius,
          onStateChanged: () {},
        ),
        8.verticalSpace,
        AdGroupOverView(data: group)
      ],
    );
  }

}
