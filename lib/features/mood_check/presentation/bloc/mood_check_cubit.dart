import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talkam/core/services/data/session_manager.dart';
import 'package:talkam/features/mood_check/data/models/mood.dart';

abstract class MoodCheckState extends Equatable {
  const MoodCheckState();

  @override
  List<Object?> get props => [];
}

class MoodCheckIdle extends MoodCheckState {
  const MoodCheckIdle();
}

class MoodCheckShouldShow extends MoodCheckState {
  const MoodCheckShouldShow();
}

class MoodCheckDismissed extends MoodCheckState {
  const MoodCheckDismissed(this.mood);

  /// Null when dismissed via the close button rather than picking a mood.
  final Mood? mood;

  @override
  List<Object?> get props => [mood];
}

/// Decides whether the "How are you feeling today" dialog should show, and
/// records that it's been handled for the day once it has. There's no
/// existing daily-reset pattern anywhere else in the app — this establishes
/// one via SessionManager.lastMoodCheckDate (a plain ISO date string,
/// compared against today's date).
class MoodCheckCubit extends Cubit<MoodCheckState> {
  MoodCheckCubit() : super(const MoodCheckIdle());

  static String _todayIso() {
    final now = DateTime.now();
    return "${now.year.toString().padLeft(4, '0')}-"
        "${now.month.toString().padLeft(2, '0')}-"
        "${now.day.toString().padLeft(2, '0')}";
  }

  void checkShouldShow() {
    final shown = SessionManager.instance.lastMoodCheckDate == _todayIso();
    emit(shown ? const MoodCheckIdle() : const MoodCheckShouldShow());
  }

  void dismiss([Mood? mood]) {
    SessionManager.instance.lastMoodCheckDate = _todayIso();
    emit(MoodCheckDismissed(mood));
  }
}
