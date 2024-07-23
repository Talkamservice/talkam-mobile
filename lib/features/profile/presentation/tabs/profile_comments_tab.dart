import 'package:flutter/material.dart';
import 'package:talkam/core/constants/package_exports.dart';
import 'package:talkam/features/profile/presentation/widgets/profile_comment_tile.dart';

class ProfileCommentsTab extends StatefulWidget {
  const ProfileCommentsTab({super.key});

  @override
  State<ProfileCommentsTab> createState() => _ProfileCommentsTabState();
}

class _ProfileCommentsTabState extends State<ProfileCommentsTab> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: EdgeInsets.only(top: 20.0.h),
      children: [
        for (int i = 0; i < 4; i++) ...[
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            child: const ProfileCommentTile(),
          ),
          24.verticalSpace,
        ]
      ],
    );
  }
}
