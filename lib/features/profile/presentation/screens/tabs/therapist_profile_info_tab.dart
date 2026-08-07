import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/theme/pallets.dart';
import 'package:talkam/gen/assets.gen.dart';

class TherapistProfileInfoTab extends StatefulWidget {
  const TherapistProfileInfoTab({super.key});

  @override
  State<TherapistProfileInfoTab> createState() => _TherapistProfileInfoTabState();
}

class _TherapistProfileInfoTabState extends State<TherapistProfileInfoTab> {
  String _selectedFormat = 'Video';

  ({Color bg, Color text}) _getSpecialtyColor(String specialty) {
    switch (specialty.toLowerCase().trim()) {
      case 'anxiety':
        return (bg: const Color(0xFFE8F8F0), text: const Color(0xFF059669));
      case 'depression':
        return (bg: const Color(0xFFFFEAEA), text: const Color(0xFFE11D48));
      case 'stress':
        return (bg: const Color(0xFFF0F2F5), text: const Color(0xFF6B7280));
      case 'overwhelm':
        return (bg: const Color(0xFFFFF6E5), text: const Color(0xFFD97706));
      default:
        return (bg: const Color(0xFFE8F8F0), text: const Color(0xFF059669));
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ABOUT
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: const Color(0xFFF4FBFF),
              borderRadius: BorderRadius.circular(16.r),
              border: Border.all(color: const Color(0xFFD0EBFB)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextView(
                  text: "ABOUT",
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF475569),
                ),
                8.verticalSpace,
                TextView(
                  text:
                      "Clinical psychologist with 8 years helping young professionals manage anxiety, burnout and relationship challenges. I use evidence-based CBT and mindfulness-based approaches.",
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xFF475569),
                  lineHeight: 1.4,
                ),
              ],
            ),
          ),
          24.verticalSpace,

          // SPECIALTIES
          TextView(
            text: "SPECIALTIES",
            fontSize: 13,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF475569),
          ),
          12.verticalSpace,
          Wrap(
            spacing: 8.w,
            runSpacing: 8.h,
            children: ['Anxiety', 'Depression', 'Stress', 'Overwhelm'].map((s) {
              final colors = _getSpecialtyColor(s);
              return Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                decoration: BoxDecoration(
                  color: colors.bg,
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: TextView(
                  text: s,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: colors.text,
                ),
              );
            }).toList(),
          ),
          24.verticalSpace,
          // RATINGS & REVIEWS
          TextView(
            text: "RATINGS & REVIEWS",
            fontSize: 13,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF475569),
          ),
          16.verticalSpace,

          // Ratings Summary Card
          Container(
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: const Color(0xFFFAFAFA),
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: Row(
              children: [
                // Left Column
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextView(
                      text: "4.9",
                      fontSize: 28,
                      fontWeight: FontWeight.w700,
                      color: Pallets.boldBlack,
                    ),
                    4.verticalSpace,
                    Row(
                      children: List.generate(
                        5,
                        (index) => Padding(
                          padding: EdgeInsets.symmetric(horizontal: 1.w),
                          child: SvgPicture.asset(
                            Assets.images.svgV2.star,
                            width: 14.w,
                            height: 14.w,
                            colorFilter: const ColorFilter.mode(
                              Color(0xFFFFA800),
                              BlendMode.srcIn,
                            ),
                          ),
                        ),
                      ),
                    ),
                    6.verticalSpace,
                    TextView(
                      text: "avg rating",
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: Pallets.grey,
                    ),
                  ],
                ),
                24.horizontalSpace,
                // Right Rating Bars
                Expanded(
                  child: Column(
                    children: [
                      const _RatingBarRow(starNum: "5", value: 0.92),
                      6.verticalSpace,
                      const _RatingBarRow(starNum: "4", value: 0.35),
                      6.verticalSpace,
                      const _RatingBarRow(starNum: "3", value: 0.15),
                      6.verticalSpace,
                      const _RatingBarRow(starNum: "2", value: 0.05),
                      6.verticalSpace,
                      const _RatingBarRow(starNum: "1", value: 0.0),
                    ],
                  ),
                ),
              ],
            ),
          ),
          16.verticalSpace,

          // Review Cards
          const _ReviewCard(
            rating: 5,
            timeAgo: "2 wks ago",
            content:
                "Had a great session with my therapist! They listened and gave valuable insights. I feel more equipped now. Highly recommend!",
            role: "Employee  •  anonymised",
          ),
          12.verticalSpace,
          const _ReviewCard(
            rating: 5,
            timeAgo: "1 wk ago",
            content:
                "Participated in a team-building workshop that enhanced our collaboration skills. It was fun and informative!",
            role: "Employee  •  anonymised",
          ),
          32.verticalSpace,
        ],
      ),
    );
  }
}

class _RatingBarRow extends StatelessWidget {
  final String starNum;
  final double value;

  const _RatingBarRow({
    required this.starNum,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 10.w,
          child: TextView(
            text: starNum,
            fontSize: 12,
            fontWeight: FontWeight.w400,
            color: Pallets.grey,
          ),
        ),
        8.horizontalSpace,
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(4.r),
            child: LinearProgressIndicator(
              value: value,
              minHeight: 4.h,
              backgroundColor: const Color(0xFFE5E7EB),
              valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFFFFA800)),
            ),
          ),
        ),
      ],
    );
  }
}

class _ReviewCard extends StatelessWidget {
  final int rating;
  final String timeAgo;
  final String content;
  final String role;

  const _ReviewCard({
    required this.rating,
    required this.timeAgo,
    required this.content,
    required this.role,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Pallets.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: const Color(0xFFF3F4F6)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: List.generate(
                  rating,
                  (index) => Padding(
                    padding: EdgeInsets.only(right: 2.w),
                    child: SvgPicture.asset(
                      Assets.images.svgV2.star,
                      width: 14.w,
                      height: 14.w,
                      colorFilter: const ColorFilter.mode(
                        Color(0xFFFFA800),
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                ),
              ),
              TextView(
                text: timeAgo,
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: Pallets.grey,
              ),
            ],
          ),
          12.verticalSpace,
          TextView(
            text: content,
            fontSize: 13,
            fontWeight: FontWeight.w400,
            color: const Color(0xFF334155),
            lineHeight: 1.4,
          ),
          12.verticalSpace,
          TextView(
            text: role,
            fontSize: 12,
            fontWeight: FontWeight.w400,
            color: Pallets.grey,
          ),
        ],
      ),
    );
  }
}
