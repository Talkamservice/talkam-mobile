import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:talkam/common/widgets/custom_appbar.dart';
import 'package:talkam/common/widgets/custom_button.dart';
import 'package:talkam/common/widgets/error_widget.dart';
import 'package:talkam/common/widgets/step_progress_bar.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/navigation/route_url.dart';
import 'package:talkam/core/theme/pallets.dart';
import 'package:talkam/features/booking/data/models/therapist_directory_response.dart';
import 'package:talkam/features/booking/data/models/therapist_slots_response.dart';
import 'package:talkam/features/booking/presentation/blocs/booking_cubit/booking_cubit.dart';
import 'package:talkam/features/therapist/data/models/therapist_model.dart';

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
  final int therapistId;
  final String selectedFormat;
  final TherapistProfileDetail profile;
  final TherapistModel? therapistModel;

  const BookingStepOneScreen({
    super.key,
    required this.therapistId,
    required this.selectedFormat,
    required this.profile,
    this.therapistModel,
  });

  @override
  State<BookingStepOneScreen> createState() => _BookingStepOneScreenState();
}

class _BookingStepOneScreenState extends State<BookingStepOneScreen> {
  late final BookingCubit _cubit;
  final TextEditingController _noteController = TextEditingController();

  late final List<_DateOption> _dateOptions;
  int _selectedDateIndex = 0;
  TherapistSlot? _selectedSlot;

  @override
  void initState() {
    super.initState();
    _cubit = BookingCubit();
    final now = DateTime.now();
    _dateOptions = List.generate(7, (i) {
      final dt = now.add(Duration(days: i));
      final dateKey =
          '${dt.year}-${dt.month.toString().padLeft(2, '0')}-${dt.day.toString().padLeft(2, '0')}';
      String label;
      if (i == 0) {
        label = "Today";
      } else if (i == 1) {
        label = "Tomorrow";
      } else {
        const days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
        label = days[dt.weekday - 1];
      }
      const months = [
        '',
        'Jan',
        'Feb',
        'Mar',
        'Apr',
        'May',
        'Jun',
        'Jul',
        'Aug',
        'Sep',
        'Oct',
        'Nov',
        'Dec'
      ];
      final dateDisplay = '${months[dt.month]} ${dt.day}';
      return _DateOption(
          label: label, dateDisplay: dateDisplay, dateKey: dateKey);
    });

    _fetchSlots(_dateOptions[0].dateKey);
  }

  @override
  void dispose() {
    _noteController.dispose();
    _cubit.close();
    super.dispose();
  }

  void _fetchSlots(String dateKey) {
    setState(() => _selectedSlot = null);
    _cubit.loadSlots(widget.therapistId, dateKey);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _cubit,
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
        body: BlocBuilder<BookingCubit, BookingState>(
          builder: (context, state) {
            final slots = state.slotsResponse?.slots ?? [];
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
                        children: List.generate(_dateOptions.length, (index) {
                          final opt = _dateOptions[index];
                          final isSelected = _selectedDateIndex == index;
                          return GestureDetector(
                            onTap: () {
                              setState(() => _selectedDateIndex = index);
                              _fetchSlots(opt.dateKey);
                            },
                            child: Container(
                              width: 96.w,
                              margin: EdgeInsets.only(right: 12.w),
                              padding: EdgeInsets.symmetric(vertical: 14.h),
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? Pallets.blueBubbleColor
                                    : const Color(0xFFF9FAFB),
                                border: Border.all(
                                  color: isSelected
                                      ? Pallets.blueBubbleColor
                                      : const Color(0xFFE5E5EB),
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
                        }),
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

                    if (state.status == BookingStatus.loading)
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 30.h),
                        child: const Center(
                          child: CircularProgressIndicator(
                              color: Pallets.blueBubbleColor),
                        ),
                      )
                    else if (state.status == BookingStatus.error)
                      AppErrorWidget(
                        message: state.errorMessage ??
                            "Couldn't load slots for this day.",
                        showImage: false,
                        onTap: () => _fetchSlots(
                            _dateOptions[_selectedDateIndex].dateKey),
                      )
                    else if (slots.isEmpty)
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 20.h),
                        child: Center(
                          child: TextView(
                            text: "No slots available for this day",
                            fontSize: 14,
                            color: Pallets.grey,
                          ),
                        ),
                      )
                    else
                      // Times Grid (3 columns)
                      Wrap(
                        spacing: 12.w,
                        runSpacing: 12.h,
                        children: slots.map((slot) {
                          final timeStr = slot.formattedTime;
                          final isSelected =
                              _selectedSlot?.startsAt == slot.startsAt;
                          return GestureDetector(
                            onTap: () {
                              setState(() => _selectedSlot = slot);
                              _cubit.selectSlot(slot);
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
                                  text: timeStr,
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
            child: CustomButton(
              onPressed: _selectedSlot != null
                  ? () {
                      context.pushNamed(
                        PageUrl.bookingReviewScreen,
                        extra: {
                          'therapistId': widget.therapistId,
                          'slot': _selectedSlot!,
                          'format': widget.selectedFormat,
                          'profile': widget.profile,
                          'therapistModel': widget.therapistModel,
                          'notes': _noteController.text.trim(),
                        },
                      );
                    }
                  : null,
              child: const Text(
                "Book this session",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
