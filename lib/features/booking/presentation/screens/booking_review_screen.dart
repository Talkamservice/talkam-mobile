import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:talkam/common/widgets/custom_button.dart';
import 'package:talkam/common/widgets/step_progress_bar.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/navigation/route_url.dart';
import 'package:talkam/core/theme/pallets.dart';
import 'package:talkam/features/booking/data/models/therapist_directory_response.dart';
import 'package:talkam/features/booking/data/models/therapist_slots_response.dart';
import 'package:talkam/features/booking/presentation/blocs/booking_cubit/booking_cubit.dart';
import 'package:talkam/features/therapist/data/models/therapist_model.dart';
import 'package:talkam/gen/assets.gen.dart';

class BookingReviewScreen extends StatefulWidget {
  final int therapistId;
  final TherapistSlot slot;
  final String format;
  final TherapistProfileDetail profile;
  final TherapistModel? therapistModel;
  final String? notes;

  const BookingReviewScreen({
    super.key,
    required this.therapistId,
    required this.slot,
    required this.format,
    required this.profile,
    this.therapistModel,
    this.notes,
  });

  @override
  State<BookingReviewScreen> createState() => _BookingReviewScreenState();
}

class _BookingReviewScreenState extends State<BookingReviewScreen> {
  late final BookingCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = BookingCubit();
  }

  @override
  void dispose() {
    _cubit.close();
    super.dispose();
  }

  void _onPay() async {
    await _cubit.createBooking(
      therapistId: widget.therapistId,
      startsAt: widget.slot.startsAt,
      format: widget.format,
      notes: widget.notes,
    );
  }

  @override
  Widget build(BuildContext context) {
    final therapist = widget.therapistModel ??
        TherapistModel.fromProfileDetail(widget.profile);

    final formattedPrice =
        "₦${therapist.pricePerSession.toInt().toString().replaceAllMapped(
              RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
              (Match m) => '${m[1]},',
            )}";

    return BlocProvider.value(
      value: _cubit,
      child: BlocConsumer<BookingCubit, BookingState>(
        listenWhen: (prev, curr) => curr.status != prev.status,
        listener: (context, state) async {
          if (state.status == BookingStatus.bookingCreated &&
              state.booking != null) {
            await _cubit.initiateAndPay(state.booking!.id, context);
          } else if (state.status == BookingStatus.paymentSuccess &&
              state.booking != null) {
            context.pushReplacementNamed(
              PageUrl.bookingConfirmedScreen,
              extra: state.booking,
            );
          } else if (state.status == BookingStatus.paymentFailed) {
            if (state.booking != null) {
              context.pushReplacementNamed(
                PageUrl.bookingFailedScreen,
                extra: state.booking,
              );
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                    content: Text(state.errorMessage ?? 'Payment failed')),
              );
            }
          } else if (state.status == BookingStatus.error) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                  content: Text(state.errorMessage ?? 'Something went wrong')),
            );
          }
        },
        builder: (context, state) {
          final isLoading = state.status == BookingStatus.loading ||
              state.status == BookingStatus.bookingCreated ||
              state.status == BookingStatus.paymentInitiated;

          return Scaffold(
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
            body: Padding(
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
                                        "${widget.slot.formattedTime}  •  ${therapist.avgDuration}",
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
                    onPressed: isLoading ? null : _onPay,
                    child: isLoading
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
            ),
          );
        },
      ),
    );
  }
}
