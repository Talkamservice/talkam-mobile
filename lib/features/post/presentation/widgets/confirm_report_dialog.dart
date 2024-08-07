import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/constants/dialog_texts.dart';
import 'package:talkam/core/constants/package_exports.dart';
import 'package:talkam/core/theme/pallets.dart';

class ConfirmReportDialog extends StatelessWidget {
  const ConfirmReportDialog({super.key, required this.reason});

  final String reason;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 29),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextView(
            text: "Report as $reason ?",
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
          ),
          20.verticalSpace,
          TextView(
            text: blockUserPrompt,
            style: GoogleFonts.poppins(),
          ),
          14.verticalSpace,
          TextView(
            text: blockUserPrompt2,
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
                    text: "Cancel",
                    fontSize: 16,
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: Pallets.primary,
                    ),
                  )),
              TextButton(
                  onPressed: () {
                    context.pop(true);
                  },
                  child: TextView(
                    text: "Report",
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: Pallets.red,
                    ),
                  )),
            ],
          )
        ],
      ),
    );
  }
}
