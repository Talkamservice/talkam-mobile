import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:talkam/common/widgets/custom_button.dart';
import 'package:talkam/common/widgets/image_widget.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/constants/package_exports.dart';
import 'package:talkam/core/theme/pallets.dart';
import 'package:talkam/core/utils/extensions/context_extension.dart';

class TermsScreen extends StatefulWidget {
  const TermsScreen({super.key});

  @override
  State<TermsScreen> createState() => _TermsScreenState();
}

class _TermsScreenState extends State<TermsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
        child: CustomButton(
          child: const TextView(
            text: 'I ACCEPT',
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
          onPressed: () {
            // context.pushNamed(PageUrl.bioInformation);
          },
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            children: [
              42.verticalSpace,
              Center(
                child: CircleAvatar(
                  radius: 50.r,
                  backgroundColor: Pallets.onboardingTextWhite.withOpacity(0.3),
                  child: ImageWidget(
                    imageUrl: "Assets.images.svgs.terms",
                  ),
                ),
              ),
              31.verticalSpace,
              const TextView(
                text: 'Terms of Use & Privacy Consent',
                fontWeight: FontWeight.w500,
                fontSize: 18,
              ),
              16.verticalSpace,
              RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                      style: TextStyle(
                        height: 1.7,
                        color: context.colorScheme.onBackground,
                      ),
                      children: [
                        TextSpan(
                            text:
                                "Please take the time to carefully review our ",
                            style: GoogleFonts.poppins(
                              fontSize: 13.sp,
                            )),
                        TextSpan(
                            text: "Terms of User ",
                            style: GoogleFonts.poppins(
                                fontSize: 13.sp,
                                color: Pallets.primary,
                                fontWeight: FontWeight.w600)),
                        const TextSpan(text: "and"),
                        TextSpan(
                            text: " Privacy Policy ",
                            style: GoogleFonts.poppins(
                                fontSize: 13.sp,
                                color: Pallets.primary,
                                fontWeight: FontWeight.w600)),
                        TextSpan(
                            text:
                                "These terms to ensure a clear understanding of your rights and responsibilities within our platform. Your continued use of the account implies your acceptance of and compliance with these terms. If you do not agree with any part of the terms of use, we advise refraining from creating an account and accessing our services.",
                            style: GoogleFonts.poppins(
                              fontSize: 13.sp,
                            )),
                      ]))
            ],
          ),
        ),
      ),
    );
  }
}
