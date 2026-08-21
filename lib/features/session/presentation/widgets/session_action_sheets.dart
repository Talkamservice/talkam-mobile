import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:talkam/common/widgets/custom_button.dart';
import 'package:talkam/common/widgets/custom_dialogs.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/di/injector.dart';
import 'package:talkam/core/services/network/api_error.dart';
import 'package:talkam/core/theme/pallets.dart';
import 'package:talkam/features/booking/data/models/session_receipt.dart';
import 'package:talkam/features/booking/data/models/therapist_slots_response.dart';
import 'package:talkam/features/booking/domain/repository/booking_repository.dart';
import 'package:talkam/features/booking/presentation/blocs/booking_cubit/booking_cubit.dart';
import 'package:talkam/features/session/data/models/session_model.dart';
import 'package:talkam/features/session/data/sessions_refresh_signal.dart';
import 'package:talkam/features/notifications/presentation/widgets/therapist_action_dialogs.dart';

class SessionActionSheets {
  static void showRescheduleSheet(
    BuildContext context,
    SessionModel session, {
    VoidCallback? onSuccess,
  }) {
    showModalBottomSheet(
      context: context,
      useRootNavigator: true,
      useSafeArea: true,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) =>
          _RescheduleStepOneSheet(session: session, onSuccess: onSuccess),
    );
  }

  static void showCancelSheet(
    BuildContext context,
    SessionModel session, {
    VoidCallback? onSuccess,
  }) {
    TherapistActionDialogs.showDeclineReasonBottomSheet(
      context,
      session: session,
      onSuccess: onSuccess,
    );
  }

  static void showStatusDialog(
    BuildContext context, {
    required bool isSuccess,
    String? title,
    String? message,
  }) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => _SessionStatusDialog(
        isSuccess: isSuccess,
        title: title,
        message: message,
      ),
    );
  }

  static void showInSessionNotesSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(28.r)),
      ),
      builder: (context) => const _InSessionNotesSheet(),
    );
  }

  /// Fetches the receipt for this booking and shows it — the API call
  /// happens after the sheet opens so the loading state renders in place.
  static void showReceiptSheet(BuildContext context, SessionModel session) {
    showModalBottomSheet(
      context: context,
      useRootNavigator: true,
      useSafeArea: true,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _ReceiptSheet(session: session),
    );
  }

  /// Lets the user finish paying for a booking that was never completed
  /// (e.g. a slot that passed while still `pending_payment`) instead of
  /// leaving them stuck with an unpaid session and no way to act on it.
  static void showCompletePaymentSheet(BuildContext context, SessionModel session) {
    showModalBottomSheet(
      context: context,
      useRootNavigator: true,
      useSafeArea: true,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _CompletePaymentSheet(session: session),
    );
  }

  /// A therapist-facing session summary built entirely from data the list
  /// already has — no network call, since the receipt endpoint is scoped to
  /// the client (session.user_id) and 404s for a therapist caller.
  static void showTherapistSessionSummarySheet(
      BuildContext context, SessionModel session) {
    showModalBottomSheet(
      context: context,
      useRootNavigator: true,
      useSafeArea: true,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _TherapistSessionSummarySheet(session: session),
    );
  }
}

class _RescheduleStepOneSheet extends StatefulWidget {
  final SessionModel session;
  final VoidCallback? onSuccess;

  const _RescheduleStepOneSheet({required this.session, this.onSuccess});

  @override
  State<_RescheduleStepOneSheet> createState() => _RescheduleStepOneSheetState();
}

class _RescheduleStepOneSheetState extends State<_RescheduleStepOneSheet> {
  final BookingCubit _cubit = BookingCubit();

  late final List<DateTime> _days =
      List.generate(14, (i) => DateTime.now().add(Duration(days: i + 1)));
  late DateTime _selectedDay = _days[0];
  TherapistSlot? _selectedSlot;

  static const _weekdayAbbrev = [
    'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'
  ];

  String get _dateKey {
    final d = _selectedDay;
    return "${d.year}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}";
  }

  @override
  void initState() {
    super.initState();
    _loadSlotsForSelectedDay();
  }

  @override
  void dispose() {
    _cubit.close();
    super.dispose();
  }

  void _loadSlotsForSelectedDay() {
    final therapistId = widget.session.therapistId;
    if (therapistId == null) return;
    setState(() => _selectedSlot = null);
    _cubit.loadSlots(therapistId, _dateKey);
  }

  @override
  Widget build(BuildContext context) {
    final therapistId = widget.session.therapistId;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
      decoration: BoxDecoration(
        color: Pallets.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(28.r)),
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          Center(
            child: Container(
              width: 40.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: const Color(0xFFCBD5E1),
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
          ),
          20.verticalSpace,
          TextView(
            text: "Reschedule this\nsession?",
            fontSize: 22,
            fontWeight: FontWeight.w700,
            color: Pallets.boldBlack,
            lineHeight: 1.2,
          ),
          8.verticalSpace,
          TextView(
            text:
                "${widget.session.therapistName} • ${widget.session.displayDate} • ${widget.session.displayTime}",
            fontSize: 13,
            fontWeight: FontWeight.w400,
            color: const Color(0xFF94A3B8),
          ),
          24.verticalSpace,
          if (therapistId == null)
            Padding(
              padding: EdgeInsets.symmetric(vertical: 24.h),
              child: TextView(
                text: "Rescheduling isn't available for this session.",
                fontSize: 13,
                color: const Color(0xFF64748B),
                align: TextAlign.center,
              ),
            )
          else ...[
            TextView(
              text: "NEW DATE",
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF475569),
            ),
            12.verticalSpace,
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: _days.map((day) {
                  final isSelected = _selectedDay.year == day.year &&
                      _selectedDay.month == day.month &&
                      _selectedDay.day == day.day;
                  return GestureDetector(
                    onTap: () {
                      setState(() => _selectedDay = day);
                      _loadSlotsForSelectedDay();
                    },
                    child: Container(
                      margin: EdgeInsets.only(right: 8.w),
                      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
                      decoration: BoxDecoration(
                        color: isSelected ? Pallets.blueBubbleColor : const Color(0xFFF8FAFC),
                        borderRadius: BorderRadius.circular(16.r),
                      ),
                      child: TextView(
                        text: "${_weekdayAbbrev[day.weekday - 1]} ${day.day}",
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: isSelected ? Pallets.white : const Color(0xFF64748B),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            24.verticalSpace,
            TextView(
              text: "NEW TIME",
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF475569),
            ),
            12.verticalSpace,
            // Real available slots for the selected day — a slot picked
            // here is guaranteed bookable, unlike the old fixed time list
            // that let you request times the therapist never offers.
            BlocBuilder<BookingCubit, BookingState>(
              bloc: _cubit,
              builder: (context, state) {
                final isLoading = state.status == BookingStatus.loading;
                final slots = state.slotsResponse?.slots ?? [];

                if (isLoading) {
                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: 12.h),
                    child: Center(child: CustomDialogs.getLoading(size: 28)),
                  );
                }
                if (state.status == BookingStatus.error) {
                  return TextView(
                    text: state.errorMessage ?? "Couldn't load slots for this day.",
                    fontSize: 13,
                    color: const Color(0xFFDC2626),
                  );
                }
                if (slots.isEmpty) {
                  return TextView(
                    text: "No available slots on this day.",
                    fontSize: 13,
                    color: const Color(0xFF94A3B8),
                  );
                }
                return Wrap(
                  spacing: 8.w,
                  runSpacing: 8.h,
                  children: slots.map((slot) {
                    final isSelected = _selectedSlot?.startsAt == slot.startsAt;
                    return GestureDetector(
                      onTap: () => setState(() => _selectedSlot = slot),
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
                        decoration: BoxDecoration(
                          color: isSelected ? Pallets.blueBubbleColor : const Color(0xFFF8FAFC),
                          borderRadius: BorderRadius.circular(16.r),
                          border: Border.all(
                            color: isSelected ? Pallets.blueBubbleColor : const Color(0xFFE2E8F0),
                          ),
                        ),
                        child: TextView(
                          text: slot.formattedTime,
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: isSelected ? Pallets.white : const Color(0xFF334155),
                        ),
                      ),
                    );
                  }).toList(),
                );
              },
            ),
          ],
          32.verticalSpace,
          Row(
            children: [
              Expanded(
                child: CustomButton(
                  onPressed: () => Navigator.pop(context),
                  bgColor: const Color(0xFFF8FAFC),
                  child: TextView(
                    text: "Keep session",
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Pallets.boldBlack,
                  ),
                ),
              ),
              16.horizontalSpace,
              Expanded(
                child: CustomButton(
                  onPressed: _selectedSlot == null
                      ? null
                      : () {
                          final newStartsAt = _selectedSlot!.startsAt;
                          Navigator.pop(context);
                          showModalBottomSheet(
                            context: context,
                            useRootNavigator: true,
                            useSafeArea: true,
                            isScrollControlled: true,
                            backgroundColor: Colors.transparent,
                            builder: (context) => _RescheduleReasonSheet(
                              session: widget.session,
                              newStartsAt: newStartsAt,
                              onSuccess: widget.onSuccess,
                            ),
                          );
                        },
                  text: "Next",
                ),
              ),
            ],
          ),
          20.verticalSpace,
          SizedBox(height: MediaQuery.of(context).padding.bottom),
        ],
      ),
    ),
    );
  }
}

/// Maps the picker's human-readable label to SessionConstants::RESCHEDULE_REASONS
/// on the backend — sending anything else 422s.
const Map<String, String> _kRescheduleReasonValues = {
  "Personal emergency": "personal_emergency",
  "Technical issues": "technical_issues",
  "Client request": "client_request",
};

class _RescheduleReasonSheet extends StatefulWidget {
  final SessionModel session;

  /// Raw `starts_at` string straight from the slot the user picked (see
  /// [TherapistSlot.startsAt]) — passed through to the API unchanged rather
  /// than round-tripped through a local `DateTime`, so it can never drift
  /// from the exact value the backend already validated as bookable.
  final String newStartsAt;
  final VoidCallback? onSuccess;

  const _RescheduleReasonSheet({
    required this.session,
    required this.newStartsAt,
    this.onSuccess,
  });

  @override
  State<_RescheduleReasonSheet> createState() => _RescheduleReasonSheetState();
}

class _RescheduleReasonSheetState extends State<_RescheduleReasonSheet> {
  String _selectedReason = "Technical issues";
  bool _submitting = false;

  final List<String> _reasons = [
    "Personal emergency",
    "Technical issues",
    "Client request",
  ];

  static const _weekdayAbbrev = [
    'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'
  ];

  DateTime? get _parsedNewStartsAt => DateTime.tryParse(widget.newStartsAt);

  String get _isoNewStartsAt => widget.newStartsAt;

  String get _displayNewDay {
    final d = _parsedNewStartsAt;
    if (d == null) return '';
    return "${_weekdayAbbrev[d.weekday - 1]} ${d.day}";
  }

  String get _displayNewTime {
    final d = _parsedNewStartsAt;
    if (d == null) return '';
    final hour = d.hour % 12 == 0 ? 12 : d.hour % 12;
    final minute = d.minute.toString().padLeft(2, '0');
    final period = d.hour >= 12 ? 'PM' : 'AM';
    return '$hour:$minute $period';
  }

  Future<void> _submit() async {
    final bookingId = int.tryParse(widget.session.id);
    if (bookingId == null) return;

    setState(() => _submitting = true);
    try {
      await injector.get<BookingRepository>().requestReschedule(
            bookingId,
            newStartsAt: _isoNewStartsAt,
            reason: _kRescheduleReasonValues[_selectedReason]!,
          );
      if (!mounted) return;
      Navigator.pop(context);
      widget.onSuccess?.call();
      SessionActionSheets.showStatusDialog(
        context,
        isSuccess: true,
        title: "Reschedule requested",
        message:
            "We've asked ${widget.session.therapistName} to confirm the new time.",
      );
    } catch (e) {
      if (!mounted) return;
      setState(() => _submitting = false);
      final message = e is ApiError
          ? (e.errorDescription ?? 'Could not request a reschedule.')
          : 'Could not request a reschedule.';
      Navigator.pop(context);
      SessionActionSheets.showStatusDialog(
        context,
        isSuccess: false,
        title: "Reschedule failed",
        message: message,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
      decoration: BoxDecoration(
        color: Pallets.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(28.r)),
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          Center(
            child: Container(
              width: 40.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: const Color(0xFFCBD5E1),
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
          ),
          20.verticalSpace,
          TextView(
            text: "Reschedule this\nsession?",
            fontSize: 22,
            fontWeight: FontWeight.w700,
            color: Pallets.boldBlack,
            lineHeight: 1.2,
          ),
          8.verticalSpace,
          TextView(
            text:
                "${widget.session.therapistName} • moving to $_displayNewDay • $_displayNewTime",
            fontSize: 13,
            fontWeight: FontWeight.w400,
            color: const Color(0xFF94A3B8),
          ),
          24.verticalSpace,
          TextView(
            text: "REASON FOR RESCHEDULE",
            fontSize: 12,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF475569),
          ),
          12.verticalSpace,
          ..._reasons.map((reason) {
            final isSelected = _selectedReason == reason;
            return GestureDetector(
              onTap: () {
                setState(() {
                  _selectedReason = reason;
                });
              },
              child: Container(
                margin: EdgeInsets.only(bottom: 12.h),
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
                decoration: BoxDecoration(
                  color: isSelected ? const Color(0xFFF4FBFF) : Pallets.white,
                  border: Border.all(
                    color: isSelected ? Pallets.blueBubbleColor : const Color(0xFFE2E8F0),
                    width: isSelected ? 1.5 : 1.0,
                  ),
                  borderRadius: BorderRadius.circular(16.r),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextView(
                      text: reason,
                      fontSize: 14,
                      fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                      color: isSelected ? Pallets.blueBubbleColor : Pallets.boldBlack,
                    ),
                    Container(
                      width: 20.w,
                      height: 20.w,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: isSelected ? Pallets.blueBubbleColor : const Color(0xFFCBD5E1),
                          width: 2,
                        ),
                      ),
                      child: isSelected
                          ? Center(
                              child: Container(
                                width: 10.w,
                                height: 10.w,
                                decoration: const BoxDecoration(
                                  color: Pallets.blueBubbleColor,
                                  shape: BoxShape.circle,
                                ),
                              ),
                            )
                          : null,
                    ),
                  ],
                ),
              ),
            );
          }),
          24.verticalSpace,
          Row(
            children: [
              Expanded(
                child: CustomButton(
                  onPressed: () => Navigator.pop(context),
                  bgColor: const Color(0xFFF8FAFC),
                  child: TextView(
                    text: "Keep session",
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Pallets.boldBlack,
                  ),
                ),
              ),
              16.horizontalSpace,
              Expanded(
                child: CustomButton(
                  onPressed: _submitting ? null : _submit,
                  bgColor: const Color(0xFFEF4444),
                  child: _submitting
                      ? SizedBox(
                          width: 18.w,
                          height: 18.w,
                          child: const CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      : TextView(
                          text: "Reschedule",
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: Pallets.white,
                        ),
                ),
              ),
            ],
          ),
          20.verticalSpace,
          SizedBox(height: MediaQuery.of(context).padding.bottom),
        ],
      ),
    ),
    );
  }
}

class _SessionStatusDialog extends StatelessWidget {
  final bool isSuccess;
  final String? title;
  final String? message;

  const _SessionStatusDialog({required this.isSuccess, this.title, this.message});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28.r)),
      backgroundColor: Pallets.white,
      child: Padding(
        padding: EdgeInsets.all(24.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            12.verticalSpace,
            Container(
              width: 80.w,
              height: 80.w,
              decoration: BoxDecoration(
                color: isSuccess ? const Color(0xFFE6F9F0) : const Color(0xFFFFF1F2),
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSuccess ? const Color(0xFFDCFCE7) : const Color(0xFFFFE4E6),
                  width: 5.w,
                ),
              ),
              child: Center(
                child: Icon(
                  isSuccess ? Icons.check_rounded : Icons.close_rounded,
                  color: isSuccess ? const Color(0xFF10B981) : const Color(0xFFEF4444),
                  size: 40.w,
                ),
              ),
            ),
            20.verticalSpace,
            TextView(
              text: title ??
                  (isSuccess ? "Session Rescheduled" : "Session Declined"),
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: Pallets.boldBlack,
            ),
            12.verticalSpace,
            TextView(
              text: message ??
                  (isSuccess
                      ? "Your session is rescheduled. Continue using the service uninterrupted."
                      : "Your rescheduled session has been declined"),
              fontSize: 13,
              fontWeight: FontWeight.w400,
              color: const Color(0xFF64748B),
              align: TextAlign.center,
              lineHeight: 1.4,
            ),
            24.verticalSpace,
            CustomButton(
              onPressed: () => Navigator.pop(context),
              bgColor: isSuccess ? Pallets.blueBubbleColor : const Color(0xFFEF4444),
              text: isSuccess ? "Back to sessions" : "Try again",
            ),
            8.verticalSpace,
          ],
        ),
      ),
    );
  }
}

class _InSessionNotesSheet extends StatefulWidget {
  const _InSessionNotesSheet();

  @override
  State<_InSessionNotesSheet> createState() => _InSessionNotesSheetState();
}

class _InSessionNotesSheetState extends State<_InSessionNotesSheet> {
  final TextEditingController _noteController =
      TextEditingController(text: "Clients reports sleeping better this week");

  final Set<String> _selectedChips = {"Anxiety", "Depression"};

  final List<String> _chips = [
    "Anxiety",
    "Depression",
    "Trauma & PTSD",
    "Grief",
    "Bipolar",
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom + 24.h,
        top: 16.h,
        left: 20.w,
        right: 20.w,
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          Center(
            child: Container(
              width: 44.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: const Color(0xFFCBD5E1),
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
          ),
          16.verticalSpace,
          const TextView(
            text: "Session Notes",
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: Pallets.boldBlack,
          ),
          16.verticalSpace,

          // Tag Chips
          Wrap(
            spacing: 8.w,
            runSpacing: 8.h,
            children: _chips.map((chip) {
              final isSelected = _selectedChips.contains(chip);
              return GestureDetector(
                onTap: () {
                  setState(() {
                    if (isSelected) {
                      _selectedChips.remove(chip);
                    } else {
                      _selectedChips.add(chip);
                    }
                  });
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                  decoration: BoxDecoration(
                    color: isSelected ? Pallets.blueBubbleColor : const Color(0xFFF1F5F9),
                    borderRadius: BorderRadius.circular(100.r),
                  ),
                  child: TextView(
                    text: chip,
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: isSelected ? Colors.white : const Color(0xFF475569),
                  ),
                ),
              );
            }).toList(),
          ),
          20.verticalSpace,

          // Notes Input Box
          Container(
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16.r),
              border: Border.all(color: Pallets.blueBubbleColor, width: 1.5),
            ),
            child: TextField(
              controller: _noteController,
              maxLines: 4,
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: "Enter session notes...",
              ),
              style: TextStyle(
                fontSize: 14.sp,
                color: Pallets.boldBlack,
              ),
            ),
          ),
          24.verticalSpace,

          // Action Buttons
          Row(
            children: [
              Expanded(
                child: CustomButton(
                  onPressed: () => Navigator.pop(context),
                  bgColor: const Color(0xFFF8FAFC),
                  child: const TextView(
                    text: "Save draft",
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Pallets.boldBlack,
                  ),
                ),
              ),
              12.horizontalSpace,
              Expanded(
                child: CustomButton(
                  onPressed: () => Navigator.pop(context),
                  bgColor: Pallets.blueBubbleColor,
                  child: const TextView(
                    text: "Save & Close",
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          12.verticalSpace,
        ],
      ),
    )
    );
  }
}

class _ReceiptSheet extends StatefulWidget {
  final SessionModel session;

  const _ReceiptSheet({required this.session});

  @override
  State<_ReceiptSheet> createState() => _ReceiptSheetState();
}

class _ReceiptSheetState extends State<_ReceiptSheet> {
  SessionReceipt? _receipt;
  String? _error;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final bookingId = int.tryParse(widget.session.id);
    if (bookingId == null) {
      setState(() => _error = 'Receipt unavailable for this session.');
      return;
    }
    try {
      final receipt =
          await injector.get<BookingRepository>().getReceipt(bookingId);
      if (!mounted) return;
      setState(() => _receipt = receipt);
    } catch (e) {
      if (!mounted) return;
      setState(() => _error = e is ApiError
          ? (e.errorDescription ?? 'Could not load the receipt.')
          : 'Could not load the receipt.');
    }
  }

  Widget _row(String label, String value) => Padding(
        padding: EdgeInsets.only(bottom: 12.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextView(
              text: label,
              fontSize: 13,
              fontWeight: FontWeight.w400,
              color: const Color(0xFF64748B),
            ),
            TextView(
              text: value,
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: Pallets.boldBlack,
            ),
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
      decoration: BoxDecoration(
        color: Pallets.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(28.r)),
      ),
      child: SafeArea(
        top: false,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40.w,
                  height: 4.h,
                  decoration: BoxDecoration(
                    color: const Color(0xFFCBD5E1),
                    borderRadius: BorderRadius.circular(2.r),
                  ),
                ),
              ),
              20.verticalSpace,
              const TextView(
                text: "Receipt",
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: Pallets.boldBlack,
              ),
              20.verticalSpace,
              if (_error != null)
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 24.h),
                  child: Column(
                    children: [
                      TextView(
                        text: _error!,
                        fontSize: 14,
                        color: const Color(0xFF64748B),
                        align: TextAlign.center,
                      ),
                      if (widget.session.status == 'pending_payment') ...[
                        16.verticalSpace,
                        CustomButton(
                          onPressed: () {
                            Navigator.pop(context);
                            SessionActionSheets.showCompletePaymentSheet(
                              context,
                              widget.session,
                            );
                          },
                          text: "Complete Payment",
                        ),
                      ],
                    ],
                  ),
                )
              else if (_receipt == null)
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 24.h),
                  child: Center(child: CustomDialogs.getLoading(size: 36)),
                )
              else ...[
                _row("Therapist",
                    _receipt!.session.therapistName ?? widget.session.therapistName),
                _row("Date", _receipt!.session.startsAt),
                _row("Format", _receipt!.session.format),
                _row("Amount", "${_receipt!.currency} ${_receipt!.amount}"),
                if (_receipt!.fees != null)
                  _row("Fees", "${_receipt!.currency} ${_receipt!.fees}"),
                if (_receipt!.narration != null)
                  _row("Narration", _receipt!.narration!),
                if (_receipt!.paidAt != null) _row("Paid", _receipt!.paidAt!),
                _row("Reference", _receipt!.reference),
              ],
              12.verticalSpace,
              CustomButton(
                onPressed: () => Navigator.pop(context),
                text: "Done",
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CompletePaymentSheet extends StatefulWidget {
  final SessionModel session;

  const _CompletePaymentSheet({required this.session});

  @override
  State<_CompletePaymentSheet> createState() => _CompletePaymentSheetState();
}

class _CompletePaymentSheetState extends State<_CompletePaymentSheet> {
  final BookingCubit _cubit = BookingCubit();

  @override
  void dispose() {
    _cubit.close();
    super.dispose();
  }

  void _pay() {
    final bookingId = int.tryParse(widget.session.id);
    if (bookingId == null) return;
    _cubit.retryPayment(bookingId, context);
  }

  @override
  Widget build(BuildContext context) {
    final priceStr = "₦${widget.session.price.toInt().toString().replaceAllMapped(
          RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (m) => '${m[1]},',
        )}";

    return BlocProvider.value(
      value: _cubit,
      child: BlocListener<BookingCubit, BookingState>(
        listenWhen: (prev, curr) => curr.status != prev.status,
        listener: (context, state) {
          if (state.status == BookingStatus.paymentSuccess) {
            SessionsRefreshSignal.ping();
            Navigator.pop(context);
            SessionActionSheets.showStatusDialog(
              context,
              isSuccess: true,
              title: "Payment completed",
              message:
                  "Your session with ${widget.session.therapistName} is now confirmed.",
            );
          } else if (state.status == BookingStatus.paymentFailed) {
            SessionActionSheets.showStatusDialog(
              context,
              isSuccess: false,
              title: "Payment failed",
              message: state.errorMessage ?? "Could not complete payment.",
            );
          }
        },
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
          decoration: BoxDecoration(
            color: Pallets.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(28.r)),
          ),
          child: SafeArea(
            top: false,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 40.w,
                    height: 4.h,
                    decoration: BoxDecoration(
                      color: const Color(0xFFCBD5E1),
                      borderRadius: BorderRadius.circular(2.r),
                    ),
                  ),
                ),
                20.verticalSpace,
                const TextView(
                  text: "Complete your payment",
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: Pallets.boldBlack,
                ),
                8.verticalSpace,
                TextView(
                  text:
                      "${widget.session.therapistName} • ${widget.session.displayDate} • ${widget.session.displayTime}",
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: Pallets.grey400,
                ),
                4.verticalSpace,
                const TextView(
                  text:
                      "This session hasn't been paid for yet, so it was never confirmed. Complete payment to lock in your slot.",
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: Pallets.grey400,
                ),
                20.verticalSpace,
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF7F7F7),
                    borderRadius: BorderRadius.circular(14.r),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const TextView(
                        text: "Amount due",
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Pallets.boldBlack,
                      ),
                      TextView(
                        text: priceStr,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Pallets.boldBlack,
                      ),
                    ],
                  ),
                ),
                24.verticalSpace,
                BlocBuilder<BookingCubit, BookingState>(
                  builder: (context, state) {
                    final isLoading =
                        state.status == BookingStatus.paymentInitiated ||
                            state.status == BookingStatus.loading;
                    return CustomButton(
                      onPressed: isLoading ? null : _pay,
                      child: isLoading
                          ? SizedBox(
                              width: 18.w,
                              height: 18.w,
                              child: const CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Colors.white,
                              ),
                            )
                          : const TextView(
                              text: "Complete Payment",
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 15,
                            ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _TherapistSessionSummarySheet extends StatelessWidget {
  final SessionModel session;

  const _TherapistSessionSummarySheet({required this.session});

  Widget _row(String label, String value) => Padding(
        padding: EdgeInsets.only(bottom: 12.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextView(
              text: label,
              fontSize: 13,
              fontWeight: FontWeight.w400,
              color: const Color(0xFF64748B),
            ),
            TextView(
              text: value,
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: Pallets.boldBlack,
            ),
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    final earnings = "₦${session.price.toInt().toString().replaceAllMapped(
          RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (m) => '${m[1]},',
        )}";

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
      decoration: BoxDecoration(
        color: Pallets.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(28.r)),
      ),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40.w,
                height: 4.h,
                decoration: BoxDecoration(
                  color: const Color(0xFFCBD5E1),
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),
            ),
            20.verticalSpace,
            const TextView(
              text: "Session Summary",
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: Pallets.boldBlack,
            ),
            20.verticalSpace,
            _row("Client", session.therapistName),
            _row("Date", session.displayDate),
            _row("Time", session.displayTime),
            _row("Format", session.format),
            _row("Your earnings", earnings),
            if (session.rating > 0)
              _row("Client rating", "${session.rating.toStringAsFixed(1)} / 5.0"),
            12.verticalSpace,
            CustomButton(
              onPressed: () => Navigator.pop(context),
              text: "Done",
            ),
          ],
        ),
      ),
    );
  }
}
