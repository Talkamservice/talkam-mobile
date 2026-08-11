import 'package:talkam/gen/assets.gen.dart';

/// Five-point mood scale for the daily check-in dialog. `index + 1` is the
/// 1-5 value the backend expects (POST /user/mood-checkins). Selecting one
/// always marks the check-in as done for today locally too, regardless of
/// whether the submit succeeds (see SessionManager.lastMoodCheckDate).
enum Mood {
  angry,
  sad,
  neutral,
  happy,
  veryHappy;

  String get iconPath => switch (this) {
        Mood.angry => Assets.images.svgV2.angry,
        Mood.sad => Assets.images.svgV2.tired1,
        Mood.neutral => Assets.images.svgV2.neutral,
        Mood.happy => Assets.images.svgV2.happy1,
        Mood.veryHappy => Assets.images.svgV2.happy,
      };
}
