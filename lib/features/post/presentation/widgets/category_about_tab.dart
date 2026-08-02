import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/mock/mock_home_data.dart';
import 'package:talkam/core/navigation/route_url.dart';
import 'package:talkam/core/services/data/session_manager.dart';
import 'package:talkam/core/theme/pallets.dart';
import 'package:talkam/core/utils/guest_user_helper.dart';
import 'package:talkam/features/group/presentation/widgets/about_group_item.dart';
import 'package:talkam/features/post/data/models/get_categories_response.dart';
import 'package:talkam/gen/assets.gen.dart';

/// "Group Info" — a category's About tab. Member count, discoverability and
/// posting rules mirror the real Group feature's about tab; the "Created by"
/// persona is [MockHomeData.groupCreator] since categories have no real
/// ownership data yet.
class CategoryAboutTab extends StatelessWidget {
  const CategoryAboutTab({super.key, required this.category});

  final PostCategory category;

  @override
  Widget build(BuildContext context) {
    final creator = MockHomeData.groupCreator(category);
    final memberCount = MockHomeData.groupMemberCount(category);

    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const TextView(
              text: "Group Info", fontSize: 16, fontWeight: FontWeight.w700),
          18.verticalSpace,
          AboutGroupItem(
            icon: Assets.images.svgs.member,
            tittle: "Members",
            description: "$memberCount people are part of this group.",
          ),
          16.verticalSpace,
          AboutGroupItem(
            icon: Assets.images.svgs.keylock,
            tittle: "Discoverability",
            description: category.isPublic
                ? "Anyone can find and view this group."
                : "Only members can view content in this group.",
          ),
          16.verticalSpace,
          AboutGroupItem(
            icon: Assets.images.svgs.add,
            tittle: "Posts",
            description: "Only members who have joined can post to this group.",
          ),
          20.verticalSpace,
          RichText(
            text: TextSpan(
              style: GoogleFonts.nunito(
                  fontSize: 14.sp, color: Pallets.boldBlackV2),
              children: [
                const TextSpan(text: "Created by "),
                TextSpan(
                  text: "@${creator.username}",
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      GuestUserHelper.handleGuestUserAction(action: () {
                        if (SessionManager().isMe(creator.id.toString())) {
                          context.pushNamed(PageUrl.profileScreen);
                        } else {
                          context.pushNamed(PageUrl.userProfileScreen,
                              extra: creator.id.toString());
                        }
                      });
                    },
                  style: GoogleFonts.nunito(
                      color: Pallets.blueBubbleColor,
                      fontWeight: FontWeight.w700),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
