import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:talkam/common/widgets/custom_button.dart';
import 'package:talkam/common/widgets/custom_text_field.dart';
import 'package:talkam/common/widgets/image_widget.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/theme/pallets.dart';
import 'package:talkam/core/utils/extensions/context_extension.dart';
import 'package:talkam/features/therapist/data/models/therapist_model.dart';
import 'package:talkam/gen/assets.gen.dart';
import 'package:talkam/core/navigation/route_url.dart';
import 'package:cached_network_image/cached_network_image.dart';

class TherapistsListScreen extends StatefulWidget {
  const TherapistsListScreen({super.key});

  @override
  State<TherapistsListScreen> createState() => _TherapistsListScreenState();
}

class _TherapistsListScreenState extends State<TherapistsListScreen> {
  final List<TherapistModel> therapists = MockTherapistData.therapists;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Pallets.white,
      appBar: AppBar(
        backgroundColor: Pallets.white,
        elevation: 0,
        centerTitle: false,
        title: TextView(
          text: "Therapist",
          fontSize: 22,
          fontWeight: FontWeight.w700,
          color: Pallets.boldBlack,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          children: [
            10.verticalSpace,
            Row(
              children: [
                Expanded(
                  child: CustomTextField(
                    hint: "Find your specialist",
                    prefixIcon: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: SvgPicture.asset(Assets.images.svgV2.searchIcon),
                    ),
                  ),
                ),
                10.horizontalSpace,
                Container(
                  width: 38.w,
                  height: 38.w,
                  decoration: BoxDecoration(
                    color: Pallets.grey95.withValues(alpha: 0.3),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Pallets.grey95)
                  ),
                  child: Center(
                    child: SvgPicture.asset(
                      Assets.images.svgV2.preferenceHorizontal,
                      colorFilter: const ColorFilter.mode(Pallets.grey60, BlendMode.srcIn),
                      width: 18.w,
                    ),
                  ),
                )
              ],
            ),
            20.verticalSpace,
            Expanded(
              child: ListView.separated(
                itemCount: therapists.length,
                separatorBuilder: (context, index) => 16.verticalSpace,
                itemBuilder: (context, index) {
                  final therapist = therapists[index];
                  return _TherapistCard(
                    therapist: therapist,
                    onTapBook: () {
                      context.pushNamed(
                        PageUrl.therapistProfileScreen,
                        extra: therapist,
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TherapistCard extends StatelessWidget {
  final TherapistModel therapist;
  final VoidCallback onTapBook;

  const _TherapistCard({
    required this.therapist,
    required this.onTapBook,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(18.w),
      decoration: BoxDecoration(
        color: Pallets.pollTrackColor.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: CachedNetworkImage(
                  imageUrl: therapist.avatarUrl,
                  width: 50.w,
                  height: 50.w,
                  fit: BoxFit.cover,
                ),
              ),
              12.horizontalSpace,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        TextView(
                          text: therapist.name,
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Pallets.boldBlack,
                        ),
                        4.horizontalSpace,
                        if (therapist.isVerified)
                          SvgPicture.asset(
                            Assets.images.svgV2.checkmarkBadge,
                            width: 16.w,
                          ),
                      ],
                    ),
                    4.verticalSpace,
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        TextView(
                          text: therapist.title,
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                          color: Pallets.grey,
                        ),
                        8.horizontalSpace,
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 7.w, vertical: 2.h),
                          decoration: BoxDecoration(
                            color: Pallets.yellow.withValues(alpha: 0.3),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: TextView(
                            text: therapist.specialties.first,
                            fontSize: 9,
                            fontWeight: FontWeight.w500,
                            color: Pallets.yelloDarker,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
          16.verticalSpace,
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      ImageWidget(imageUrl: Assets.images.svgV2.money03, size: 24,),
                      4.horizontalSpace,
                      TextView(
                        text: "${therapist.pricePerSession.toInt()} / session",
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Pallets.boldBlack,
                      ),
                    ],
                  ),
                  4.verticalSpace,
                  Row(
                    children: [
                      ImageWidget(imageUrl: Assets.images.svgV2.calendarInActive,
                        color: Pallets.blueBubbleColor, size: 24,),
                      4.horizontalSpace,
                      TextView(
                        text: therapist.nextAvailableSlot,
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: Pallets.blueBubbleColor,
                      ),
                    ],
                  )
                ],
              ),
              Row(
                children: [
                  SvgPicture.asset(
                    Assets.images.svgV2.star,
                    width: 14.w,
                    colorFilter: const ColorFilter.mode(Pallets.yellow, BlendMode.srcIn),
                  ),
                  4.horizontalSpace,
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: "${therapist.rating} ",
                          style: TextStyle(
                            fontWeight: FontWeight.bold, // e.g., make the rating bold
                            color: context.colorScheme.onSurface,
                          ),
                        ),
                        TextSpan(
                          text: "(${therapist.reviewsCount} reviews)",
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            color: Pallets.grey35,
                          ),
                        ),
                      ],
                    ),
                    style: const TextStyle(fontSize: 12), // Base font size for all spans
                  )
                ],
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              8.verticalSpace,
              Row(
                children: [
                  Expanded(
                      child:
                      CustomButton(
                        onPressed: onTapBook,
                        child: Text("Book Now",
                          style: TextStyle(fontSize: 16,
                              fontWeight: FontWeight.w700),
                        ),
                      )
                  ),
                  8.horizontalSpace,
                  Container(
                    width: 45.w,
                    height: 45.w,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Pallets.grey95)
                    ),
                    child: Center(
                      child: SvgPicture.asset(
                        Assets.images.svgV2.userSearch,
                        colorFilter: const ColorFilter.mode(Pallets.grey60, BlendMode.srcIn),
                        width: 24.w,
                      ),
                    ),
                  )
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
