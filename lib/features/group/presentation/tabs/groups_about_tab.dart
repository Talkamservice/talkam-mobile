import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/_core.dart';
import 'package:talkam/core/constants/dialog_texts.dart';
import 'package:talkam/core/navigation/route_url.dart';
import 'package:talkam/core/services/data/session_manager.dart';
import 'package:talkam/core/theme/pallets.dart';
import 'package:talkam/core/utils/extensions/context_extension.dart';
import 'package:talkam/core/utils/guest_user_helper.dart';
import 'package:talkam/features/group/presentation/widgets/about_group_item.dart';
import 'package:talkam/features/search/data/models/get_group_response.dart';
import 'package:talkam/gen/assets.gen.dart';

class GroupsAboutTab extends StatefulWidget {
  const GroupsAboutTab({super.key, required this.data});

  final TalkamGroup data;

  @override
  State<GroupsAboutTab> createState() => _GroupsAboutTabState();
}

class _GroupsAboutTabState extends State<GroupsAboutTab> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            24.verticalSpace,
            TextView(
              text: "Group Info",
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: context.colorScheme.onSurface,
            ),
            12.verticalSpace,
            TextView(
              text: widget.data.about.toString(),
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: context.colorScheme.onSurface,
              lineHeight: 1.4,
            ),
            24.verticalSpace,
            AboutGroupItem(
              icon: Assets.images.svgV2.userMultiple,
              description: "Only Community members can post.",
            ),
            16.verticalSpace,
            AboutGroupItem(
              icon: Assets.images.svgV2.global,
              description: widget.data.isPublic
                  ? "All Communities are publicly visible. Anyone can join this Community"
                  : "Private groups are not publicly visible.",
            ),
            16.verticalSpace,
            AboutGroupItem(
              icon: Assets.images.svgV2.calendarInActive,
              descriptionWidget: RichText(
                  text: TextSpan(
                      style: GoogleFonts.nunito(
                          color: context.colorScheme.onSurface,
                          fontSize: 14.sp),
                      children: [
                    TextSpan(
                        text:
                            "Created ${TimeUtil.formatDate((widget.data.createdAt ?? DateTime.now()).toIso8601String())} by "),
                    TextSpan(
                        text: "@${widget.data.owner?.username ?? ''}",
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            GuestUserHelper.handleGuestUserAction(action: () {
                              if (SessionManager()
                                  .isMe(widget.data.owner!.id.toString())) {
                                context.pushNamed(PageUrl.profileScreen);
                              } else {
                                context.pushNamed(PageUrl.userProfileScreen,
                                    extra: widget.data.owner?.id.toString());
                              }
                            });
                          },
                        style: GoogleFonts.nunito(
                            color: Pallets.blueBubbleColor,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600)),
                  ])),
            ),
            24.verticalSpace
          ],
        ),
      ),
    );
  }
}
