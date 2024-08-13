import 'package:flutter/material.dart';
import 'package:talkam/common/widgets/custom_button.dart';
import 'package:talkam/common/widgets/image_widget.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/constants/dialog_texts.dart';
import 'package:talkam/core/constants/package_exports.dart';
import 'package:talkam/core/navigation/route_url.dart';
import 'package:talkam/gen/assets.gen.dart';

class CreateGroupSuccessScreen extends StatefulWidget {
  const CreateGroupSuccessScreen({super.key});

  @override
  State<CreateGroupSuccessScreen> createState() =>
      _CreateGroupSuccessScreenState();
}

class _CreateGroupSuccessScreenState extends State<CreateGroupSuccessScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const TextView(text: groupCreatedText),
            30.verticalSpace,
            CustomButton(
              onPressed: () {
                context.goNamed(PageUrl.groups);
              },
              text: "Continue",
            )
          ],
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ImageWidget(
                imageUrl: Assets.images.png.sports.path,
                size: 100,
              ),
              16.verticalSpace,
              const TextView(
                text: "Dating Advice",
                fontWeight: FontWeight.w500,
                fontSize: 20,
              ),
              16.verticalSpace,
              const TextView(
                align: TextAlign.center,
                text:
                    "We’re a small group of people seeking to help the next person with dating advice and counsel. Please be respectful.",
                fontSize: 16,
              )
            ],
          ),
        ),
      ),
    );
  }
}
