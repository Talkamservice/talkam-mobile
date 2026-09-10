import 'package:talkam/gen/assets.gen.dart';

/// Five-point mood scale for the daily check-in dialog. `index + 1` is the
/// 1-5 value the backend expects (POST /user/mood-checkins), matching the
/// `value`/`key`/`label` options `GET /user/mood-checkins/today` returns
/// (`very_sad`/`sad`/`neutral`/`happy`/`very_happy`) — kept as a static enum
/// here rather than driven by that list, since the scale itself doesn't
/// change, just its icon/label needs to match. [veryUnhappy] was previously
/// named `angry`, which never matched what the backend actually calls it.
enum Mood {
  veryUnhappy,
  sad,
  neutral,
  happy,
  veryHappy;

  String get iconPath => switch (this) {
        Mood.veryUnhappy => Assets.images.svgV2.angry,
        Mood.sad => Assets.images.svgV2.tired1,
        Mood.neutral => Assets.images.svgV2.neutral,
        Mood.happy => Assets.images.svgV2.happy1,
        Mood.veryHappy => Assets.images.svgV2.happy,
      };

  /// Shown in the tap-to-preview tooltip — matches the backend's current
  /// `moods[].label` copy.
  String get label => switch (this) {
        Mood.veryUnhappy => "Very sad",
        Mood.sad => "Sad",
        Mood.neutral => "Neutral",
        Mood.happy => "Happy",
        Mood.veryHappy => "Very happy",
      };
}
