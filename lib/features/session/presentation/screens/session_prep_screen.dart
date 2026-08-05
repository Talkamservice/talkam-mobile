import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:talkam/common/widgets/custom_appbar.dart';
import 'package:talkam/common/widgets/custom_button.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/navigation/route_url.dart';
import 'package:talkam/core/theme/pallets.dart';
import 'package:talkam/features/session/data/models/session_model.dart';

class SessionPrepScreen extends StatefulWidget {
  final SessionModel? session;

  const SessionPrepScreen({super.key, this.session});

  @override
  State<SessionPrepScreen> createState() => _SessionPrepScreenState();
}

class _SessionPrepScreenState extends State<SessionPrepScreen> {
  bool _step1Checked = true;
  bool _step2Checked = true;
  bool _step3Checked = false;

  @override
  Widget build(BuildContext context) {
    final clientName = widget.session?.therapistName ?? "Emeka O.";

    return Scaffold(
      backgroundColor: Pallets.white,
      appBar: const CustomAppBar(
        centerTile: true,
      ),
      body: SafeArea(
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
                          value: 0.75,
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
                          const TextView(
                            text: "4:52",
                            fontSize: 36,
                            fontWeight: FontWeight.w700,
                            color: Pallets.boldBlack,
                          ),
                          4.verticalSpace,
                          const TextView(
                            text: "until session",
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Pallets.grey400,
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
                        const TextView(
                          text: "50m • Video",
                          fontSize: 12,
                          color: Pallets.grey400,
                        ),
                      ],
                    ),
                    20.verticalSpace,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _MetricColumn(title: "3", subtitle: "Sessions"),
                        Container(
                          width: 1.w,
                          height: 28.h,
                          color: const Color(0xFFE2E8F0),
                        ),
                        _MetricColumn(title: "4", subtitle: "Plan total"),
                        Container(
                          width: 1.w,
                          height: 28.h,
                          color: const Color(0xFFE2E8F0),
                        ),
                        _MetricColumn(
                          title: "Good",
                          subtitle: "Progress",
                          titleColor: const Color(0xFF059669),
                        ),
                      ],
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
              const Spacer(),

              // Start Session Now button
              CustomButton(
                onPressed: () {
                  context.pushNamed(
                    PageUrl.sessionCallScreen,
                    extra: widget.session ?? MockSessionData.therapistUpcomingSessions[0],
                  );
                },
                bgColor: Pallets.blueBubbleColor,
                text: "Start Session Now",
              ),
              20.verticalSpace,
            ],
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
