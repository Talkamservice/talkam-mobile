import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:talkam/common/widgets/custom_button.dart';
import 'package:talkam/common/widgets/image_widget.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/navigation/route_url.dart';
import 'package:talkam/core/theme/pallets.dart';
import 'package:talkam/features/session/data/models/session_model.dart';
import 'package:talkam/gen/assets.gen.dart';

import 'package:talkam/core/services/data/session_manager.dart';

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
  bool _isNotesOpen = false;

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
    final isTherapist = SessionManager.instance.isTherapistAccount;

    return Scaffold(
      backgroundColor: Pallets.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            children: [
              16.verticalSpace,

              // Top Bar for Therapist
              if (isTherapist) ...[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        context.pushNamed(PageUrl.clientNotesListScreen);
                      },
                      child: const TextView(
                        text: "Open notes",
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Pallets.blueBubbleColor,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        context.pushReplacementNamed(
                          PageUrl.sessionCompleteScreen,
                          extra: widget.session,
                        );
                      },
                      child: const TextView(
                        text: "End Session",
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFFEF4444),
                      ),
                    ),
                  ],
                ),
                16.verticalSpace,
              ],

              // Video Streams Area
              Expanded(
                child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    if (_isNotesOpen) {
                      setState(() {
                        _isNotesOpen = false;
                      });
                    }
                  },
                  child: _isNotesOpen
                      ? Stack(
                          key: const ValueKey("notes_open_stream"),
                          clipBehavior: Clip.none,
                          children: [
                            // Main Doctor Container (D)
                            Container(
                              width: double.infinity,
                              height: double.infinity,
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
                                  width: 64.w,
                                  height: 64.w,
                                  decoration: const BoxDecoration(
                                    color: Pallets.white,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Center(
                                    child: TextView(
                                      text: widget.session?.initial ?? "D",
                                      fontSize: 22,
                                      fontWeight: FontWeight.w700,
                                      color: Pallets.blueBubbleColor,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            // Small PIP User Container (N) overlayed at bottom right straddling corner
                            Positioned(
                              right: -4.w,
                              bottom: -28.h,
                              child: Container(
                                width: 105.w,
                                height: 115.h,
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
                                    width: 44.w,
                                    height: 44.w,
                                    decoration: const BoxDecoration(
                                      color: Pallets.white,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Center(
                                      child: TextView(
                                        text: "N",
                                        fontSize: 18,
                                        fontWeight: FontWeight.w700,
                                        color: Pallets.blueBubbleColor,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                      : Column(
                          key: const ValueKey("notes_closed_stream"),
                          children: [
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
                          ],
                        ),
                ),
              ),
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeOutCubic,
                height: _isNotesOpen ? 32.h : 16.h,
              ),

              // Call Control Bar
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
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
                        width: 44.w,
                        height: 44.w,
                        decoration: BoxDecoration(
                          color: _isMuted
                              ? const Color(0xFFCBD5E1)
                              : Pallets.white,
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: ImageWidget(
                            imageUrl: Assets.images.svgV2.mic,
                            size: 20.w,
                            color: _isMuted
                                ? Pallets.boldBlack
                                : const Color(0xFF334155),
                          ),
                        ),
                      ),
                    ),

                    // Notes Button (Therapist)
                    if (isTherapist)
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _isNotesOpen = !_isNotesOpen;
                          });
                        },
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          width: 44.w,
                          height: 44.w,
                          decoration: BoxDecoration(
                            color: _isNotesOpen
                                ? Pallets.blueBubbleColor
                                : Pallets.white,
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: ImageWidget(
                              imageUrl: Assets.images.svgV2.note,
                              size: 22.w,
                              color: _isNotesOpen
                                  ? Colors.white
                                  : const Color(0xFF334155),                            ),
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
                        width: 48.w,
                        height: 48.w,
                        decoration: const BoxDecoration(
                          color: Color(0xFFEF4444),
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: ImageWidget(
                            imageUrl: Assets.images.svgV2.call,
                            size: 22.w,
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
                        width: 44.w,
                        height: 44.w,
                        decoration: BoxDecoration(
                          color: _isSpeakerOn
                              ? Pallets.white
                              : const Color(0xFFCBD5E1),
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: ImageWidget(
                            imageUrl: Assets.images.svgV2.volumeHigh,
                            size: 20.w,
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
                        width: 44.w,
                        height: 44.w,
                        decoration: BoxDecoration(
                          color: _isVideoOn
                              ? Pallets.white
                              : const Color(0xFFCBD5E1),
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: ImageWidget(
                            imageUrl: Assets.images.svgV2.video2,
                            size: 20.w,
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

              // Inline Session Notes Panel with Smooth Vertical Slide Up
              AnimatedSize(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeOutCubic,
                alignment: Alignment.topCenter,
                child: _isNotesOpen
                    ? AnimatedSlide(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeOutCubic,
                        offset: _isNotesOpen ? Offset.zero : const Offset(0, 1),
                        child: Padding(
                          padding: EdgeInsets.only(top: 12.h),
                          child: Container(
                            padding: EdgeInsets.all(16.w),
                            decoration: BoxDecoration(
                              color: const Color(0xFFF8FAFC),
                              borderRadius:
                                  BorderRadius.vertical(top: Radius.circular(24.r)),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
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
                                12.verticalSpace,
                                const TextView(
                                  text: "Session Notes",
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                  color: Pallets.boldBlack,
                                ),
                                12.verticalSpace,

                                // Chips
                                Wrap(
                                  spacing: 8.w,
                                  runSpacing: 8.h,
                                  children: _chips.map((chip) {
                                    final isSelected =
                                        _selectedChips.contains(chip);
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
                                      child: AnimatedContainer(
                                        duration: const Duration(milliseconds: 150),
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 14.w, vertical: 6.h),
                                        decoration: BoxDecoration(
                                          color: isSelected
                                              ? Pallets.blueBubbleColor
                                              : const Color(0xFFF1F5F9),
                                          borderRadius:
                                              BorderRadius.circular(100.r),
                                        ),
                                        child: TextView(
                                          text: chip,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                          color: isSelected
                                              ? Colors.white
                                              : const Color(0xFF475569),
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                ),
                                12.verticalSpace,

                                // Notes Input Box
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 14.w, vertical: 10.h),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(16.r),
                                    border: Border.all(
                                        color: const Color(0xFF38BDF8),
                                        width: 1.5),
                                  ),
                                  child: TextField(
                                    controller: _noteController,
                                    maxLines: 3,
                                    decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "Enter session notes...",
                                      isDense: true,
                                    ),
                                    style: TextStyle(
                                      fontSize: 13.sp,
                                      color: Pallets.boldBlack,
                                    ),
                                  ),
                                ),
                                16.verticalSpace,

                                // Action Buttons
                                Row(
                                  children: [
                                    Expanded(
                                      child: CustomButton(
                                        onPressed: () {
                                          setState(() {
                                            _isNotesOpen = false;
                                          });
                                        },
                                        bgColor: Colors.white,
                                        child: const TextView(
                                          text: "Save draft",
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: Pallets.boldBlack,
                                        ),
                                      ),
                                    ),
                                    12.horizontalSpace,
                                    Expanded(
                                      child: CustomButton(
                                        onPressed: () {
                                          setState(() {
                                            _isNotesOpen = false;
                                          });
                                        },
                                        bgColor: Pallets.blueBubbleColor,
                                        child: const TextView(
                                          text: "Save & Close",
                                          fontSize: 14,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    : const SizedBox.shrink(),
              ),
              16.verticalSpace,
            ],
          ),
        ),
      ),
    );
  }
}
