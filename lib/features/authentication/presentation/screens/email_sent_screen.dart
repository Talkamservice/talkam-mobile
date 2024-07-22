import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:talkam/common/widgets/custom_appbar.dart';
import 'package:talkam/common/widgets/image_widget.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/constants/package_exports.dart';
import 'package:talkam/core/navigation/route_url.dart';
import 'package:talkam/core/utils/extensions/context_extension.dart';
import 'package:talkam/gen/assets.gen.dart';

class EmailSentScreen extends StatefulWidget {
  const EmailSentScreen({super.key});

  @override
  State<EmailSentScreen> createState() => _EmailSentScreenState();
}

class _EmailSentScreenState extends State<EmailSentScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        fgColor: context.colorScheme.onSurface,
        tittle: ImageWidget(imageUrl: Assets.images.svgs.logo2),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          18.verticalSpace,
          const Center(
            child: TextView(
              text: "Password Recovery",
              fontWeight: FontWeight.w700,
              fontSize: 24,
            ),
          ),
          4.verticalSpace,
          const TextView(
              align: TextAlign.center,
              text:
                  "We’ve sent password reset instructions to your email address"),
          33.verticalSpace,
          ImageWidget(
            imageUrl: Assets.images.svgs.emailsent,
            size: 163,
          ),
          42.verticalSpace,
          Center(
            child: TextButton(
              onPressed: () {
                context.goNamed(PageUrl.login);
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextView(
                    text: "Back to",
                    color: context.colorScheme.onSurface,
                  ),
                  TextView(
                    text: " Login",
                    fontWeight: FontWeight.w700,
                    color: context.colorScheme.primary,
                  ),
                ],
              ),
            ),
          )
        ]),
      ),
    );
  }
}
