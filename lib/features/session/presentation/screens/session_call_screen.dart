import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:talkam/common/widgets/custom_button.dart';
import 'package:talkam/common/widgets/custom_dialogs.dart';
import 'package:talkam/common/widgets/image_widget.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/di/injector.dart';
import 'package:talkam/core/navigation/route_url.dart';
import 'package:talkam/core/services/data/session_manager.dart';
import 'package:talkam/core/services/network/api_error.dart';
import 'package:talkam/core/services/network/url_config.dart';
import 'package:talkam/core/theme/pallets.dart';
import 'package:talkam/features/booking/data/models/session_join.dart';
import 'package:talkam/features/booking/domain/repository/booking_repository.dart';
import 'package:talkam/features/session/data/models/session_model.dart';
import 'package:talkam/gen/assets.gen.dart';

enum _CallStatus { connecting, error, active }

class SessionCallScreen extends StatefulWidget {
  final SessionModel? session;

  const SessionCallScreen({super.key, this.session});

  @override
  State<SessionCallScreen> createState() => _SessionCallScreenState();
}

class _SessionCallScreenState extends State<SessionCallScreen> {
  _CallStatus _status = _CallStatus.connecting;
  String? _errorMessage;

  RtcEngine? _engine;
  String? _channelName;
  int? _remoteUid;
  bool _leftChannel = false;

  bool get _isVideoSession =>
      (widget.session?.format ?? 'Video').toLowerCase() == 'video';

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
  void initState() {
    super.initState();
    _isVideoOn = _isVideoSession;
    _connect();
  }

  Future<void> _connect() async {
    final bookingId = int.tryParse(widget.session?.id ?? '');
    if (bookingId == null) {
      setState(() {
        _status = _CallStatus.error;
        _errorMessage = 'This session could not be found.';
      });
      return;
    }

    final results = await [
      Permission.microphone,
      if (_isVideoSession) Permission.camera,
    ].request();
    if (results.values.any((status) => !status.isGranted)) {
      if (!mounted) return;
      setState(() {
        _status = _CallStatus.error;
        _errorMessage =
            'Camera and microphone access are needed to join this session. Enable them in Settings and try again.';
      });
      return;
    }

    try {
      final joinDetails =
          await injector.get<BookingRepository>().joinSession(bookingId);
      await _initEngineAndJoin(joinDetails);
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _status = _CallStatus.error;
        _errorMessage = e is ApiError
            ? (e.errorDescription ?? 'Could not join this session.')
            : 'Could not join this session.';
      });
    }
  }

  Future<void> _initEngineAndJoin(SessionJoinDetails joinDetails) async {
    final uid = int.tryParse(
          SessionManager.instance.usersData['id']?.toString() ?? '',
        ) ??
        0;

    final engine = createAgoraRtcEngine();
    await engine.initialize(
      RtcEngineContext(
        appId: UrlConfig.agoraAppId,
        channelProfile: ChannelProfileType.channelProfileCommunication,
      ),
    );

    engine.registerEventHandler(
      RtcEngineEventHandler(
        onJoinChannelSuccess: (connection, elapsed) {
          if (!mounted) return;
          setState(() => _status = _CallStatus.active);
        },
        onUserJoined: (connection, remoteUid, elapsed) {
          if (!mounted) return;
          setState(() => _remoteUid = remoteUid);
        },
        onUserOffline: (connection, remoteUid, reason) {
          if (!mounted) return;
          setState(() => _remoteUid = null);
        },
        onError: (err, msg) {
          logger.e('Agora call error: $err $msg');
        },
      ),
    );

    if (_isVideoSession) {
      await engine.enableVideo();
      await engine.startPreview();
    } else {
      await engine.disableVideo();
    }
    await engine.enableAudio();
    await engine.setDefaultAudioRouteToSpeakerphone(_isSpeakerOn);

    await engine.joinChannel(
      token: joinDetails.token,
      channelId: joinDetails.channelRef,
      uid: uid,
      options: ChannelMediaOptions(
        channelProfile: ChannelProfileType.channelProfileCommunication,
        clientRoleType: ClientRoleType.clientRoleBroadcaster,
        publishCameraTrack: _isVideoSession,
        publishMicrophoneTrack: true,
        autoSubscribeAudio: true,
        autoSubscribeVideo: _isVideoSession,
      ),
    );

    if (!mounted) {
      await engine.leaveChannel();
      await engine.release();
      return;
    }
    setState(() {
      _engine = engine;
      _channelName = joinDetails.channelRef;
    });
  }

  Future<void> _leaveAndReleaseEngine() async {
    if (_leftChannel) return;
    _leftChannel = true;
    final engine = _engine;
    _engine = null;
    if (engine == null) return;
    await engine.leaveChannel();
    await engine.release();
  }

  Future<void> _endCall() async {
    await _leaveAndReleaseEngine();
    if (!mounted) return;
    context.pushReplacementNamed(
      PageUrl.sessionCompleteScreen,
      extra: widget.session,
    );
  }

  @override
  void dispose() {
    _leaveAndReleaseEngine();
    super.dispose();
  }

  Future<void> _toggleMute() async {
    final next = !_isMuted;
    await _engine?.muteLocalAudioStream(next);
    if (!mounted) return;
    setState(() => _isMuted = next);
  }

  Future<void> _toggleSpeaker() async {
    final next = !_isSpeakerOn;
    await _engine?.setEnableSpeakerphone(next);
    if (!mounted) return;
    setState(() => _isSpeakerOn = next);
  }

  Future<void> _toggleVideo() async {
    if (!_isVideoSession) return;
    final next = !_isVideoOn;
    await _engine?.muteLocalVideoStream(!next);
    if (!mounted) return;
    setState(() => _isVideoOn = next);
  }

  @override
  Widget build(BuildContext context) {
    final isTherapist = SessionManager.instance.isTherapistAccount;

    return Scaffold(
      backgroundColor: Pallets.white,
      body: SafeArea(
        child: switch (_status) {
          _CallStatus.connecting => _buildConnecting(),
          _CallStatus.error => _buildError(),
          _CallStatus.active => _buildActiveCall(isTherapist),
        },
      ),
    );
  }

  Widget _buildConnecting() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomDialogs.getLoading(size: 40),
          16.verticalSpace,
          const TextView(
            text: "Connecting to your session...",
            fontSize: 14,
            color: Pallets.grey400,
          ),
        ],
      ),
    );
  }

  Widget _buildError() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.videocam_off_rounded,
              size: 48.w,
              color: const Color(0xFF94A3B8),
            ),
            16.verticalSpace,
            TextView(
              text: _errorMessage ?? 'Could not join this session.',
              fontSize: 14,
              color: Pallets.grey400,
              align: TextAlign.center,
              lineHeight: 1.4,
            ),
            24.verticalSpace,
            CustomButton(
              onPressed: () => context.pop(),
              text: "Go back",
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActiveCall(bool isTherapist) {
    return Padding(
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
                  onTap: _endCall,
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

          // Video/Audio Streams Area
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
              child: _isVideoSession ? _buildVideoStreams() : _buildAudioCallStage(),
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
                  onTap: _toggleMute,
                  child: Container(
                    width: 44.w,
                    height: 44.w,
                    decoration: BoxDecoration(
                      color: _isMuted ? const Color(0xFFCBD5E1) : Pallets.white,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: ImageWidget(
                        imageUrl: Assets.images.svgV2.mic,
                        size: 20.w,
                        color:
                            _isMuted ? Pallets.boldBlack : const Color(0xFF334155),
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
                              : const Color(0xFF334155),
                        ),
                      ),
                    ),
                  ),

                // End Call Button
                GestureDetector(
                  onTap: _endCall,
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
                  onTap: _toggleSpeaker,
                  child: Container(
                    width: 44.w,
                    height: 44.w,
                    decoration: BoxDecoration(
                      color:
                          _isSpeakerOn ? Pallets.white : const Color(0xFFCBD5E1),
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

                // Video Toggle Button (video sessions only)
                if (_isVideoSession)
                  GestureDetector(
                    onTap: _toggleVideo,
                    child: Container(
                      width: 44.w,
                      height: 44.w,
                      decoration: BoxDecoration(
                        color:
                            _isVideoOn ? Pallets.white : const Color(0xFFCBD5E1),
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
                                  child: AnimatedContainer(
                                    duration: const Duration(milliseconds: 150),
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 14.w, vertical: 6.h),
                                    decoration: BoxDecoration(
                                      color: isSelected
                                          ? Pallets.blueBubbleColor
                                          : const Color(0xFFF1F5F9),
                                      borderRadius: BorderRadius.circular(100.r),
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
                                    color: const Color(0xFF38BDF8), width: 1.5),
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
    );
  }

  /// Local preview + remote participant's video, or a "waiting" placeholder
  /// in the remote slot until they join.
  Widget _buildVideoStreams() {
    final engine = _engine;
    final channelName = _channelName;
    if (engine == null || channelName == null) return const SizedBox.shrink();

    return Stack(
      clipBehavior: Clip.none,
      children: [
        // Main area: remote participant (or a waiting placeholder)
        Positioned.fill(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(24.r),
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xFFF4FBFF),
                borderRadius: BorderRadius.circular(24.r),
                border: Border.all(color: const Color(0xFF38BDF8), width: 1.5),
              ),
              child: _remoteUid == null
                  ? _buildWaitingForParticipant()
                  : AgoraVideoView(
                      controller: VideoViewController.remote(
                        rtcEngine: engine,
                        canvas: VideoCanvas(uid: _remoteUid),
                        connection: RtcConnection(channelId: channelName),
                      ),
                    ),
            ),
          ),
        ),

        // PIP: local preview, straddling the bottom-right corner
        Positioned(
          right: -4.w,
          bottom: -28.h,
          child: Container(
            width: 105.w,
            height: 115.h,
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              color: const Color(0xFFF4FBFF),
              borderRadius: BorderRadius.circular(24.r),
              border: Border.all(color: const Color(0xFF38BDF8), width: 1.5),
            ),
            child: _isVideoOn
                ? AgoraVideoView(
                    controller: VideoViewController(
                      rtcEngine: engine,
                      canvas: const VideoCanvas(uid: 0),
                    ),
                  )
                : _buildInitialAvatar("You", small: true),
          ),
        ),
      ],
    );
  }

  /// Audio-only sessions have no camera streams — mirrors the video layout's
  /// look with static avatar tiles instead of AgoraVideoView.
  Widget _buildAudioCallStage() {
    return Column(
      children: [
        Expanded(
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: const Color(0xFFF4FBFF),
              borderRadius: BorderRadius.circular(24.r),
              border: Border.all(color: const Color(0xFF38BDF8), width: 1.5),
            ),
            child: _remoteUid == null
                ? _buildWaitingForParticipant()
                : _buildInitialAvatar(widget.session?.initial ?? "D"),
          ),
        ),
        16.verticalSpace,
        Expanded(
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: const Color(0xFFF4FBFF),
              borderRadius: BorderRadius.circular(24.r),
              border: Border.all(color: const Color(0xFF38BDF8), width: 1.5),
            ),
            child: _buildInitialAvatar("You"),
          ),
        ),
      ],
    );
  }

  Widget _buildInitialAvatar(String label, {bool small = false}) {
    final size = small ? 44.w : 70.w;
    return Center(
      child: Container(
        width: size,
        height: size,
        decoration: const BoxDecoration(
          color: Pallets.white,
          shape: BoxShape.circle,
        ),
        child: Center(
          child: TextView(
            text: label.isNotEmpty ? label[0].toUpperCase() : "?",
            fontSize: small ? 18 : 24,
            fontWeight: FontWeight.w700,
            color: Pallets.blueBubbleColor,
          ),
        ),
      ),
    );
  }

  Widget _buildWaitingForParticipant() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildInitialAvatar(widget.session?.initial ?? "D"),
          12.verticalSpace,
          TextView(
            text: "Waiting for ${widget.session?.therapistName ?? 'the other participant'} to join...",
            fontSize: 12,
            color: const Color(0xFF64748B),
            align: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
