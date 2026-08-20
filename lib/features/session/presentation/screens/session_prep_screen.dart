import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:talkam/common/widgets/custom_appbar.dart';
import 'package:talkam/common/widgets/custom_button.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/di/injector.dart';
import 'package:talkam/core/navigation/route_url.dart';
import 'package:talkam/core/theme/pallets.dart';
import 'package:talkam/features/session/data/models/session_model.dart';
import 'package:talkam/features/therapist/dormain/repository/therapist_repository.dart';
import 'package:talkam/features/therapist/presentation/bloc/therapist_client_cubit/therapist_client_cubit.dart';

class SessionPrepScreen extends StatefulWidget {
  final SessionModel? session;

  const SessionPrepScreen({super.key, this.session});

  @override
  State<SessionPrepScreen> createState() => _SessionPrepScreenState();
}

class _SessionPrepScreenState extends State<SessionPrepScreen> {
  /// The live countdown only starts ticking once the session is this close —
  /// before that we just show the scheduled time, not a running clock.
  static const _joinWindow = Duration(minutes: 30);

  Timer? _timer;
  Duration _remaining = Duration.zero;

  late final TherapistClientCubit _cubit =
      TherapistClientCubit(injector.get<TherapistRepository>());

  bool _step1Checked = false;
  bool _step2Checked = false;
  bool _step3Checked = false;

  DateTime? get _startsAt => widget.session?.startsAt;

  @override
  void initState() {
    super.initState();
    _updateRemaining();
    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (_) => _updateRemaining(),
    );

    final clientId = widget.session?.clientId;
    if (clientId != null) {
      _cubit.getClientDetails(clientId);
    }
  }

  void _updateRemaining() {
    final startsAt = _startsAt;
    final diff =
        startsAt == null ? Duration.zero : startsAt.difference(DateTime.now());
    if (!mounted) return;
    setState(() => _remaining = diff.isNegative ? Duration.zero : diff);
    if (!diff.isNegative && diff > Duration.zero) return;
    _timer?.cancel();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _cubit.close();
    super.dispose();
  }

  String _formatDuration(Duration duration) {
    final minutes = duration.inMinutes;
    final seconds = duration.inSeconds % 60;
    return "$minutes:${seconds.toString().padLeft(2, '0')}";
  }

  @override
  Widget build(BuildContext context) {
    final clientName = widget.session?.therapistName ?? "Client";
    final isWithinJoinWindow = _remaining <= _joinWindow;
    final isReady = _remaining <= Duration.zero;
    final progress = isWithinJoinWindow
        ? (1.0 - (_remaining.inSeconds / _joinWindow.inSeconds)).clamp(0.0, 1.0)
        : 0.0;

    return Scaffold(
      backgroundColor: Pallets.white,
      appBar: const CustomAppBar(
        centerTile: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              children: [
                10.verticalSpace,
                // Circular Countdown Timer
                Center(
                  child: SizedBox(
                    width: 200.w,
                    height: 200.w,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        SizedBox(
                          width: 190.w,
                          height: 190.w,
                          child: CircularProgressIndicator(
                            value: isReady ? 1.0 : (0.2 + (progress * 0.8)),
                            strokeWidth: 16.w,
                            backgroundColor: const Color(0xFFF1F5F9),
                            valueColor: const AlwaysStoppedAnimation<Color>(
                              Pallets.blueBubbleColor,
                            ),
                            strokeCap: StrokeCap.round,
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextView(
                              text: isWithinJoinWindow
                                  ? _formatDuration(_remaining)
                                  : (widget.session?.displayTime ?? "--:--"),
                              fontSize: 34,
                              fontWeight: FontWeight.w700,
                              color: Pallets.boldBlack,
                            ),
                            4.verticalSpace,
                            TextView(
                              text: isWithinJoinWindow
                                  ? "until session"
                                  : "Countdown starts 30 min before session",
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                              color: Pallets.grey400,
                              align: TextAlign.center,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                24.verticalSpace,

                // Client Card
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(20.w),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF8FAFC),
                    borderRadius: BorderRadius.circular(24.r),
                    border: Border.all(color: const Color(0xFFF1F5F9)),
                  ),
                  child: Column(
                    children: [
                      Container(
                        width: 56.w,
                        height: 56.w,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.person_outline,
                          color: Pallets.blueBubbleColor,
                          size: 28.w,
                        ),
                      ),
                      12.verticalSpace,
                      TextView(
                        text: clientName,
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: Pallets.boldBlack,
                      ),
                      6.verticalSpace,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.access_time,
                            size: 14.w,
                            color: Pallets.blueBubbleColor,
                          ),
                          4.horizontalSpace,
                          TextView(
                            text:
                                "${widget.session?.displayTime ?? ''}${widget.session != null ? ' • ' : ''}${widget.session?.format ?? 'Video'}"
                                    .trim(),
                            fontSize: 12,
                            color: Pallets.grey400,
                          ),
                        ],
                      ),
                      20.verticalSpace,
                      BlocBuilder<TherapistClientCubit, TherapistClientState>(
                        bloc: _cubit,
                        builder: (context, state) {
                          final detail = state.detail;
                          final plan = detail?.treatmentPlan;
                          final sessionsCount =
                              detail?.sessionsCount.toString() ?? "—";
                          final planTotal = (plan?.totalSessions ?? 0) > 0
                              ? plan!.totalSessions.toString()
                              : "—";
                          final progressLabel = plan?.progressStatus != null &&
                                  plan!.progressStatus.isNotEmpty
                              ? plan.progressStatus.replaceAll('_', ' ')
                              : "—";

                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              _MetricColumn(
                                  title: sessionsCount, subtitle: "Sessions"),
                              Container(
                                width: 1.w,
                                height: 28.h,
                                color: const Color(0xFFE2E8F0),
                              ),
                              _MetricColumn(
                                  title: planTotal, subtitle: "Plan total"),
                              Container(
                                width: 1.w,
                                height: 28.h,
                                color: const Color(0xFFE2E8F0),
                              ),
                              _MetricColumn(
                                title: progressLabel,
                                subtitle: "Progress",
                                titleColor: const Color(0xFF059669),
                              ),
                            ],
                          );
                        },
                      ),
                    ],
                  ),
                ),
                20.verticalSpace,

                // SESSION PREP checklist section
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(16.w),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF8FAFC),
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const TextView(
                        text: "SESSION PREP",
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF64748B),
                      ),
                      12.verticalSpace,
                      _CheckItem(
                        title: "Review $clientName's last session notes",
                        isChecked: _step1Checked,
                        onChanged: (val) => setState(() => _step1Checked = val!),
                      ),
                      10.verticalSpace,
                      _CheckItem(
                        title: "Camera and microphone tested",
                        isChecked: _step2Checked,
                        onChanged: (val) => setState(() => _step2Checked = val!),
                      ),
                      10.verticalSpace,
                      _CheckItem(
                        title: "Quiet environment confirmed",
                        isChecked: _step3Checked,
                        onChanged: (val) => setState(() => _step3Checked = val!),
                      ),
                    ],
                  ),
                ),
                32.verticalSpace,

                // Start Session Now button
                CustomButton(
                  onPressed: isReady
                      ? () {
                          context.pushNamed(
                            PageUrl.sessionCallScreen,
                            extra: widget.session,
                          );
                        }
                      : null,
                  bgColor: isReady
                      ? Pallets.blueBubbleColor
                      : Pallets.blueBubbleColor.withValues(alpha: 0.35),
                  text: "Start Session Now",
                ),
                20.verticalSpace,
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _MetricColumn extends StatelessWidget {
  final String title;
  final String subtitle;
  final Color? titleColor;

  const _MetricColumn({
    required this.title,
    required this.subtitle,
    this.titleColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextView(
          text: title,
          fontSize: 18,
          fontWeight: FontWeight.w700,
          color: titleColor ?? Pallets.boldBlack,
        ),
        4.verticalSpace,
        TextView(
          text: subtitle,
          fontSize: 12,
          color: Pallets.grey400,
        ),
      ],
    );
  }
}

class _CheckItem extends StatelessWidget {
  final String title;
  final bool isChecked;
  final ValueChanged<bool?> onChanged;

  const _CheckItem({
    required this.title,
    required this.isChecked,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onChanged(!isChecked),
      borderRadius: BorderRadius.circular(8.r),
      child: Row(
        children: [
          Container(
            width: 24.w,
            height: 24.w,
            decoration: BoxDecoration(
              color: isChecked ? Pallets.blueBubbleColor : Colors.white,
              borderRadius: BorderRadius.circular(6.r),
              border: Border.all(
                color: isChecked ? Pallets.blueBubbleColor : const Color(0xFFCBD5E1),
                width: 1.5,
              ),
            ),
            child: isChecked
                ? Icon(
                    Icons.check,
                    color: Colors.white,
                    size: 16.w,
                  )
                : null,
          ),
          12.horizontalSpace,
          Expanded(
            child: TextView(
              text: title,
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: Pallets.boldBlack,
            ),
          ),
        ],
      ),
    );
  }
}
