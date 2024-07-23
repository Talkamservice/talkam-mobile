import 'package:flutter/material.dart';
import 'package:talkam/core/constants/package_exports.dart';
import 'package:talkam/features/profile/presentation/widgets/profile_post_item_tile.dart';

class ProfilePostTab extends StatefulWidget {
  const ProfilePostTab({super.key});

  @override
  State<ProfilePostTab> createState() => _ProfilePostTabState();
}

class _ProfilePostTabState extends State<ProfilePostTab> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: EdgeInsets.only(top: 20.0.h),
      children: [
        for (int i = 0; i < 4; i++) ...[
          Padding(
            padding:  EdgeInsets.only(left: 12.w),
            child: ProfilePostItemTile(
              leading: Container(),
              groupName: "Hello",
              formattedPostTime: "13hrs",
              postContent: "Hello World!!",
              postTitle: "postTitle",
            ),
          ),
          24.verticalSpace,
        ]
      ],
    );
  }
}
