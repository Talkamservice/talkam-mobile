import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:talkam/common/widgets/custom_dialogs.dart';
import 'package:talkam/common/widgets/image_widget.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/theme/pallets.dart';
import 'package:talkam/features/post/presentation/widgets/rules_sheet.dart';
import 'package:talkam/gen/assets.gen.dart';

class RulesButton extends StatelessWidget {
  const RulesButton({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
        style: TextButton.styleFrom(
            backgroundColor: Pallets.borderGrey.withOpacity(0.2),
            shape: const StadiumBorder(
                side: BorderSide(color: Pallets.borderGrey)),
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10)),
        onPressed: () {
          CustomDialogs.showBottomSheet(context, const RulesSheet());

        },
        child: Row(
          children: [
            ImageWidget(imageUrl: Assets.images.svgs.rules),
            10.horizontalSpace,
            const TextView(
              text: "Rules",
              fontSize: 14,
              // color: context.colorScheme.onSurface,
              fontWeight: FontWeight.w600,
            ),
          ],
        ));
  }
}
