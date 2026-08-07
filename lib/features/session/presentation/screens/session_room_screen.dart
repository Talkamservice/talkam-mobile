import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:talkam/common/widgets/custom_appbar.dart';
import 'package:talkam/common/widgets/custom_button.dart';
import 'package:talkam/common/widgets/image_widget.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/navigation/route_url.dart';
import 'package:talkam/core/theme/pallets.dart';
import 'package:talkam/features/session/data/models/session_model.dart';
import 'package:talkam/gen/assets.gen.dart';

class SessionRoomScreen extends StatefulWidget {
  final SessionModel? session;

  const SessionRoomScreen({super.key, this.session});

  @override
  State<SessionRoomScreen> createState() => _SessionRoomScreenState();
}

class _SessionRoomScreenState extends State<SessionRoomScreen> {
  late int _remainingSeconds;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _remainingSeconds = 5;
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingSeconds > 0) {
        setState(() {
          _remainingSeconds--;
        });
      } else {
        _timer?.cancel();
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  String _formatDuration(int totalSeconds) {
    final minutes = totalSeconds ~/ 60;
    final seconds = totalSeconds % 60;
    return "$minutes:${seconds.toString().padLeft(2, '0')}";
  }

  @override
  Widget build(BuildContext context) {
    final totalDuration = 5;
    final progress = totalDuration > 0
        ? (1.0 - (_remainingSeconds / totalDuration)).clamp(0.0, 1.0)
        : 1.0;
    final isReady = _remainingSeconds == 0;

    return Scaffold(
      backgroundColor: Pallets.white,
      appBar: CustomAppBar(
        titleAlign: TextAlign.start,
        centerTile: false,
        tittle: TextView(
          text: "Session Details",
          fontSize: 18,
          fontWeight: FontWeight.w700,
          color: Pallets.boldBlack,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          children: [
            40.verticalSpace,

            // Circular Countdown Ring
            GestureDetector(
              onTap: () {
                // Tap ring to quickly toggle ready state for testing
                setState(() {
                  _remainingSeconds = isReady ? 5 : 0;
                });
              },
              child: Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    width: 180.w,
                    height: 180.w,
                    child: CircularProgressIndicator(
                      value: isReady ? 1.0 : (0.2 + (progress * 0.8)),
                      strokeWidth: 12.w,
                      backgroundColor: const Color(0xFFF1F5F9),
                      valueColor: const AlwaysStoppedAnimation<Color>(
                        Pallets.blueBubbleColor,
                      ),
                      strokeCap: StrokeCap.round,
                    ),
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextView(
                        text: _formatDuration(_remainingSeconds),
                        fontSize: 34,
                        fontWeight: FontWeight.w700,
                        color: Pallets.boldBlack,
                      ),
                      4.verticalSpace,
                      TextView(
                        text: "until session",
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xFF64748B),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            40.verticalSpace,

            // Doctor Details Box Card
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(20.w),
              decoration: BoxDecoration(
                color: const Color(0xFFFAFAFA),
                borderRadius: BorderRadius.circular(20.r),
                border: Border.all(color: Pallets.grey95)

              ),
              child: Column(
                children: [
                  Container(
                    width: 70.w,
                    height: 70.w,
                    decoration: BoxDecoration(
                      color: const Color(0xFFEBF5FB),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: SvgPicture.asset(
                        Assets.images.svgV2.userInActive,
                        width: 28.w,
                        colorFilter: const ColorFilter.mode(
                          Pallets.blueBubbleColor,
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                  ),
                  12.verticalSpace,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextView(
                        text: widget.session?.therapistName ?? "Dr. Adewale K.",
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: Pallets.boldBlack,
                      ),
                      6.horizontalSpace,
                      SvgPicture.asset(
                        Assets.images.svgV2.checkmarkBadge,
                        width: 18.w,
                      ),
                    ],
                  ),
                  6.verticalSpace,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ImageWidget(imageUrl: Assets.images.svgV2.clock,
                        size: 18.w,
                        color: Pallets.blueBubbleColor,
                      ),
                      4.horizontalSpace,
                      TextView(
                        text: "50m",
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xFF64748B),
                      ),
                      8.horizontalSpace,
                      TextView(
                        text: "•",
                        fontSize: 12,
                        color: const Color(0xFFCBD5E1),
                      ),
                      8.horizontalSpace,
                      ImageWidget(imageUrl: Assets.images.svgV2.video,
                        size: 18.w,
                        color: Pallets.blueBubbleColor,
                      ),
                      4.horizontalSpace,
                      TextView(
                        text: "Video",
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xFF64748B),
                      ),
                    ],
                  ),
                  20.verticalSpace,

                  // Stats Row
                  IntrinsicHeight(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _StatBox(
                          value: "132",
                          label: "Sessions",
                        ),
                        const VerticalDivider(
                          thickness: 1,
                          color: Color(0xFFE2E8F0),
                        ),
                        _StatBox(
                          value: "4.9",
                          label: "Ratings",
                          icon: Assets.images.svgV2.starFilled,
                        ),
                        const VerticalDivider(
                          thickness: 1,
                          color: Color(0xFFE2E8F0),
                        ),
                        _StatBox(
                          value: "Good",
                          label: "Progress",
                          color: const Color(0xFF059669),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(),

            // Join Button
            CustomButton(
              onPressed: () {
                context.pushNamed(
                  PageUrl.sessionCallScreen,
                  extra: widget.session,
                );
              },
              bgColor: isReady
                  ? Pallets.blueBubbleColor
                  : Pallets.blueBubbleColor.withValues(alpha: 0.35),
              text: "Join Session Now",
            ),
            24.verticalSpace,
          ],
        ),
      ),
    );
  }
}

class _StatBox extends StatelessWidget {
  final String value;
  final String label;
  final String? icon;
  final Color? color;

  const _StatBox({
    required this.value,
    required this.label,
    this.icon,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[
              SvgPicture.asset(
                icon!,
                width: 14.w,
                colorFilter: const ColorFilter.mode(
                  Color(0xFFFFA800),
                  BlendMode.srcIn,
                ),
              ),
              4.horizontalSpace,
            ],
            TextView(
              text: value,
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: color ?? Pallets.boldBlack,
            ),
          ],
        ),
        2.verticalSpace,
        TextView(
          text: label,
          fontSize: 12,
          fontWeight: FontWeight.w400,
          color: const Color(0xFF94A3B8),
        ),
      ],
    );
  }
}
