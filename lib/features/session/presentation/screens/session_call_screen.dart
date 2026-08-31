import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
import 'package:talkam/features/post/presentation/bloc/post/post_bloc.dart';
import 'package:talkam/features/session/data/models/session_model.dart';
import 'package:talkam/features/therapist/dormain/repository/therapist_repository.dart';
import 'package:talkam/features/therapist/presentation/bloc/therapist_client_cubit/therapist_client_cubit.dart';
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
  bool _retriedAfterRejection = false;

  /// Below this, treat it as background noise rather than speech. Volume is
  /// reported on a 0-255 scale.
  static const _speakingVolumeThreshold = 15;
  bool _localSpeaking = false;
  bool _remoteSpeaking = false;

  bool get _isVideoSession =>
      (widget.session?.format ?? 'Video').toLowerCase() == 'video';

  String get _currentUserName =>
      SessionManager.instance.usersData['name']?.toString() ?? 'You';

  /// First letter of the first word + first letter of the last word (e.g.
  /// "Dr Adaora Nwosu" -> "DN"), falling back to a single letter for a
  /// one-word name.
  String _initialsFor(String name) {
    final words =
        name.trim().split(RegExp(r'\s+')).where((w) => w.isNotEmpty).toList();
    if (words.isEmpty) return "?";
    if (words.length == 1) return words.first[0].toUpperCase();
    return (words.first[0] + words.last[0]).toUpperCase();
  }

  bool _isMuted = false;
  bool _isSpeakerOn = true;
  bool _isVideoOn = true;
  bool _isNotesOpen = false;

  final TextEditingController _noteController = TextEditingController();
  List<int> _selectedTagIds = [];
  bool _sharedWithClient = false;
  bool _noteLoadedIntoForm = false;

  // Notes are a therapist-only affordance — these stay null for a consumer.
  TherapistClientCubit? _notesCubit;
  PostBloc? _postBloc;

  @override
  void initState() {
    super.initState();
    _isVideoOn = _isVideoSession;
    _connect();

    if (SessionManager.instance.isTherapistAccount) {
      final sessionId = int.tryParse(widget.session?.id ?? '');
      _notesCubit = TherapistClientCubit(injector.get<TherapistRepository>());
      _postBloc = PostBloc(injector.get());
      if (sessionId != null) {
        _notesCubit!.getSessionNote(sessionId);
      }
      _postBloc!.add(const PostEvent.getInterestTopics());
    }
  }

  /// Existing note (if any) loads asynchronously after the panel is already
  /// built — populate the form the first time it arrives so re-opening the
  /// panel doesn't wipe out what was already saved earlier in the call.
  void _populateNoteForm(TherapistClientState state) {
    if (_noteLoadedIntoForm || state.note == null) return;
    _noteLoadedIntoForm = true;
    final note = state.note!;
    _noteController.text = note.content;
    _selectedTagIds = List<int>.from(note.tags);
    _sharedWithClient = note.sharedWithClient;
  }

  Future<void> _saveNote(String status) async {
    final sessionId = int.tryParse(widget.session?.id ?? '');
    final cubit = _notesCubit;
    if (sessionId == null || cubit == null) return;

    final success = await cubit.saveSessionNote(
      sessionId,
      // No title field in this compact in-call panel — the full note
      // editor (ClientNoteDetailScreen) is where a real title gets set;
      // this just needs a non-empty value since the backend requires one.
      title: cubit.state.note?.title.isNotEmpty == true
          ? cubit.state.note!.title
          : "Session with ${widget.session?.therapistName ?? 'client'}",
      content: _noteController.text.trim(),
      sharedWithClient: _sharedWithClient,
      status: status,
      tags: _selectedTagIds,
    );
    if (!mounted) return;
    if (success) {
      setState(() => _isNotesOpen = false);
      CustomDialogs.success("Note saved");
    } else {
      CustomDialogs.error(cubit.state.saveNoteError ?? "Couldn't save note");
    }
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
    } catch (e, stackTrace) {
      logger.e('Could not join call session', error: e, stackTrace: stackTrace);
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
          logger.i('Agora joined channel ${connection.channelId} at ${elapsed}ms');
          if (!mounted) return;
          setState(() => _status = _CallStatus.active);
        },
        onUserJoined: (connection, remoteUid, elapsed) {
          logger.i('Agora remote user joined: uid=$remoteUid at ${elapsed}ms');
          if (!mounted) return;
          setState(() => _remoteUid = remoteUid);
        },
        onUserOffline: (connection, remoteUid, reason) {
          logger.i('Agora remote user offline: uid=$remoteUid reason=$reason');
          if (!mounted) return;
          setState(() {
            _remoteUid = null;
            _remoteSpeaking = false;
          });
        },
        // Drives the speaking-glow effect around each participant's avatar.
        // Fires twice per interval — once reporting only the local user
        // (uid 0) and once reporting up to 3 loudest remote users — so each
        // call only updates whichever side it actually reports on.
        onAudioVolumeIndication:
            (connection, speakers, speakerNumber, totalVolume) {
          if (!mounted) return;
          var nextLocal = _localSpeaking;
          var nextRemote = _remoteSpeaking;
          for (final speaker in speakers) {
            final isSpeaking = (speaker.volume ?? 0) > _speakingVolumeThreshold;
            if (speaker.uid == 0) {
              nextLocal = isSpeaking;
            } else if (_remoteUid != null && speaker.uid == _remoteUid) {
              nextRemote = isSpeaking;
            }
          }
          if (nextLocal != _localSpeaking || nextRemote != _remoteSpeaking) {
            setState(() {
              _localSpeaking = nextLocal;
              _remoteSpeaking = nextRemote;
            });
          }
        },
        // Diagnostics for the blank-video issue (reproduces on both emulator
        // and real device, so it isn't the emulator GPU/SurfaceView theory).
        // These pinpoint exactly which stage stalls: capture never starts,
        // capture starts but never encodes/publishes, or the remote side
        // never receives a decodable frame.
        onLocalVideoStateChanged: (source, state, reason) {
          logger.i('Agora local video state: $source $state reason=$reason');
        },
        onRemoteVideoStateChanged: (connection, remoteUid, state, reason, elapsed) {
          logger.i(
            'Agora remote video state: uid=$remoteUid $state reason=$reason elapsed=${elapsed}ms',
          );
        },
        onFirstLocalVideoFramePublished: (connection, elapsed) {
          logger.i('Agora first local video frame published at ${elapsed}ms');
        },
        onFirstRemoteVideoFrame: (connection, remoteUid, width, height, elapsed) {
          logger.i(
            'Agora first remote video frame: uid=$remoteUid ${width}x$height at ${elapsed}ms',
          );
        },
        onError: (err, msg) {
          logger.e('Agora call error: $err $msg');
          // -17: the engine thinks this device is already in the channel —
          // almost always leftover native state from a previous attempt
          // that didn't clean up (e.g. a hot restart during dev bypasses
          // dispose()). onJoinChannelSuccess never fires in this case, so
          // without handling it the screen hangs on "Connecting..."
          // indefinitely with no audio/video ever established. Force a
          // clean leave+release and retry once before giving up.
          if (err == ErrorCodeType.errJoinChannelRejected) {
            _recoverFromRejectedJoin(engine);
          }
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
    // Full volume on both ends — rules out a silent call being caused by a
    // signal level left at zero rather than a routing/permission problem.
    await engine.adjustRecordingSignalVolume(100);
    await engine.adjustPlaybackSignalVolume(100);
    await engine.setDefaultAudioRouteToSpeakerphone(_isSpeakerOn);
    await engine.enableAudioVolumeIndication(
      interval: 300,
      smooth: 3,
      reportVad: true,
    );

    try {
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
    } on AgoraRtcException catch (e) {
      // joinChannel throws synchronously on a negative result instead of
      // (or in addition to racing) the onError event — error -17 means the
      // engine thinks this device is already in the channel, almost always
      // leftover native state from a previous attempt that didn't clean up.
      // The onError-driven recovery below never gets a chance to run here
      // since this exception unwinds straight past it, so handle it inline.
      if (e.code == -17) {
        await _recoverFromRejectedJoin(engine);
        return;
      }
      rethrow;
    }
    // Some Android OEM builds don't reliably honor the pre-join default
    // route — re-assert explicitly once actually in the channel. Best-effort
    // only: the channel join above already succeeded, so a routing hiccup
    // here (e.g. Agora -3/ERR_NOT_READY on devices where the audio session
    // isn't ready yet) must not fail the whole connect flow.
    try {
      await engine.setEnableSpeakerphone(_isSpeakerOn);
    } on AgoraRtcException catch (e) {
      debugPrint('setEnableSpeakerphone failed post-join (code ${e.code}), '
          'ignoring — call is already connected.');
    }

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

  /// Recovers from Agora error -17 (join rejected because the engine
  /// thinks this device is already in the channel) — near-always leftover
  /// native state from a previous attempt that didn't clean up (a hot
  /// restart during dev bypasses dispose()). Without this,
  /// onJoinChannelSuccess never fires and the screen hangs on "Connecting…"
  /// forever with no audio/video ever established. Force-releases the
  /// stale engine and retries once with a completely fresh one before
  /// surfacing an error.
  Future<void> _recoverFromRejectedJoin(RtcEngine staleEngine) async {
    try {
      await staleEngine.leaveChannel();
      await staleEngine.release();
    } catch (error, stack) {
      logger.e(error, stackTrace: stack);
    }
    if (!mounted) return;

    if (_retriedAfterRejection) {
      setState(() {
        _status = _CallStatus.error;
        _errorMessage =
            "Couldn't connect — this device appears to still be connected to a previous session. Fully close and reopen the app, then try again.";
      });
      return;
    }
    _retriedAfterRejection = true;
    await _connect();
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
    _notesCubit?.close();
    _postBloc?.close();
    _noteController.dispose();
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
              child: _isVideoSession
                  ? _buildVideoStreams()
                  : _buildAudioCallStage(),
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
                _CallControlButton(
                  iconAsset: Assets.images.svgV2.mic,
                  isOff: _isMuted,
                  onTap: _toggleMute,
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
                _CallControlButton(
                  iconAsset: Assets.images.svgV2.volumeHigh,
                  isOff: !_isSpeakerOn,
                  onTap: _toggleSpeaker,
                ),

                // Video Toggle Button (video sessions only)
                if (_isVideoSession)
                  _CallControlButton(
                    iconAsset: Assets.images.svgV2.video2,
                    isOff: !_isVideoOn,
                    onTap: _toggleVideo,
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

                            // Chips — the same real interest-topics
                            // vocabulary as the full note editor
                            // (ClientNoteDetailScreen), not a fixed list;
                            // tags are validated server-side against
                            // post_categories, so a fabricated label can't
                            // be sent as-is.
                            BlocBuilder<PostBloc, PostState>(
                              bloc: _postBloc,
                              builder: (context, postState) {
                                final categories = postState.maybeWhen(
                                  orElse: () => const [],
                                  getInterestTopicsSuccess: (response) =>
                                      response.data,
                                );
                                final isLoading = postState.maybeWhen(
                                  orElse: () => false,
                                  getInterestTopicsLoading: () => true,
                                );
                                if (isLoading) {
                                  return Center(
                                    child: CustomDialogs.getLoading(size: 24),
                                  );
                                }
                                return Wrap(
                                  spacing: 8.w,
                                  runSpacing: 8.h,
                                  children: categories.map((category) {
                                    final id =
                                        int.parse(category.id.toString());
                                    final isSelected =
                                        _selectedTagIds.contains(id);
                                    return GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          if (isSelected) {
                                            _selectedTagIds.remove(id);
                                          } else {
                                            _selectedTagIds.add(id);
                                          }
                                        });
                                      },
                                      child: AnimatedContainer(
                                        duration:
                                            const Duration(milliseconds: 150),
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
                                          text: category.name.toString(),
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                          color: isSelected
                                              ? Colors.white
                                              : const Color(0xFF475569),
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                );
                              },
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
                            BlocBuilder<TherapistClientCubit,
                                TherapistClientState>(
                              bloc: _notesCubit,
                              builder: (context, state) {
                                _populateNoteForm(state);
                                final saving = state.savingNote;
                                return Row(
                                  children: [
                                    Expanded(
                                      child: CustomButton(
                                        onPressed: saving
                                            ? null
                                            : () => _saveNote('draft'),
                                        bgColor: Colors.white,
                                        child: saving
                                            ? SizedBox(
                                                width: 16.w,
                                                height: 16.w,
                                                child:
                                                    const CircularProgressIndicator(
                                                  strokeWidth: 2,
                                                  color: Pallets.boldBlack,
                                                ),
                                              )
                                            : const TextView(
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
                                        onPressed: saving
                                            ? null
                                            : () => _saveNote('final'),
                                        bgColor: Pallets.blueBubbleColor,
                                        child: saving
                                            ? const SizedBox(
                                                width: 16,
                                                height: 16,
                                                child:
                                                    CircularProgressIndicator(
                                                  strokeWidth: 2,
                                                  color: Colors.white,
                                                ),
                                              )
                                            : const TextView(
                                                text: "Save & Close",
                                                fontSize: 14,
                                                fontWeight: FontWeight.w700,
                                                color: Colors.white,
                                              ),
                                      ),
                                    ),
                                  ],
                                );
                              },
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
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 150),
              decoration: BoxDecoration(
                color: const Color(0xFFF4FBFF),
                borderRadius: BorderRadius.circular(24.r),
                border: Border.all(
                  color: _remoteSpeaking
                      ? const Color(0xFF22C55E)
                      : const Color(0xFF38BDF8),
                  width: _remoteSpeaking ? 3 : 1.5,
                ),
              ),
              child: _remoteUid == null
                  ? _buildWaitingForParticipant()
                  : AgoraVideoView(
                      controller: VideoViewController.remote(
                        rtcEngine: engine,
                        canvas: VideoCanvas(uid: _remoteUid),
                        connection: RtcConnection(channelId: channelName),
                        // The default TextureView renderer shows blank on
                        // several Android emulators/GPU passthrough setups
                        // (matches the EGL_BAD_ATTRIBUTE noise from
                        // GFXSTREAM in the logs) — SurfaceView is the more
                        // broadly compatible renderer.
                        useAndroidSurfaceView: true,
                      ),
                    ),
            ),
          ),
        ),

        // PIP: local preview, straddling the bottom-right corner
        Positioned(
          right: -4.w,
          bottom: -28.h,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 150),
            width: 105.w,
            height: 115.h,
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              color: const Color(0xFFF4FBFF),
              borderRadius: BorderRadius.circular(24.r),
              border: Border.all(
                color: _localSpeaking
                    ? const Color(0xFF22C55E)
                    : const Color(0xFF38BDF8),
                width: _localSpeaking ? 3 : 1.5,
              ),
            ),
            child: _isVideoOn
                ? AgoraVideoView(
                    controller: VideoViewController(
                      rtcEngine: engine,
                      canvas: const VideoCanvas(uid: 0),
                      useAndroidSurfaceView: true,
                    ),
                  )
                : _buildInitialAvatar(
                    _currentUserName,
                    small: true,
                    isSpeaking: _localSpeaking,
                    isYou: true,
                    showName: true,
                  ),
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
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 150),
            width: double.infinity,
            decoration: BoxDecoration(
              color: const Color(0xFFF4FBFF),
              borderRadius: BorderRadius.circular(24.r),
              border: Border.all(
                color: _remoteSpeaking
                    ? const Color(0xFF22C55E)
                    : const Color(0xFF38BDF8),
                width: _remoteSpeaking ? 3 : 1.5,
              ),
            ),
            child: _remoteUid == null
                ? _buildWaitingForParticipant()
                : _buildInitialAvatar(
                    widget.session?.therapistName ?? "Participant",
                    isSpeaking: _remoteSpeaking,
                    showName: true,
                  ),
          ),
        ),
        16.verticalSpace,
        Expanded(
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 150),
            width: double.infinity,
            decoration: BoxDecoration(
              color: const Color(0xFFF4FBFF),
              borderRadius: BorderRadius.circular(24.r),
              border: Border.all(
                color: _localSpeaking
                    ? const Color(0xFF22C55E)
                    : const Color(0xFF38BDF8),
                width: _localSpeaking ? 3 : 1.5,
              ),
            ),
            child: _buildInitialAvatar(
              _currentUserName,
              isSpeaking: _localSpeaking,
              isYou: true,
              showName: true,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildInitialAvatar(
    String name, {
    bool small = false,
    bool isSpeaking = false,
    bool isYou = false,
    bool showName = false,
  }) {
    final size = small ? 44.w : 70.w;
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 150),
            width: size,
            height: size,
            decoration: BoxDecoration(
              color: Pallets.white,
              shape: BoxShape.circle,
              border: Border.all(
                color:
                    isSpeaking ? const Color(0xFF22C55E) : Colors.transparent,
                width: 3,
              ),
              boxShadow: isSpeaking
                  ? [
                      BoxShadow(
                        color: const Color(0xFF22C55E).withValues(alpha: 0.45),
                        blurRadius: 12,
                        spreadRadius: 2,
                      ),
                    ]
                  : null,
            ),
            child: Center(
              child: TextView(
                text: _initialsFor(name),
                fontSize: small ? 15 : 24,
                fontWeight: FontWeight.w700,
                color: Pallets.blueBubbleColor,
              ),
            ),
          ),
          if (showName) ...[
            4.verticalSpace,
            TextView(
              text: isYou ? "(You)" : name,
              fontSize: small ? 11 : 12,
              fontWeight: FontWeight.w500,
              color: const Color(0xFF64748B),
              maxLines: 1,
              textOverflow: TextOverflow.ellipsis,
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildWaitingForParticipant() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildInitialAvatar(widget.session?.therapistName ?? "Participant"),
          12.verticalSpace,
          TextView(
            text:
                "Waiting for ${widget.session?.therapistName ?? 'the other participant'} to join...",
            fontSize: 12,
            color: const Color(0xFF64748B),
            align: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

/// A call-control toggle (mic/speaker/camera). When [isOff], the icon gets
/// a red diagonal strike-through and a muted background — the standard
/// "this is disabled" affordance — instead of relying on a subtle color
/// swap alone.
class _CallControlButton extends StatelessWidget {
  final String iconAsset;
  final bool isOff;
  final VoidCallback onTap;

  const _CallControlButton({
    required this.iconAsset,
    required this.isOff,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 44.w,
        height: 44.w,
        decoration: BoxDecoration(
          color: isOff ? const Color(0xFFFFF1F2) : Pallets.white,
          shape: BoxShape.circle,
        ),
        child: Center(
          child: SizedBox(
            width: 22.w,
            height: 22.w,
            child: Stack(
              alignment: Alignment.center,
              children: [
                ImageWidget(
                  imageUrl: iconAsset,
                  size: 20.w,
                  color:
                      isOff ? const Color(0xFFEF4444) : const Color(0xFF334155),
                ),
                if (isOff)
                  CustomPaint(
                    size: Size(22.w, 22.w),
                    painter:
                        _StrikeThroughPainter(color: const Color(0xFFEF4444)),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _StrikeThroughPainter extends CustomPainter {
  final Color color;

  const _StrikeThroughPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 2.2
      ..strokeCap = StrokeCap.round;
    canvas.drawLine(
      Offset(size.width * 0.1, size.height * 0.1),
      Offset(size.width * 0.9, size.height * 0.9),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant _StrikeThroughPainter oldDelegate) =>
      oldDelegate.color != color;
}
