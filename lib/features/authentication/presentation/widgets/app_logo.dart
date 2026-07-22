import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:talkam/gen/assets.gen.dart';

/// Animated TalkAM logo widget.
///
/// Layout mirrors the brand logo:
///   [icon]  [talkAM text      ]
///           [TECH SERVICES text]
///
/// Animation:
///   • Icon            – slides in from the LEFT  + fades in
///   • "talkAM"        – slides in from the RIGHT + fades in
///   • "TECH SERVICES" – slides in from the RIGHT + fades in, lagging talkAM
///
/// A single [AnimationController] drives all three to keep overhead minimal.
/// [SlideTransition] + [FadeTransition] are repaint-boundary-aware and do
/// NOT trigger full widget rebuilds on each frame.
///
/// NOTE: The parent is responsible for wrapping this widget (or its ancestor)
/// in a [ClipRect] so that slides are clipped at the screen edge rather than
/// at the widget boundary.  The splash screen does this at Scaffold-body level.
class AppLogoWidget extends StatefulWidget {
  /// Height of the icon SVG. Text SVGs are given a matching fixed width.
  final double iconHeight;

  const AppLogoWidget({
    super.key,
    this.iconHeight = 64,
  });

  @override
  AppLogoWidgetState createState() => AppLogoWidgetState();
}

/// Public state so callers can hold a [GlobalKey<AppLogoWidgetState>]
/// and trigger [forward] at the right moment.
class AppLogoWidgetState extends State<AppLogoWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;

  // ── icon (slides from LEFT) ──────────────────────────────────────────────
  late final Animation<Offset> _iconSlide;
  late final Animation<double> _iconFade;

  // ── "talkAM" text (slides from RIGHT) ────────────────────────────────────
  late final Animation<Offset> _talkamSlide;
  late final Animation<double> _talkamFade;

  // ── "TECH SERVICES" text (slides from RIGHT, lagged) ─────────────────────
  late final Animation<Offset> _techSlide;
  late final Animation<double> _techFade;

  @override
  void initState() {
    super.initState();

    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );

    // Use a large fractional offset so the element starts well off-screen.
    // ClipRect in splash_screen.dart clips at the screen boundary, not here.
    const double slideDistance = 8.0;

    // Icon: 0.0 → 0.70
    _iconSlide = Tween<Offset>(
      begin: const Offset(-slideDistance, 0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _ctrl,
      curve: const Interval(0.0, 0.70, curve: Curves.easeOutCubic),
    ));
    _iconFade = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _ctrl,
        curve: const Interval(0.0, 0.50, curve: Curves.easeIn),
      ),
    );

    // "talkAM": 0.10 → 0.75
    _talkamSlide = Tween<Offset>(
      begin: const Offset(slideDistance, 0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _ctrl,
      curve: const Interval(0.10, 0.75, curve: Curves.easeOutCubic),
    ));
    _talkamFade = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _ctrl,
        curve: const Interval(0.10, 0.60, curve: Curves.easeIn),
      ),
    );

    // "TECH SERVICES": 0.30 → 0.95  (lagging behind talkAM)
    _techSlide = Tween<Offset>(
      begin: const Offset(slideDistance, 0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _ctrl,
      curve: const Interval(0.30, 0.95, curve: Curves.easeOutCubic),
    ));
    _techFade = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _ctrl,
        curve: const Interval(0.30, 0.75, curve: Curves.easeIn),
      ),
    );
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  /// Starts the intro animation. Call once after the widget is visible.
  void forward() => _ctrl.forward();

  /// Whether the animation has finished.
  bool get isCompleted => _ctrl.isCompleted;

  /// Listen for animation status changes (e.g. to trigger navigation).
  void addStatusListener(AnimationStatusListener listener) =>
      _ctrl.addStatusListener(listener);

  @override
  Widget build(BuildContext context) {
    final double iconH = widget.iconHeight;

    // Both text SVGs share the same width so they align perfectly.
    // The SVGs scale with BoxFit.contain, so each keeps its own aspect ratio.
    final double textWidth = iconH * 1.7;

    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // ── Icon (slides from LEFT) ────────────────────────────────────────
        SlideTransition(
          position: _iconSlide,
          child: FadeTransition(
            opacity: _iconFade,
            child: SvgPicture.asset(
              Assets.images.svgs.appIcon,
              height: iconH,
            ),
          ),
        ),

        const SizedBox(width: 10),

        // ── Text column ────────────────────────────────────────────────────
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // "talkAM"
            SlideTransition(
              position: _talkamSlide,
              child: FadeTransition(
                opacity: _talkamFade,
                child: SvgPicture.asset(
                  Assets.images.svgs.appIconTalkamText,
                  width: textWidth,
                  fit: BoxFit.contain,
                ),
              ),
            ),

            const SizedBox(height: 3),

            // "TECH SERVICES"
            SlideTransition(
              position: _techSlide,
              child: FadeTransition(
                opacity: _techFade,
                child: SvgPicture.asset(
                  Assets.images.svgs.appIconTechServiceText,
                  width: textWidth, // same width as talkAM ↑
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
