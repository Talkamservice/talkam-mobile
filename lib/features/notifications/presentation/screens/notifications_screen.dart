import 'package:flutter/material.dart';
import 'package:talkam/common/widgets/custom_appbar.dart';
import 'package:talkam/common/widgets/custom_button.dart';
import 'package:talkam/common/widgets/custom_dialogs.dart';
import 'package:talkam/common/widgets/image_widget.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/constants/package_exports.dart';
import 'package:talkam/core/mock/mock_home_data.dart';
import 'package:talkam/core/theme/pallets.dart';
import 'package:talkam/core/utils/extensions/context_extension.dart';
import 'package:talkam/gen/assets.gen.dart';

/// Purely mock-data screen — staging has no notifications backend seeded
/// yet, so this intentionally never touches NotificationsBloc.
class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        tittleText: "Notification",
        centerTile: false,
        titleAlign: TextAlign.left,
        showDivider: true,
        actions: [
          TextButton(
            onPressed: () => CustomDialogs.success('All notifications read'),
            child: const TextView(
              text: "Mark all read",
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Pallets.blueBubbleColor,
            ),
          ),
          8.horizontalSpace,
        ],
      ),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          children: [
            for (final group in MockHomeData.notificationGroups) ...[
              Align(
                alignment: Alignment.centerLeft,
                child: _DayChip(label: group.label),
              ),
              12.verticalSpace,
              for (final item in group.items) ...[
                _NotificationCard(item: item),
                12.verticalSpace,
              ],
              8.verticalSpace,
            ],
          ],
        ),
      ),
    );
  }
}

class _DayChip extends StatelessWidget {
  const _DayChip({required this.label});

  final String label;

  bool get _isToday => label == "Today";

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 6.h),
      decoration: BoxDecoration(
        border: Border.all(color: context.colorScheme.onSurface.withValues(alpha: 0.07)),
        color: _isToday ? Pallets.blueBubbleColor : Pallets.grey90,
        borderRadius: BorderRadius.circular(100),
      ),
      child: TextView(
        text: label,
        fontSize: 13,
        fontWeight: FontWeight.w600,
        color: _isToday ? Colors.white : Pallets.boldBlackV2,
      ),
    );
  }
}

class _NotificationCard extends StatelessWidget {
  const _NotificationCard({required this.item});

  final MockNotificationItem item;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: Pallets.grey90.withValues(alpha: 0.4),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: Pallets.grey90),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 40.w,
            height: 40.w,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: _bgColor.withValues(alpha: 0.05),
                shape: BoxShape.circle),
            child: ImageWidget(imageUrl: _iconUrl, size: 24, color: _bgColor),
          ),
          10.horizontalSpace,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextView(
                  text: item.title,
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                ),
                4.verticalSpace,
                TextView(
                  text: item.body,
                  fontSize: 13,
                  color: Pallets.grey400,
                  maxLines: 1,
                  textOverflow: TextOverflow.ellipsis,
                ),
                if (item.actionLabel != null) ...[
                  10.verticalSpace,
                  CustomButton(
                    isExpanded: false,
                    elevation: 0,
                    bgColor: Pallets.blueBubbleColor,
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
                    onPressed: () => CustomDialogs.showToast("Coming soon"),
                    child: TextView(
                        text: item.actionLabel!,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 13),
                  ),
                ],
              ],
            ),
          ),
          8.horizontalSpace,
          TextView(text: item.timeAgo, fontSize: 12, color: Pallets.grey60),
        ],
      ),
    );
  }

  String get _iconUrl {
    switch (item.type) {
      case MockNotificationType.session:
        return Assets.images.svgV2.calendarInActive;
      case MockNotificationType.comment:
        return Assets.images.svgV2.commentIcon;
      case MockNotificationType.like:
        return Assets.images.svgV2.likeIcon;
      case MockNotificationType.message:
      case MockNotificationType.wellness:
        return Assets.images.svgV2.user2;
    }
  }

  Color get _bgColor {
    switch (item.type) {
      case MockNotificationType.session:
        return Pallets.blueBubbleColor;
      case MockNotificationType.comment:
        return Colors.orange;
      case MockNotificationType.like:
        return Colors.pink;
      case MockNotificationType.message:
        return Colors.green;
      case MockNotificationType.wellness:
        return Pallets.blueBubbleColor;
    }
  }
}
