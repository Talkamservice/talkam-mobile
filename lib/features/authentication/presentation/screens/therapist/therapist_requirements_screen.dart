import 'package:flutter/material.dart';
import 'package:talkam/common/widgets/custom_appbar.dart';
import 'package:talkam/common/widgets/custom_button.dart';
import 'package:talkam/common/widgets/image_widget.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/constants/package_exports.dart';
import 'package:talkam/core/navigation/route_url.dart';
import 'package:talkam/core/theme/pallets.dart';
import 'package:talkam/features/therapist_application/data/models/therapist_application_data.dart';
import 'package:talkam/features/therapist_application/presentation/bloc/therapist_application_bloc.dart';

import '../../../../../gen/assets.gen.dart';

/// "What you'll need" — the checklist shown before the wizard starts.
/// Purely informational; it only carries [bloc] forward to the first real
/// step, it doesn't read or write any state on it.
class TherapistRequirementsScreen extends StatelessWidget {
  const TherapistRequirementsScreen({super.key, required this.bloc});

  final TherapistApplicationBloc bloc;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppBar(
        bgColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const TextView(
              text: "What you'll need",
              fontSize: 24,
              fontWeight: FontWeight.w800,
              color: Pallets.boldBlackV2,
            ),
            8.verticalSpace,
            const TextView(
              text:
                  "Upload all documents with your application. We verify in 5 days and notify you.",
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Pallets.grey400,
              lineHeight: 1.4,
            ),
            24.verticalSpace,
            Expanded(
              child: ListView.separated(
                itemCount: DocumentId.values.length,
                separatorBuilder: (_, __) => 8.verticalSpace,
                itemBuilder: (context, index) {
                  final doc = DocumentId.values[index];
                  return _RequirementCard(
                      title: doc.title, subtitle: doc.subtitle);
                },
              ),
            ),
            CustomButton(
              elevation: 0,
              onPressed: () => context.pushNamed(
                PageUrl.therapistPersonalInfoScreen,
                extra: bloc,
              ),
              bgColor: Pallets.blueBubbleColor,
              child: const TextView(
                text: "Next",
                fontSize: 15,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
            24.verticalSpace,
          ],
        ),
      ),
    );
  }
}

class _RequirementCard extends StatelessWidget {
  const _RequirementCard({required this.title, required this.subtitle});

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Pallets.blueBubbleColor.withValues(alpha: 0.04),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsetsGeometry.all(8),
            width: 24.w,
            height: 24.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.r),
              color: Pallets.blueBubbleColor.withValues(alpha: 0.2),
            ),
            child: ImageWidget(
              imageUrl: Assets.images.svgs.checkbox,
              size: 24.w,
              color: Pallets.blueBubbleColor,
            ),
            // child: Icon(Icons.check_rounded, size: 16.sp, color: Colors.white),
          ),
          12.horizontalSpace,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextView(
                  text: title,
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: Pallets.boldBlackV2,
                ),
                4.verticalSpace,
                TextView(
                  text: subtitle,
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: Pallets.grey400,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
