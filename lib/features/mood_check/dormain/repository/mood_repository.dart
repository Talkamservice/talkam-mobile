import 'package:talkam/features/mood_check/data/models/mood_checkin_response.dart';

abstract class MoodRepository {
  /// Records (or updates, if one already exists for today) the day's mood
  /// check-in. [mood] is 1-5, per the endpoint spec.
  Future<MoodCheckinResponse> recordMoodCheckin(int mood);
}
