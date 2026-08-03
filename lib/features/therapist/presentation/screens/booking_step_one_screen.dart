import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:talkam/common/widgets/custom_appbar.dart';
import 'package:talkam/common/widgets/custom_button.dart';
import 'package:talkam/common/widgets/step_progress_bar.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/theme/pallets.dart';
import 'package:talkam/features/therapist/data/models/therapist_model.dart';
import 'package:talkam/features/therapist/presentation/bloc/therapist_booking_bloc.dart';
import 'package:talkam/core/navigation/route_url.dart';

class _DateOption {
  final String label;
  final String dateDisplay;
  final String dateKey;

  const _DateOption({
    required this.label,
    required this.dateDisplay,
    required this.dateKey,
  });
}

class BookingStepOneScreen extends StatefulWidget {
  final TherapistModel therapist;

  const BookingStepOneScreen({super.key, required this.therapist});

  @override
  State<BookingStepOneScreen> createState() => _BookingStepOneScreenState();
}

class _BookingStepOneScreenState extends State<BookingStepOneScreen> {
  final TextEditingController _noteController = TextEditingController(text: "I'm a workaholic");

  static const List<_DateOption> _dateOptions = [
    _DateOption(label: "Today", dateDisplay: "Jul 2", dateKey: "2026-07-02"),
    _DateOption(label: "Tomorrow", dateDisplay: "Jul 3", dateKey: "2026-07-03"),
    _DateOption(label: "Yesterday", dateDisplay: "Jul 1", dateKey: "2026-07-01"),
    _DateOption(label: "Next Week", dateDisplay: "Jul 9", dateKey: "2026-07-09"),
  ];

  static const List<String> _times = [
    "9:00 AM",
    "10:00 AM",
    "11:00 AM",
    "12:00 PM",
    "1:00 PM",
    "2:00 PM",
  ];

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TherapistBookingBloc()
        ..add(const TherapistBookingSelectDate("2026-07-02"))
        ..add(const TherapistBookingSelectTime("9:00 AM"))
        ..add(const TherapistBookingUpdateNote("I'm a workaholic")),
      child: Scaffold(
        backgroundColor: Pallets.white,
        appBar: CustomAppBar(
          titleAlign: TextAlign.start,
          centerTile: false,
          tittle: TextView(
            text: "Booking",
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: Pallets.boldBlack,
          ),
        ),
        body: BlocBuilder<TherapistBookingBloc, TherapistBookingState>(
          builder: (context, state) {
            return SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    20.verticalSpace,

                    // Progress Bar
                    const StepProgressBar(
                      step: 1,
                      totalSteps: 3,
                      label: "Date and time selection",
                      customPercentage: 0.20,
                    ),
                    28.verticalSpace,

                    // SELECT DATE Header
                    TextView(
                      text: "SELECT DATE",
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF475569),
                    ),
                    12.verticalSpace,

                    // Date Options Horizontal Row
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: _dateOptions.map((opt) {
                          final isSelected = state.selectedDate == opt.dateKey;
                          return GestureDetector(
                            onTap: () {
                              context.read<TherapistBookingBloc>().add(
                                    TherapistBookingSelectDate(opt.dateKey),
                                  );
                            },
                            child: Container(
                              width: 96.w,
                              margin: EdgeInsets.only(right: 12.w),
                              padding: EdgeInsets.symmetric(
                                vertical: 14.h,
                              ),
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? Pallets.blueBubbleColor
                                    : const Color(0xFFF9FAFB),
                                border: Border.all(
                                  color: isSelected
                                      ? Pallets.blueBubbleColor
                                      : const Color(0xFFE5E7EB),
                                ),
                                borderRadius: BorderRadius.circular(16.r),
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  TextView(
                                    text: opt.label,
                                    fontSize: 12,
                                    fontWeight: isSelected
                                        ? FontWeight.w500
                                        : FontWeight.w400,
                                    color: isSelected
                                        ? Pallets.white
                                        : const Color(0xFF9CA3AF),
                                  ),
                                  4.verticalSpace,
                                  TextView(
                                    text: opt.dateDisplay,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w700,
                                    color: isSelected
                                        ? Pallets.white
                                        : const Color(0xFF4B5563),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                    28.verticalSpace,

                    // AVAILABLE TIMES Header
                    TextView(
                      text: "AVAILABLE TIMES",
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF475569),
                    ),
                    12.verticalSpace,

                    // Times Grid (3 columns)
                    Wrap(
                      spacing: 12.w,
                      runSpacing: 12.h,
                      children: _times.map((time) {
                        final isSelected = state.selectedTime == time;
                        return GestureDetector(
                          onTap: () {
                            context.read<TherapistBookingBloc>().add(
                                  TherapistBookingSelectTime(time),
                                );
                          },
                          child: Container(
                            height: 70,
                            width: (1.sw - 40.w - 24.w) / 3,
                            padding: EdgeInsets.symmetric(vertical: 16.h),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? Pallets.blueBubbleColor
                                  : const Color(0xFFF9FAFB),
                              borderRadius: BorderRadius.circular(16.r),
                            ),
                            child: Center(
                              child: TextView(
                                text: time,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: isSelected
                                    ? Pallets.white
                                    : const Color(0xFF334155),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                    28.verticalSpace,

                    // NOTES FOR THERAPIST Header
                    Row(
                      children: [
                        TextView(
                          text: "NOTES FOR THERAPIST ",
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF475569),
                        ),
                        TextView(
                          text: "Optional",
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: const Color(0xFF9CA3AF),
                        ),
                      ],
                    ),
                    12.verticalSpace,

                    // Notes Text Field Box
                    Container(
                      height: 140.h,
                      width: double.infinity,
                      padding: EdgeInsets.all(16.w),
                      decoration: BoxDecoration(
                        color: Pallets.white,
                        borderRadius: BorderRadius.circular(20.r),
                        border: Border.all(
                          color: Pallets.blueBubbleColor,
                          width: 1.5,
                        ),
                      ),
                      child: TextField(
                        controller: _noteController,
                        maxLines: null,
                        onChanged: (val) {
                          context.read<TherapistBookingBloc>().add(
                                TherapistBookingUpdateNote(val),
                              );
                        },
                        decoration: const InputDecoration(
                          hintText: "I'm a workaholic",
                          hintStyle: TextStyle(
                            fontSize: 15,
                            color: Color(0xFF1E293B),
                            fontWeight: FontWeight.w400,
                          ),
                          border: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          contentPadding: EdgeInsets.zero,
                        ),
                        style: const TextStyle(
                          fontSize: 15,
                          color: Color(0xFF1E293B),
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    100.verticalSpace,
                  ],
                ),
              ),
            );
          },
        ),
        bottomNavigationBar: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
            child: Builder(
              builder: (innerContext) {
                return CustomButton(
                  onPressed: () {
                    final bloc = innerContext.read<TherapistBookingBloc>();
                    context.pushNamed(
                      PageUrl.bookingReviewScreen,
                      extra: {
                        'therapist': widget.therapist,
                        'bloc': bloc,
                      },
                    );
                  },
                  child: const Text(
                    "Book this session",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
