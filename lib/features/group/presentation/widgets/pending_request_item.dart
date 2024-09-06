import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:talkam/common/widgets/image_widget.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/navigation/route_url.dart';
import 'package:talkam/core/services/data/session_manager.dart';
import 'package:talkam/core/theme/pallets.dart';
import 'package:talkam/core/utils/guest_user_helper.dart';
import 'package:talkam/features/group/data/models/get_pending_requests_response.dart';
import 'package:talkam/features/group/presentation/tabs/preview_rules_tab.dart';
import 'package:talkam/gen/assets.gen.dart';

enum RequestAction { Approved, Declined }

class PendingRequestItem extends StatelessWidget {
  const PendingRequestItem({super.key, required this.pendingRequest, required this.onRequestAction});

  final PendingRequest pendingRequest;
  final Function(RequestAction) onRequestAction;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        GuestUserHelper.handleGuestUserAction(
          action: () {
            if (SessionManager().isMe(pendingRequest.user.id.toString())) {
              context.pushNamed(PageUrl.profileScreen, extra: pendingRequest.user.id.toString());
            } else {
              context.pushNamed(PageUrl.userProfileScreen);
            }
          },
        );
      },
      child: Row(
        children: [
          ImageWidget(imageUrl: Assets.images.svgs.member),
          10.horizontalSpace,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextView(
                  text: getDisplayName,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ],
            ),
          ),
          InkWell(
            onTap: () {
              onRequestAction(RequestAction.Declined);
            },
            child: const TalkamCircularBorder(
                borderColor: Pallets.red,
                child: Icon(
                  Icons.close,
                  color: Pallets.red,
                )),
          ),
          16.horizontalSpace,
          InkWell(
            onTap: () {
              onRequestAction(RequestAction.Approved);
            },
            child: const TalkamCircularBorder(
                borderColor: Pallets.successGreen,
                child: Icon(
                  Icons.check,
                  color: Pallets.successGreen,
                )),
          ),
        ],
      ),
    );
  }

  String get getDisplayName => (pendingRequest.user.name).isNotEmpty
      ? pendingRequest.user.name
      : (pendingRequest.user.username.isNotEmpty)
          ? pendingRequest.user.username
          : pendingRequest.user.email;
}
