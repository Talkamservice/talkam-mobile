import 'package:flutter/foundation.dart';
import 'package:talkam/core/di/injector.dart';
import 'package:talkam/core/services/data/session_manager.dart';
import 'package:talkam/features/therapist/data/models/therapist_editable_profile.dart';
import 'package:talkam/features/therapist/data/models/therapist_model.dart';

/// Device-local stand-in for the signed-in therapist's record.
///
/// Seeded from [MockTherapistData.currentTherapist], then overlaid with
/// whatever the therapist has saved on this device.
///
/// Exposed as a [ValueNotifier] for the same reason as
/// `SessionManager.isTherapistAccountListenable`: the profile tab lives inside
/// a `StatefulShellRoute.indexedStack`, and a branch that has already been
/// visited stays alive and will not rebuild on its own. Reading the record once
/// during build would mean a therapist saves their profile and sees nothing
/// change.
///
/// When a therapist endpoint lands, swap the SessionManager read/write for a
/// repository call and leave this surface untouched.
class TherapistProfileStore {
  TherapistProfileStore._();

  static final TherapistProfileStore instance = TherapistProfileStore._();

  /// The composed record the profile screens render.
  late final ValueNotifier<TherapistModel> profile =
      ValueNotifier<TherapistModel>(_compose());

  /// The editable draft, seeded from the base record when nothing is stored.
  TherapistEditableProfile get draft {
    final stored = _stored();
    return stored ??
        TherapistEditableProfile.fromTherapist(
            MockTherapistData.currentTherapist);
  }

  void save(TherapistEditableProfile edits) {
    SessionManager.instance.therapistProfile = edits.encode();
    profile.value = edits.applyTo(MockTherapistData.currentTherapist);
  }

  /// Drops any saved edits. Used by tests and available if a "reset" affordance
  /// is ever needed.
  void clear() {
    SessionManager.instance.therapistProfile = '';
    profile.value = MockTherapistData.currentTherapist;
  }

  /// Re-reads storage. Needed because [profile] is initialised lazily and the
  /// singleton outlives an individual sign-in.
  void reload() => profile.value = _compose();

  TherapistModel _compose() {
    final stored = _stored();
    return stored?.applyTo(MockTherapistData.currentTherapist) ??
        MockTherapistData.currentTherapist;
  }

  /// Returns null when nothing is stored or the stored blob is unreadable —
  /// a corrupt entry must not brick the profile.
  TherapistEditableProfile? _stored() {
    final raw = SessionManager.instance.therapistProfile;
    if (raw.isEmpty) return null;
    try {
      return TherapistEditableProfile.decode(raw);
    } catch (error, stack) {
      logger.e(error, stackTrace: stack);
      return null;
    }
  }
}
