import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:talkam/common/widgets/custom_button.dart';
import 'package:talkam/common/widgets/custom_dialogs.dart';
import 'package:talkam/common/widgets/custom_outlined_button.dart';
import 'package:talkam/common/widgets/image_widget.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/di/injector.dart';
import 'package:talkam/core/services/network/api_error.dart';
import 'package:talkam/core/theme/pallets.dart';
import 'package:talkam/core/utils/string_extension.dart';
import 'package:talkam/features/booking/domain/repository/booking_repository.dart';
import 'package:talkam/features/therapist/data/models/session_request_sheet.dart';
import 'package:talkam/features/therapist/dormain/repository/therapist_repository.dart';
import 'package:talkam/features/therapist/presentation/bloc/session_request_cubit/session_request_cubit.dart';
import 'package:talkam/features/therapist/presentation/bloc/therapist_client_cubit/therapist_client_cubit.dart'
    show LoadStatus;
import 'package:talkam/gen/assets.gen.dart';
import 'package:talkam/features/session/data/models/session_model.dart';

class TherapistActionDialogs {
  static void showSessionAcceptedDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24.r),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 32.h),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 80.w,
                  height: 80.w,
                  decoration: BoxDecoration(
                    color: const Color(0xFFE8F8F0),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Icon(
                      Icons.check,
                      color: const Color(0xFF0F9C5B),
                      size: 40.w,
                    ),
                  ),
                ),
                16.verticalSpace,
                const TextView(
                  text: "Session Accepted",
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: Pallets.boldBlack,
                  align: TextAlign.center,
                ),
                8.verticalSpace,
                const TextView(
                  text:
                      "You have accepted a session. You can continue using the service without delay.",
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Pallets.grey400,
                  align: TextAlign.center,
                  lineHeight: 1.5,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  static void showSessionDeclinedDialog(
    BuildContext context, {
    bool isError = false,
    String? title,
    String? message,
  }) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24.r),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 32.h),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 80.w,
                  height: 80.w,
                  decoration: BoxDecoration(
                    color: const Color(0xFFFBEAEA),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Icon(
                      Icons.close,
                      color: const Color(0xFFE53935),
                      size: 40.w,
                    ),
                  ),
                ),
                16.verticalSpace,
                TextView(
                  text: title ??
                      (isError ? "Cancellation failed" : "Session Declined"),
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: Pallets.boldBlack,
                  align: TextAlign.center,
                ),
                8.verticalSpace,
                TextView(
                  text: message ??
                      (isError
                          ? "Please try again."
                          : "You have declined your session"),
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Pallets.grey400,
                  align: TextAlign.center,
                  lineHeight: 1.5,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  /// [sessionId] is the id from the triggering notification's `data_id` —
  /// the assigned therapist's `GET /therapist/sessions/{id}/request` view.
  static void showSessionRequestBottomSheet(
    BuildContext context, {
    required int sessionId,
    VoidCallback? onAcknowledged,
    VoidCallback? onDeclined,
  }) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(32.r)),
      ),
      builder: (context) {
        return _SessionRequestSheet(
          sessionId: sessionId,
          onAcknowledged: onAcknowledged,
          onDeclined: onDeclined,
        );
      },
    );
  }

  /// Either pass [session] (existing sessions-list flow) or [bookingId] +
  /// [subtitle] directly (no [SessionModel] on hand, e.g. from a
  /// notification's request sheet) — [bookingId] wins if both are given.
  static void showDeclineReasonBottomSheet(
    BuildContext context, {
    SessionModel? session,
    int? bookingId,
    String? subtitle,
    VoidCallback? onSuccess,
  }) {
    showModalBottomSheet(
      context: context,
      useRootNavigator: true,
      useSafeArea: true,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(32.r)),
      ),
      builder: (context) {
        return _DeclineReasonSheet(
          session: session,
          bookingId: bookingId,
          subtitle: subtitle,
          onSuccess: onSuccess,
        );
      },
    );
  }
}

class _DeclineReasonSheet extends StatefulWidget {
  final SessionModel? session;
  final int? bookingId;
  final String? subtitle;
  final VoidCallback? onSuccess;

  const _DeclineReasonSheet({
    this.session,
    this.bookingId,
    this.subtitle,
    this.onSuccess,
  });

  @override
  State<_DeclineReasonSheet> createState() => _DeclineReasonSheetState();
}

class _DeclineReasonSheetState extends State<_DeclineReasonSheet> {
  String? selectedReason;
  bool submitting = false;

  final reasons = [
    "Personal emergency",
    "Technical issues",
    "Client request",
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom + 24.h,
        top: 16.h,
        left: 24.w,
        right: 24.w,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 48.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: Pallets.grey90,
                borderRadius: BorderRadius.circular(4.r),
              ),
            ),
          ),
          24.verticalSpace,
          const TextView(
            text: "Cancel this session?",
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: Pallets.boldBlack,
          ),
          8.verticalSpace,
          TextView(
            text: widget.subtitle ??
                (widget.session != null
                    ? "${widget.session!.therapistName} • ${widget.session!.displayDate} • ${widget.session!.displayTime}"
                    : ""),
            fontSize: 12,
            fontWeight: FontWeight.w400,
            color: Pallets.grey400,
          ),
          4.verticalSpace,
          const TextView(
            text: "Cancellations within 24h may affect your rating",
            fontSize: 12,
            fontWeight: FontWeight.w400,
            color: Pallets.grey400,
          ),
          24.verticalSpace,
          const TextView(
            text: "REASON FOR CANCELLATION",
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: Pallets.grey400,
          ),
          12.verticalSpace,
          ...reasons.map((reason) {
            final isSelected = selectedReason == reason;
            return GestureDetector(
              onTap: () {
                setState(() {
                  selectedReason = reason;
                });
              },
              child: Container(
                margin: EdgeInsets.only(bottom: 12.h),
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
                decoration: BoxDecoration(
                  border: Border.all(
                    color:
                        isSelected ? Pallets.blueBubbleColor : Pallets.grey90,
                    width: isSelected ? 1.5 : 1,
                  ),
                  borderRadius: BorderRadius.circular(12.r),
                  color: isSelected
                      ? Pallets.blueBubbleColor.withValues(alpha: 0.05)
                      : Colors.white,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextView(
                        text: reason,
                        fontSize: 14,
                        fontWeight:
                            isSelected ? FontWeight.w600 : FontWeight.w400,
                        color: isSelected
                            ? Pallets.blueBubbleColor
                            : Pallets.boldBlack,
                      ),
                    ),
                    Icon(
                      isSelected
                          ? Icons.radio_button_checked
                          : Icons.radio_button_unchecked,
                      color:
                          isSelected ? Pallets.blueBubbleColor : Pallets.grey90,
                      size: 20.w,
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
                  bgColor: const Color(0xFFF7F7F7),
                  elevation: 0,
                  child: const TextView(
                    text: "Keep session",
                    color: Pallets.boldBlack,
                    fontWeight: FontWeight.w700,
                    fontSize: 15,
                  ),
                ),
              ),
              16.horizontalSpace,
              Expanded(
                child: CustomButton(
                  onPressed:
                      selectedReason == null || submitting ? null : _submit,
                  bgColor: const Color(0xFFE53935),
                  elevation: 0,
                  child: submitting
                      ? SizedBox(
                          width: 18.w,
                          height: 18.w,
                          child: const CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      : const TextView(
                          text: "Yes Cancel",
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 15,
                        ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> _submit() async {
    final bookingId =
        widget.bookingId ?? int.tryParse(widget.session?.id ?? '');
    if (bookingId == null) {
      // No real booking behind this sheet (e.g. reached via a mock/demo
      // path) — keep the old cosmetic behaviour rather than erroring.
      Navigator.pop(context);
      TherapistActionDialogs.showSessionDeclinedDialog(context);
      return;
    }

    setState(() => submitting = true);
    try {
      await injector.get<BookingRepository>().cancelBooking(
            bookingId,
            reason: selectedReason,
          );
      if (!mounted) return;
      Navigator.pop(context);
      widget.onSuccess?.call();
      TherapistActionDialogs.showSessionDeclinedDialog(
        context,
        title: "Session cancelled",
        message: "This session has been cancelled.",
      );
    } catch (e) {
      if (!mounted) return;
      setState(() => submitting = false);
      final message = e is ApiError
          ? (e.errorDescription ?? 'Could not cancel this session.')
          : 'Could not cancel this session.';
      Navigator.pop(context);
      TherapistActionDialogs.showSessionDeclinedDialog(
        context,
        isError: true,
        message: message,
      );
    }
  }
}

class _SessionRequestSheet extends StatefulWidget {
  const _SessionRequestSheet({
    required this.sessionId,
    this.onAcknowledged,
    this.onDeclined,
  });

  final int sessionId;
  final VoidCallback? onAcknowledged;
  final VoidCallback? onDeclined;

  @override
  State<_SessionRequestSheet> createState() => _SessionRequestSheetState();
}

class _SessionRequestSheetState extends State<_SessionRequestSheet> {
  final cubit = SessionRequestCubit(injector.get<TherapistRepository>());

  @override
  void initState() {
    super.initState();
    cubit.load(widget.sessionId);
  }

  @override
  void dispose() {
    cubit.close();
    super.dispose();
  }

  Future<void> _accept() async {
    final ok = await cubit.acknowledge(widget.sessionId);
    if (!mounted) return;
    if (ok) {
      Navigator.pop(context);
      widget.onAcknowledged?.call();
      TherapistActionDialogs.showSessionAcceptedDialog(context);
    } else {
      CustomDialogs.showToast(
        cubit.state.acknowledgeError ?? 'Could not accept this session.',
        isError: true,
      );
    }
  }

  void _decline(SessionRequestSheet sheet) {
    Navigator.pop(context);
    TherapistActionDialogs.showDeclineReasonBottomSheet(
      context,
      bookingId: widget.sessionId,
      subtitle: "${sheet.clientName} • ${_formatDateTime(sheet.startsAt)}",
      onSuccess: widget.onDeclined,
    );
  }

  static String _formatDateTime(String raw) {
    final dt = DateTime.tryParse(raw);
    if (dt == null) return raw;
    const months = [
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
      'Dec',
    ];
    final hour = dt.hour % 12 == 0 ? 12 : dt.hour % 12;
    final minute = dt.minute.toString().padLeft(2, '0');
    final period = dt.hour >= 12 ? 'PM' : 'AM';
    return "${months[dt.month - 1]} ${dt.day} • $hour:$minute$period";
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom + 24.h,
        top: 16.h,
        left: 24.w,
        right: 24.w,
      ),
      child: BlocBuilder<SessionRequestCubit, SessionRequestState>(
        bloc: cubit,
        builder: (context, state) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 48.w,
                  height: 4.h,
                  decoration: BoxDecoration(
                    color: Pallets.grey90,
                    borderRadius: BorderRadius.circular(4.r),
                  ),
                ),
              ),
              24.verticalSpace,
              switch (state.status) {
                LoadStatus.loading || LoadStatus.idle => Padding(
                    padding: EdgeInsets.symmetric(vertical: 40.h),
                    child: Center(child: CustomDialogs.getLoading(size: 40)),
                  ),
                LoadStatus.error => Padding(
                    padding: EdgeInsets.symmetric(vertical: 24.h),
                    child: TextView(
                      text: state.error ?? "Couldn't load this request.",
                      fontSize: 14,
                      color: Pallets.grey400,
                      align: TextAlign.center,
                    ),
                  ),
                LoadStatus.success => _buildSheet(context, state, state.sheet!),
              },
            ],
          );
        },
      ),
    );
  }

  Widget _buildSheet(
    BuildContext context,
    SessionRequestState state,
    SessionRequestSheet sheet,
  ) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 8.w,
              height: 8.w,
              decoration: const BoxDecoration(
                color: Pallets.blueBubbleColor,
                shape: BoxShape.circle,
              ),
            ),
            8.horizontalSpace,
            const TextView(
              text: "New Booking Request",
              color: Pallets.blueBubbleColor,
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
          ],
        ),
        8.verticalSpace,
        TextView(
          text: "Session request\nfrom ${sheet.clientName}",
          fontSize: 24,
          fontWeight: FontWeight.w700,
          color: Pallets.boldBlack,
          lineHeight: 1.2,
        ),
        12.verticalSpace,
        Container(
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: Pallets.lightGrey,
            borderRadius: BorderRadius.circular(16.r),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 48.w,
                    height: 48.w,
                    decoration: const BoxDecoration(
                      color: Color(0xFFE8F1FC),
                      shape: BoxShape.circle,
                    ),
                    alignment: Alignment.center,
                    child: TextView(
                      text: sheet.clientName.isNotEmpty
                          ? sheet.clientName[0].toUpperCase()
                          : "?",
                      color: Pallets.blueBubbleColor,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  12.horizontalSpace,
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextView(
                          text: sheet.clientName,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Pallets.boldBlack,
                        ),
                        4.verticalSpace,
                        TextView(
                          text: [
                            if (sheet.newClient) "New client",
                            ...sheet.topics,
                          ].join(' • '),
                          fontSize: 12,
                          color: Pallets.grey400,
                          maxLines: 1,
                          textOverflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  if (sheet.newClient)
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE8F1FC),
                        borderRadius: BorderRadius.circular(100.r),
                      ),
                      child: const TextView(
                        text: "New",
                        color: Pallets.blueBubbleColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                ],
              ),
              16.verticalSpace,
              const Divider(color: Pallets.grey90, height: 1),
              16.verticalSpace,
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ImageWidget(
                    imageUrl: Assets.images.svgV2.calendarInActive,
                    color: Pallets.blueBubbleColor,
                  ),
                  12.horizontalSpace,
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextView(
                          text: _formatDateTime(sheet.startsAt),
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Pallets.boldBlack,
                        ),
                        2.verticalSpace,
                        TextView(
                          text:
                              "${sheet.format.isNotEmpty ? "${sheet.format[0].toUpperCase()}${sheet.format.substring(1)}" : sheet.format} session • ${sheet.durationMinutes} min",
                          fontSize: 12,
                          color: Pallets.grey400,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              16.verticalSpace,
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ImageWidget(
                    imageUrl: Assets.images.svgV2.dollar2,
                    color: Pallets.blueBubbleColor,
                  ),
                  12.horizontalSpace,
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextView(
                          text:
                              "₦${(double.tryParse(sheet.amount)?.toInt() ?? 0).toString().formatNumber()}",
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Pallets.boldBlack,
                        ),
                        2.verticalSpace,
                        TextView(
                          text:
                              "You receive: ₦${sheet.youReceive.toInt().toString().formatNumber()}",
                          fontSize: 12,
                          color: Pallets.grey400,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              if (sheet.note != null && sheet.note!.trim().isNotEmpty) ...[
                8.verticalSpace,
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(16.w),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFF9E5),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const TextView(
                        text: "Client's note",
                        color: Color(0xFFD97706),
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                      8.verticalSpace,
                      TextView(
                        text: "“${sheet.note}”",
                        color: Pallets.grey400,
                        fontSize: 12,
                        lineHeight: 1.5,
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),
        ),
        12.verticalSpace,
        if (sheet.isAcknowledged)
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 14.h),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: const Color(0xFFF0FDF4),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: const TextView(
              text: "Already accepted",
              color: Color(0xFF0F9D58),
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
          )
        else
          Row(
            children: [
              Expanded(
                child: CustomOutlinedButton(
                  onPressed: state.acknowledging ? null : () => _decline(sheet),
                  borderColor: Pallets.grey90,
                  foregroundColor: Pallets.boldBlack,
                  text: "Decline",
                ),
              ),
              16.horizontalSpace,
              Expanded(
                child: CustomButton(
                  onPressed: state.acknowledging ? null : _accept,
                  bgColor: Pallets.blueBubbleColor,
                  child: state.acknowledging
                      ? SizedBox(
                          width: 18.w,
                          height: 18.w,
                          child: const CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      : const TextView(
                          text: "Accept Session",
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                        ),
                ),
              ),
            ],
          ),
      ],
    );
  }
}
