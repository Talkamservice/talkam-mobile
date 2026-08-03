import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:talkam/common/widgets/custom_appbar.dart';
import 'package:talkam/common/widgets/custom_button.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/theme/pallets.dart';
import 'package:talkam/features/therapist/data/models/therapist_model.dart';
import 'package:talkam/gen/assets.gen.dart';
import 'package:talkam/core/navigation/route_url.dart';

class TherapistProfileScreen extends StatefulWidget {
  final TherapistModel therapist;

  const TherapistProfileScreen({
    super.key,
    required this.therapist,
  });

  @override
  State<TherapistProfileScreen> createState() => _TherapistProfileScreenState();
}

class _TherapistProfileScreenState extends State<TherapistProfileScreen> {
  late String _selectedFormat;

  @override
  void initState() {
    super.initState();
    _selectedFormat = widget.therapist.sessionFormats.isNotEmpty
        ? widget.therapist.sessionFormats.first
        : 'Video';
  }

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
    return Scaffold(
      backgroundColor: Pallets.white,
      appBar: CustomAppBar(
        titleAlign: TextAlign.start,
        centerTile: false,
        tittle: TextView(
          text: "Therapist Profile",
          fontSize: 20,
          fontWeight: FontWeight.w700,
          color: Pallets.boldBlack,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Profile Header
              8.verticalSpace,
              Center(
                child: Column(
                  children: [
                    Container(
                      width: 80.w,
                      height: 80.w,
                      decoration: const BoxDecoration(
                        color: Color(0xFFEBF5FB),
                        shape: BoxShape.circle,
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(40.r),
                        child: widget.therapist.avatarUrl.isNotEmpty
                            ? CachedNetworkImage(
                                imageUrl: widget.therapist.avatarUrl,
                                width: 80.w,
                                height: 80.w,
                                fit: BoxFit.cover,
                                errorWidget: (context, url, error) => Center(
                                  child: SvgPicture.asset(
                                    Assets.images.svgV2.userActive,
                                    width: 32.w,
                                    colorFilter: const ColorFilter.mode(
                                      Pallets.blueBubbleColor,
                                      BlendMode.srcIn,
                                    ),
                                  ),
                                ),
                              )
                            : Center(
                                child: SvgPicture.asset(
                                  Assets.images.svgV2.userActive,
                                  width: 32.w,
                                  colorFilter: const ColorFilter.mode(
                                    Pallets.blueBubbleColor,
                                    BlendMode.srcIn,
                                  ),
                                ),
                              ),
                      ),
                    ),
                    12.verticalSpace,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextView(
                          text: widget.therapist.name,
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: Pallets.boldBlack,
                        ),
                        6.horizontalSpace,
                        if (widget.therapist.isVerified)
                          SvgPicture.asset(
                            Assets.images.svgV2.checkmarkBadge,
                            width: 18.w,
                          ),
                      ],
                    ),
                    4.verticalSpace,
                    TextView(
                      text: "${widget.therapist.specialties.first}  •  CBT  •  ${widget.therapist.yearsExperience} yrs experience",
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                      color: Pallets.grey,
                    ),
                  ],
                ),
              ),
              20.verticalSpace,

              // Top Stats
              IntrinsicHeight(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _StatItem(
                      label: "Sessions",
                      value: widget.therapist.totalSessions.toString(),
                    ),
                    const VerticalDivider(
                      thickness: 1,
                      width: 1,
                      color: Color(0xFFE5E7EB),
                    ),
                    _StatItem(
                      label: "Ratings",
                      value: "${widget.therapist.rating}",
                      icon: Assets.images.svgV2.star,
                    ),
                    const VerticalDivider(
                      thickness: 1,
                      width: 1,
                      color: Color(0xFFE5E7EB),
                    ),
                    _StatItem(
                      label: "next slot",
                      value: widget.therapist.nextAvailableSlot.split(',').last.trim(),
                      color: Pallets.blueBubbleColor,
                    ),
                    const VerticalDivider(
                      thickness: 1,
                      width: 1,
                      color: Color(0xFFE5E7EB),
                    ),
                    _StatItem(
                      label: "avg",
                      value: widget.therapist.avgDuration,
                    ),
                  ],
                ),
              ),
              24.verticalSpace,

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
                      text: widget.therapist.about,
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
                children: widget.therapist.specialties.map((s) {
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

              // SESSION FORMAT
              TextView(
                text: "SESSION FORMAT",
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF475569),
              ),
              12.verticalSpace,
              Row(
                children: widget.therapist.sessionFormats.map((format) {
                  final isSelected = _selectedFormat == format;
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedFormat = format;
                      });
                    },
                    child: Container(
                      margin: EdgeInsets.only(right: 10.w),
                      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
                      decoration: BoxDecoration(
                        color: isSelected ? Pallets.blueBubbleColor : const Color(0xFFF3F4F6),
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                      child: TextView(
                        text: format,
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: isSelected ? Pallets.white : const Color(0xFF4B5563),
                      ),
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
                          text: "${widget.therapist.rating}",
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
              20.verticalSpace,
            ],
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
          decoration: BoxDecoration(
            color: Pallets.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 10,
                offset: const Offset(0, -4),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextView(
                        text: "Session fee",
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: Pallets.grey,
                      ),
                      2.verticalSpace,
                    ],
                  ),
                  TextView(
                    text: "₦${widget.therapist.pricePerSession.toInt().toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}",
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Pallets.boldBlack,
                  ),
                ],
              ),
              12.verticalSpace,
              CustomButton(
                onPressed: () {
                  context.pushNamed(
                    PageUrl.bookingStepOneScreen,
                    extra: widget.therapist,
                  );
                },
                child: const Text(
                  "Book session",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final String label;
  final String value;
  final String? icon;
  final Color? color;

  const _StatItem({
    required this.label,
    required this.value,
    this.icon,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[
              SvgPicture.asset(
                icon!,
                width: 14.w,
                height: 14.w,
                colorFilter: const ColorFilter.mode(
                  Color(0xFFFFA800),
                  BlendMode.srcIn,
                ),
              ),
              4.horizontalSpace,
            ],
            TextView(
              text: value,
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: color ?? Pallets.boldBlack,
            ),
          ],
        ),
        2.verticalSpace,
        TextView(
          text: label,
          fontSize: 12,
          fontWeight: FontWeight.w400,
          color: Pallets.grey,
        ),
      ],
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
