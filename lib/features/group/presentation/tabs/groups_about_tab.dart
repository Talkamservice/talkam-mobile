import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:talkam/common/widgets/image_widget.dart';
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
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            16.verticalSpace,
            const TextView(
              text: "Group Info",
              fontWeight: FontWeight.w700,
              fontSize: 18,
            ),
            12.verticalSpace,
            if (widget.data.about != null && widget.data.about!.isNotEmpty) ...[
              TextView(text: widget.data.about.toString(), fontSize: 14),
              24.verticalSpace,
            ],
            _buildInfoRow(
              icon: Assets.images.svgV2.userMultiple,
              text: "Only Community members can post.",
            ),
            16.verticalSpace,
            _buildInfoRow(
              icon: Assets.images.svgV2.global,
              text: widget.data.isPublic
                  ? "All Communities are publicly visible. Anyone can join this Community"
                  : privateGroupDiscoverText,
            ),
            16.verticalSpace,
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ImageWidget(imageUrl: Assets.images.svgV2.calendarInActive, size: 24),
                12.horizontalSpace,
                Expanded(
                  child: RichText(
                    text: TextSpan(
                      style: GoogleFonts.nunito(
                        color: context.colorScheme.onSurface,
                        fontSize: 14,
                      ),
                      children: [
                        TextSpan(
                          text: "Created ${TimeUtil.formatDate((widget.data.createdAt ?? DateTime.now()).toIso8601String())} by ",
                        ),
                        TextSpan(
                          text: "@${widget.data.owner?.username ?? 'Anonymous'}",
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              if (widget.data.owner == null) return;
                              GuestUserHelper.handleGuestUserAction(action: () {
                                if (SessionManager().isMe(widget.data.owner!.id.toString())) {
                                  context.pushNamed(PageUrl.profileScreen);
                                } else {
                                  context.pushNamed(
                                    PageUrl.userProfileScreen,
                                    extra: widget.data.owner?.id.toString(),
                                  );
                                }
                              });
                            },
                          style: GoogleFonts.nunito(
                            color: Pallets.primary,
                            fontWeight: FontWeight.w700,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            32.verticalSpace,
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow({required String icon, required String text}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ImageWidget(imageUrl: icon, size: 24),
        12.horizontalSpace,
        Expanded(
          child: TextView(
            text: text,
            fontSize: 14,
          ),
        ),
      ],
    );
  }
}

