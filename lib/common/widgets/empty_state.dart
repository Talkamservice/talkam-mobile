import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:talkam/common/widgets/custom_button.dart';
import 'package:talkam/common/widgets/document_upload_tile.dart' show DottedBox;
import 'package:talkam/common/widgets/image_widget.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/theme/pallets.dart';

/// Generic "nothing here yet" placeholder — dashed box + title/subtitle +
/// an optional full-width retry CTA. Same public API as before (11 call
/// sites across messaging/groups/notifications/profile), only the internal
/// rendering changed.
class EmptyState extends StatelessWidget {
  const EmptyState({
    super.key,
    this.title,
    this.subtitle,
    this.imageUrl,
    this.canTryAgain = false,
    this.retryText,
    this.onTap,
  });

  final String? title;
  final String? subtitle;

  /// Unused for now — the placeholder box renders a generic icon rather than
  /// a caller-supplied image. Kept for backwards compatibility with existing
  /// call sites that still pass it.
  final String? imageUrl;
  final String? retryText;
  final bool? canTryAgain;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ImageWidget(
              imageUrl: imageUrl ?? ""
          ),
          20.verticalSpace,
          TextView(
            text: title ?? 'No activity to show!',
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: Pallets.boldBlackV2,
            align: TextAlign.center,
          ),
          if (subtitle?.isNotEmpty ?? false) ...[
            8.verticalSpace,
            TextView(
              text: subtitle!,
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Pallets.grey400,
              align: TextAlign.center,
              lineHeight: 1.4,
            ),
          ],
          if (canTryAgain ?? false) ...[
            20.verticalSpace,
            CustomButton(
              elevation: 0,
              onPressed: onTap,
              bgColor: Pallets.blueBubbleColor,
              child: TextView(
                text: retryText ?? "Retry",
                fontSize: 15,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
