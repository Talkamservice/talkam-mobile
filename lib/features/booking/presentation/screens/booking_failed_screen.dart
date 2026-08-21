import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:talkam/common/widgets/custom_button.dart';
import 'package:talkam/common/widgets/step_progress_bar.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/navigation/route_url.dart';
import 'package:talkam/core/services/network/url_config.dart';
import 'package:talkam/core/theme/pallets.dart';
import 'package:talkam/core/utils/url_launcher.dart';
import 'package:talkam/features/booking/data/models/booking_response.dart';
import 'package:talkam/features/booking/presentation/blocs/booking_cubit/booking_cubit.dart';

class BookingFailedScreen extends StatefulWidget {
  final BookingResponse? booking;
  final String? errorMessage;
  final String? doctorName;
  final String? time;

  const BookingFailedScreen({
    super.key,
    this.booking,
    this.errorMessage,
    this.doctorName,
    this.time,
  });

  @override
  State<BookingFailedScreen> createState() => _BookingFailedScreenState();
}

class _BookingFailedScreenState extends State<BookingFailedScreen> {
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

  @override
  Widget build(BuildContext context) {
    final doctor =
        widget.booking?.therapistName ?? widget.doctorName ?? "your therapist";
    final timeStr =
        widget.booking?.formattedStartsAt ?? widget.time ?? "the scheduled time";

    return BlocProvider.value(
      value: _cubit,
      child: BlocListener<BookingCubit, BookingState>(
        listenWhen: (prev, curr) => curr.status != prev.status,
        listener: (context, state) {
          if (state.status == BookingStatus.paymentSuccess &&
              state.booking != null) {
            context.pushReplacementNamed(
              PageUrl.bookingConfirmedScreen,
              extra: state.booking,
            );
          }
        },
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
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              children: [
                10.verticalSpace,
                // Step Progress Bar
                const StepProgressBar(
                  step: 3,
                  totalSteps: 3,
                  label: "CONFIRMED",
                  customPercentage: 1.0,
                ),
                40.verticalSpace,

                // Red X Circle Icon
                Container(
                  width: 100.w,
                  height: 100.w,
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFF1F2),
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: const Color(0xFFFFE4E6),
                      width: 6.w,
                    ),
                  ),
                  child: Center(
                    child: Icon(
                      Icons.close_rounded,
                      color: const Color(0xFFEF4444),
                      size: 48.w,
                    ),
                  ),
                ),
                24.verticalSpace,

                // Title: Booking Failed
                TextView(
                  text: "Booking Failed",
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  color: Pallets.boldBlack,
                ),
                12.verticalSpace,

                // Rich Description
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: const Color(0xFF475569),
                      height: 1.4,
                    ),
                    children: [
                      const TextSpan(text: "Booking with "),
                      TextSpan(
                        text: doctor,
                        style: const TextStyle(
                          color: Pallets.blueBubbleColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const TextSpan(text: " for "),
                      TextSpan(
                        text: timeStr,
                        style: const TextStyle(
                          color: Pallets.blueBubbleColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const TextSpan(
                        text:
                            " today failed.\nPlease retry or contact support.",
                      ),
                    ],
                  ),
                ),
                32.verticalSpace,

                // Buttons
                BlocBuilder<BookingCubit, BookingState>(
                  builder: (context, state) {
                    final isLoading =
                        state.status == BookingStatus.paymentInitiated ||
                            state.status == BookingStatus.loading;
                    return CustomButton(
                      onPressed: isLoading
                          ? null
                          : () {
                              if (widget.booking != null) {
                                _cubit.retryPayment(
                                    widget.booking!.id, context);
                              } else {
                                context.pop();
                              }
                            },
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
                              "Retry",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                    );
                  },
                ),
                16.verticalSpace,
                GestureDetector(
                  onTap: () => UrlLauncher().sendEmail(UrlConfig.supportEmail),
                  child: TextView(
                    text: "Contact Support",
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF94A3B8),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
