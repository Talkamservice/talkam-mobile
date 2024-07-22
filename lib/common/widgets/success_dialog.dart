import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:talkam/common/widgets/custom_button.dart';
import 'package:talkam/common/widgets/image_widget.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/constants/package_exports.dart';
import 'package:talkam/core/theme/pallets.dart';

class SuccessDialog extends StatelessWidget {
  const SuccessDialog(
      {Key? key, required this.tittle, required this.onClose, this.btnText})
      : super(key: key);
  final String tittle;
  final String? btnText;
  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(17),
      child: Container(
        decoration: BoxDecoration(
            color: Pallets.white, borderRadius: BorderRadius.circular(21)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 49,
                height: 5,
                decoration: ShapeDecoration(
                  color: const Color(0xFFBCC4CC),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(42),
                  ),
                ),
              ),
              37.verticalSpace,
              const ImageWidget(
                imageUrl: "Assets.images.svgs.success",
              ),
              10.verticalSpace,
              TextView(
                text: tittle,
                align: TextAlign.center,
                style: GoogleFonts.fraunces(
                    fontSize: 20.sp, fontWeight: FontWeight.w600),
              ),
              20.verticalSpace,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomButton(
                    child: const Text('data'),
                    onPressed: () {},
                  )
                ],
              ),
              17.verticalSpace,
            ],
          ),
        ),
      ),
    );
  }
}
