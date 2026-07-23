import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/theme/pallets.dart';

/// Placeholder avatars used when the avatars endpoint returns nothing.
///
/// TEMPORARY — replace with the real illustrated avatar set once the backend
/// serves them. Nothing here is uploaded; picking one only stores the emoji
/// character, which the profile update will reject as an avatar url.
const List<String> kFallbackAvatarEmojis = [
  '🙂', '😌', '😎', '🤗', '🥰',
  '🧑', '👩', '👨', '🧓', '👧',
  '🦊', '🐼', '🐨', '🐯', '🦉',
  '🌻', '🌙', '⭐', '🌊', '🔥',
  '🎧', '🎨', '📚', '⚽', '🎸',
];

/// True when [value] is one of the placeholder emojis rather than an image url.
bool isFallbackAvatar(String? value) =>
    value != null && kFallbackAvatarEmojis.contains(value);

/// Amber banner flagging that the avatars on screen are local placeholders.
class AvatarFallbackNotice extends StatelessWidget {
  const AvatarFallbackNotice({
    super.key,
    required this.reason,
    this.onRetry,
  });

  final String reason;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: Pallets.transparentOrage,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Pallets.noticeAmber, width: 1),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.info_outline_rounded,
              size: 18.sp, color: Pallets.noticeAmber),
          10.horizontalSpace,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const TextView(
                  text: 'Showing placeholder avatars',
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: Pallets.boldBlackV2,
                ),
                2.verticalSpace,
                const TextView(
                  text:
                      'These are mock emojis — they cannot be saved to your profile.',
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: Pallets.grey400,
                  lineHeight: 1.4,
                ),
                4.verticalSpace,
                TextView(
                  text: reason,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: Pallets.grey500,
                  lineHeight: 1.4,
                ),
                if (onRetry != null) ...[
                  6.verticalSpace,
                  TextView(
                    text: 'Retry',
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: Pallets.blueBubbleColor,
                    onTap: onRetry,
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
