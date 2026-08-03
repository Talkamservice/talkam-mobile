import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:talkam/common/widgets/custom_button.dart';
import 'package:talkam/common/widgets/step_progress_bar.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/theme/pallets.dart';
import 'package:talkam/features/therapist/data/models/therapist_model.dart';
import 'package:talkam/features/therapist/presentation/bloc/therapist_booking_bloc.dart';
import 'package:talkam/core/navigation/route_url.dart';
import 'package:talkam/gen/assets.gen.dart';

class BookingReviewScreen extends StatelessWidget {
  final TherapistModel therapist;
  final TherapistBookingBloc bloc;

  const BookingReviewScreen({
    super.key,
    required this.therapist,
    required this.bloc,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: bloc,
      child: Scaffold(
        backgroundColor: Pallets.white,
        appBar: AppBar(
          backgroundColor: Pallets.white,
          elevation: 0,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios_new,
              color: Pallets.boldBlack,
              size: 20.w,
            ),
            onPressed: () => context.pop(),
          ),
        ),
        body: BlocConsumer<TherapistBookingBloc, TherapistBookingState>(
          listener: (context, state) {
            if (state.status == TherapistBookingStatus.success) {
              context.pushNamed(PageUrl.bookingConfirmedScreen);
            } else if (state.status == TherapistBookingStatus.failure) {
              context.pushNamed(
                PageUrl.bookingFailedScreen,
                extra: state.errorMessage ?? "An error occurred",
              );
            }
          },
          builder: (context, state) {
            final formattedPrice =
                "₦${therapist.pricePerSession.toInt().toString().replaceAllMapped(
                      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                      (Match m) => '${m[1]},',
                    )}";

            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  10.verticalSpace,

                  // Progress Bar
                  const StepProgressBar(
                    step: 2,
                    totalSteps: 3,
                    label: "Review and pay",
                    customPercentage: 0.50,
                  ),
                  28.verticalSpace,

                  // Booking Summary Card
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(20.w),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF4FBFF),
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextView(
                          text: "Booking summary",
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: const Color(0xFF94A3B8),
                        ),
                        16.verticalSpace,

                        // Doctor Info Row
                        Row(
                          children: [
                            Container(
                              width: 48.w,
                              height: 48.w,
                              decoration: const BoxDecoration(
                                color: Color(0xFFEBF5FB),
                                shape: BoxShape.circle,
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(24.r),
                                child: therapist.avatarUrl.isNotEmpty
                                    ? CachedNetworkImage(
                                        imageUrl: therapist.avatarUrl,
                                        width: 48.w,
                                        height: 48.w,
                                        fit: BoxFit.cover,
                                        errorWidget: (context, url, error) =>
                                            Center(
                                          child: SvgPicture.asset(
                                            Assets.images.svgV2.userActive,
                                            width: 24.w,
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
                                          width: 24.w,
                                          colorFilter: const ColorFilter.mode(
                                            Pallets.blueBubbleColor,
                                            BlendMode.srcIn,
                                          ),
                                        ),
                                      ),
                              ),
                            ),
                            12.horizontalSpace,
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TextView(
                                    text: therapist.name,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                    color: Pallets.boldBlack,
                                  ),
                                  4.verticalSpace,
                                  TextView(
                                    text:
                                        "Today  •  ${state.selectedTime ?? '9:00 AM'}  •  50 min",
                                    fontSize: 13,
                                    fontWeight: FontWeight.w400,
                                    color: const Color(0xFF94A3B8),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        20.verticalSpace,

                        // Divider Line
                        Container(
                          height: 1,
                          width: double.infinity,
                          color: const Color(0xFFE2E8F0),
                        ),
                        20.verticalSpace,

                        // Total Price Row
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextView(
                              text: "Total",
                              fontSize: 15,
                              fontWeight: FontWeight.w400,
                              color: const Color(0xFF64748B),
                            ),
                            TextView(
                              text: formattedPrice,
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFF1E293B),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  24.verticalSpace,

                  // Pay Button
                  CustomButton(
                    onPressed: state.status == TherapistBookingStatus.loading
                        ? null
                        : () {
                            context
                                .read<TherapistBookingBloc>()
                                .add(const TherapistBookingSubmit());
                          },
                    child: state.status == TherapistBookingStatus.loading
                        ? SizedBox(
                            width: 22.w,
                            height: 22.w,
                            child: const CircularProgressIndicator(
                              color: Pallets.white,
                              strokeWidth: 2.5,
                            ),
                          )
                        : const Text(
                            "Pay",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: Pallets.white,
                            ),
                          ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
