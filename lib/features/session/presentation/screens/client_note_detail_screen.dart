import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:talkam/common/widgets/custom_appbar.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/theme/pallets.dart';

class ClientNoteDetailScreen extends StatelessWidget {
  final Map<String, String>? note;

  const ClientNoteDetailScreen({super.key, this.note});

  @override
  Widget build(BuildContext context) {
    final title = note?["title"] ?? "Title";
    final content = note?["content"] ??
        "As your therapist, I'm dedicated to supporting you every step of the way on your journey toward well-being. Together, we'll take the time to explore your thoughts and feelings deeply, identify any challenges you may be facing, and develop personalized strategies to help you not just cope but truly thrive. Remember, this is a safe and confidential space where you can express yourself openly and honestly without judgment. I'm here to listen, guide, and empower you as we work toward your goals.";

    return Scaffold(
      backgroundColor: Pallets.white,
      appBar: const CustomAppBar(
        tittle: TextView(
          text: "Clients Notes",
          fontSize: 20,
          fontWeight: FontWeight.w700,
          color: Pallets.boldBlack,
        ),
        centerTile: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextView(
                text: title,
                fontSize: 24,
                fontWeight: FontWeight.w700,
                color: Pallets.boldBlack,
              ),
              20.verticalSpace,
              TextView(
                text: content,
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Pallets.boldBlack,
                lineHeight: 1.5,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
