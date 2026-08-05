import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:talkam/common/widgets/custom_button.dart';
import 'package:talkam/common/widgets/image_widget.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/navigation/route_url.dart';
import 'package:talkam/core/services/data/session_manager.dart';
import 'package:talkam/core/theme/pallets.dart';
import 'package:talkam/gen/assets.gen.dart';

class LogoutDialog extends StatelessWidget {
  const LogoutDialog({super.key});

  static Future<void> show(BuildContext context) {
    return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => const LogoutDialog(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24.r)),
      backgroundColor: Colors.white,
      insetPadding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Padding(
        padding: EdgeInsets.all(24.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Close icon at top right
            Align(
              alignment: Alignment.topRight,
              child: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Icon(
                  Icons.close,
                  size: 20.r,
                  color: Pallets.boldBlackV2,
                ),
              ),
            ),

            8.verticalSpace,

            // Red icon inside light red circular container
            Container(
              width: 60.w,
              height: 60.w,
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                color: Color(0xFFFFF0F0),
                shape: BoxShape.circle,
              ),
              child: ImageWidget(
                imageUrl: Assets.images.svgV2.userInActive,
                color: const Color(0xFFFF4D4D),
                width: 32.w,
                height: 32.w,
              ),
            ),

            20.verticalSpace,

            // Confirmation message
            const TextView(
              text: "Please confirm if you wish to log out of your account.",
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Pallets.boldBlackV2,
              align: TextAlign.center,
              lineHeight: 1.4,
            ),

            8.verticalSpace,

            // Subtitle text
            const TextView(
              text: "You will need to sign in again to access your account",
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: Pallets.grey400,
              align: TextAlign.center,
            ),

            28.verticalSpace,

            // Action Buttons: Cancel & Logout
            Row(
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const TextView(
                      text: "Cancel",
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Pallets.blueBubbleColor,
                    ),
                  ),
                ),
                16.horizontalSpace,
                Expanded(
                  child: CustomButton(
                    onPressed: () {
                      Navigator.pop(context);
                      SessionManager.instance.logOut();
                      context.goNamed(PageUrl.login);
                    },
                    bgColor: const Color(0xFFFF4D4D),
                    elevation: 0,
                    child: const TextView(
                      text: "Logout",
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
