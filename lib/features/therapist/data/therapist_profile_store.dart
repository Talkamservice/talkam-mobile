import 'package:flutter/foundation.dart';
import 'package:talkam/core/di/injector.dart';
import 'package:talkam/core/services/data/session_manager.dart';
import 'package:talkam/features/therapist/data/models/therapist_editable_profile.dart';
import 'package:talkam/features/therapist/data/models/therapist_model.dart';
import 'package:talkam/features/therapist/dormain/repository/therapist_repository.dart';

/// The signed-in therapist's record — `GET /therapist/profile` overlaid with
/// whatever they've since saved on this device for fields the update
/// endpoint doesn't cover (title, specialties, availability, duration; see
/// [TherapistEditableProfile]).
///
/// Exposed as a [ValueNotifier] for the same reason as
/// `SessionManager.isTherapistAccountListenable`: the profile tab lives inside
/// a `StatefulShellRoute.indexedStack`, and a branch that has already been
/// visited stays alive and will not rebuild on its own. Reading the record once
/// during build would mean a therapist saves their profile and sees nothing
/// change.
class TherapistProfileStore {
  TherapistProfileStore._();

  static final TherapistProfileStore instance = TherapistProfileStore._();

  /// Base record from the server. Null until [fetchFromServer] succeeds at
  /// least once — [MockTherapistData.currentTherapist] fills in until then
  /// (and on failure) so the screens never render an empty shell.
  TherapistModel? _serverProfile;

  /// The composed record the profile screens render.
  late final ValueNotifier<TherapistModel> profile =
      ValueNotifier<TherapistModel>(_compose());

  /// The editable draft, seeded from the base record when nothing is stored.
  TherapistEditableProfile get draft {
    final stored = _stored();
    return stored ?? TherapistEditableProfile.fromTherapist(_base);
  }

  TherapistModel get _base =>
      _serverProfile ?? MockTherapistData.currentTherapist;

  /// Fetches the real profile and recomposes. Errors are swallowed — this is
  /// a background refresh, and the mock/last-known record already covers the
  /// screen while it's loading or if the network call fails.
  Future<void> fetchFromServer() async {
    try {
      final detail = await injector.get<TherapistRepository>().getMyProfile();
      _serverProfile = TherapistModel.fromProfileDetail(detail);
      reload();
    } catch (error, stack) {
      logger.e(error, stackTrace: stack);
    }
  }

  void save(TherapistEditableProfile edits) {
    SessionManager.instance.therapistProfile = edits.encode();
    profile.value = edits.applyTo(_base);
  }

  /// Drops any saved edits. Used by tests and available if a "reset" affordance
  /// is ever needed.
  void clear() {
    SessionManager.instance.therapistProfile = '';
    profile.value = _base;
  }

  /// Re-reads storage/the server base. Needed because [profile] is
  /// initialised lazily and the singleton outlives an individual sign-in.
  void reload() => profile.value = _compose();

  TherapistModel _compose() {
    final stored = _stored();
    return stored?.applyTo(_base) ?? _base;
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
