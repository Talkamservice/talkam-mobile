import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/constants/dialog_texts.dart';
import 'package:talkam/core/constants/package_exports.dart';
import 'package:talkam/core/theme/pallets.dart';

class ReportSuccessDialog extends StatelessWidget {
  const ReportSuccessDialog({super.key,});



  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 29),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextView(
            text: "We’ve received your report",
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
          ),
          20.verticalSpace,
          TextView(
            text: rreportSuccess1,
            style: GoogleFonts.poppins(),
          ),
          14.verticalSpace,
          TextView(
            text: reportSuccess2,
            style: GoogleFonts.poppins(),
          ),
          40.verticalSpace,
          Row(
            children: [
              TextButton(
                  onPressed: () {
                    context.pop();
                  },
                  child: TextView(
                    text: "Back",
                    color: Pallets.primary,
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  )),
              Spacer(),
              TextButton(
                  onPressed: () {
                    context.pop();
                  },
                  child: TextView(
                    text: "Done",
                    fontSize: 16,
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: Pallets.primary,
                    ),
                  )),

            ],
          )
        ],
      ),
    );
  }
}
