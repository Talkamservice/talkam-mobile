import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talkam/core/di/injector.dart';
import 'package:talkam/features/mood_check/data/models/mood.dart';
import 'package:talkam/features/mood_check/dormain/repository/mood_repository.dart';

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

/// A mood face has been tapped (tooltip shown) but not submitted yet — the
/// dialog stays open and shows a Submit button for this selection.
class MoodCheckMoodSelected extends MoodCheckState {
  const MoodCheckMoodSelected(this.mood);

  final Mood mood;

  @override
  List<Object?> get props => [mood];
}

/// Decides whether the "How are you feeling today" dialog should show, based
/// on `GET /user/mood-checkins/today`'s `checked_in` flag — the server is
/// the source of truth, not a local cache. (This used to compare against
/// SessionManager.lastMoodCheckDate, a locally-stored ISO date; that's no
/// longer read or written here, so closing without submitting no longer
/// suppresses the popup for the rest of the day.)
class MoodCheckCubit extends Cubit<MoodCheckState> {
  final MoodRepository _moodRepository;

  MoodCheckCubit(this._moodRepository) : super(const MoodCheckIdle());

  Future<void> checkShouldShow() async {
    try {
      final today = await _moodRepository.getTodayMoodCheckin();
      emit(today.checkedIn
          ? const MoodCheckIdle()
          : const MoodCheckShouldShow());
    } catch (error) {
      // Best-effort, same as the rest of this cubit — a failed check
      // shouldn't block app open, it just means the popup doesn't show
      // this launch.
      logger.e(error);
      emit(const MoodCheckIdle());
    }
  }

  /// Tapping a mood face — marks it selected so the dialog can show its
  /// tooltip/highlight and reveal the Submit button. Doesn't submit or close
  /// anything; tapping a different face just re-emits with the new mood.
  void selectMood(Mood mood) => emit(MoodCheckMoodSelected(mood));

  /// Submits the selected mood server-side, best-effort — closing the
  /// dialog isn't blocked on it.
  Future<void> submitMood(Mood mood) async {
    try {
      await _moodRepository.recordMoodCheckin(mood.index + 1);
    } catch (error) {
      logger.e(error);
    }
    emit(MoodCheckDismissed(mood));
  }

  /// Closed via the X button without picking (or without submitting) a
  /// mood — nothing is recorded locally or server-side, so the popup will
  /// show again next time [checkShouldShow] is called.
  void dismiss() => emit(const MoodCheckDismissed(null));
}
