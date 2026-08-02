import 'package:talkam/gen/assets.gen.dart';

/// Five-point mood scale for the daily check-in dialog. There's no backend
/// endpoint for this yet — selecting one just marks the check-in as done for
/// today (see SessionManager.lastMoodCheckDate).
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
