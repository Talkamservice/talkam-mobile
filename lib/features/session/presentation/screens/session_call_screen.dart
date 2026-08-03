import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:talkam/common/widgets/image_widget.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/navigation/route_url.dart';
import 'package:talkam/core/theme/pallets.dart';
import 'package:talkam/features/session/data/models/session_model.dart';
import 'package:talkam/gen/assets.gen.dart';

class SessionCallScreen extends StatefulWidget {
  final SessionModel? session;

  const SessionCallScreen({super.key, this.session});

  @override
  State<SessionCallScreen> createState() => _SessionCallScreenState();
}

class _SessionCallScreenState extends State<SessionCallScreen> {
  bool _isMuted = false;
  bool _isSpeakerOn = true;
  bool _isVideoOn = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Pallets.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            children: [
              16.verticalSpace,

              // Top Container (Doctor Stream)
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF4FBFF),
                    borderRadius: BorderRadius.circular(24.r),
                    border: Border.all(
                      color: const Color(0xFF38BDF8),
                      width: 1.5,
                    ),
                  ),
                  child: Center(
                    child: Container(
                      width: 70.w,
                      height: 70.w,
                      decoration: const BoxDecoration(
                        color: Pallets.white,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: TextView(
                          text: widget.session?.initial ?? "D",
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                          color: Pallets.blueBubbleColor,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              16.verticalSpace,

              // Bottom Container (User Stream)
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF4FBFF),
                    borderRadius: BorderRadius.circular(24.r),
                    border: Border.all(
                      color: const Color(0xFF38BDF8),
                      width: 1.5,
                    ),
                  ),
                  child: Center(
                    child: Container(
                      width: 70.w,
                      height: 70.w,
                      decoration: const BoxDecoration(
                        color: Pallets.white,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: TextView(
                          text: "N",
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                          color: Pallets.blueBubbleColor,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              24.verticalSpace,

              // Call Control Bar
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
                decoration: BoxDecoration(
                  color: Pallets.lightBlue.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(36.r),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // Mic Button
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _isMuted = !_isMuted;
                        });
                      },
                      child: Container(
                        width: 48.w,
                        height: 48.w,
                        decoration: BoxDecoration(
                          color: _isMuted
                              ? const Color(0xFFCBD5E1)
                              : Pallets.white,
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: ImageWidget(
                            imageUrl: Assets.images.svgV2.mic,
                            size: 22.w,
                            color: _isMuted
                                ? Pallets.boldBlack
                                : const Color(0xFF334155),
                          ),
                        ),
                      ),
                    ),

                    // End Call Button
                    GestureDetector(
                      onTap: () {
                        context.pushReplacementNamed(
                          PageUrl.sessionCompleteScreen,
                          extra: widget.session,
                        );
                      },
                      child: Container(
                        width: 52.w,
                        height: 52.w,
                        decoration: const BoxDecoration(
                          color: Color(0xFFEF4444),
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: ImageWidget(
                            imageUrl: Assets.images.svgV2.call,
                            size: 24.w,
                            color: Pallets.white,
                          ),
                        ),
                      ),
                    ),

                    // Speaker Button
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _isSpeakerOn = !_isSpeakerOn;
                        });
                      },
                      child: Container(
                        width: 48.w,
                        height: 48.w,
                        decoration: BoxDecoration(
                          color: _isSpeakerOn
                              ? Pallets.white
                              : const Color(0xFFCBD5E1),
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: ImageWidget(
                            imageUrl: Assets.images.svgV2.volumeHigh,
                            size: 22.w,
                            color: _isSpeakerOn
                                ? const Color(0xFF334155)
                                : Pallets.boldBlack,
                          ),
                        ),
                      ),
                    ),

                    // Video Toggle Button
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _isVideoOn = !_isVideoOn;
                        });
                      },
                      child: Container(
                        width: 48.w,
                        height: 48.w,
                        decoration: BoxDecoration(
                          color: _isVideoOn
                              ? Pallets.white
                              : const Color(0xFFCBD5E1),
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: ImageWidget(
                            imageUrl: Assets.images.svgV2.video2,
                            size: 22.w,
                            color: _isVideoOn
                                ? const Color(0xFF334155)
                                : Pallets.boldBlack,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              20.verticalSpace,
            ],
          ),
        ),
      ),
    );
  }
}
