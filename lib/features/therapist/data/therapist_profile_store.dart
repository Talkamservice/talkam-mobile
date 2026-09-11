import 'package:flutter/foundation.dart';
import 'package:talkam/core/di/injector.dart';
import 'package:talkam/core/services/data/session_manager.dart';
import 'package:talkam/core/services/network/api_error.dart';
import 'package:talkam/features/booking/data/models/therapist_review_item.dart';
import 'package:talkam/features/booking/domain/repository/booking_repository.dart';
import 'package:talkam/features/therapist/data/models/therapist_editable_profile.dart';
import 'package:talkam/features/therapist/data/models/therapist_model.dart';
import 'package:talkam/features/therapist/dormain/repository/therapist_repository.dart';

/// Result of the most recent [TherapistProfileStore.fetchFromServer] call.
enum TherapistProfileLoadStatus {
  /// A fetch is in flight and nothing has loaded yet this session.
  loading,

  /// [TherapistProfileStore.profile] holds a real server record.
  loaded,

  /// The server rejected the request as unauthorized (401) or forbidden
  /// (403) — on this endpoint that means the signed-in account isn't a
  /// verified therapist yet, not that the user is signed out.
  unauthorized,

  /// Any other failure (network, 5xx, parse error).
  error,
}

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
  /// least once — [TherapistModel.empty] fills in until then (and on
  /// failure) so screens never render fabricated stats.
  TherapistModel? _serverProfile;

  /// The composed record the profile screens render.
  late final ValueNotifier<TherapistModel> profile =
      ValueNotifier<TherapistModel>(_compose());

  /// How the last [fetchFromServer] call went — screens branch on this to
  /// show a loading/unauthorized/error state instead of [profile], which
  /// stays a blank placeholder until a fetch actually succeeds.
  final ValueNotifier<TherapistProfileLoadStatus> loadStatus =
      ValueNotifier<TherapistProfileLoadStatus>(
          TherapistProfileLoadStatus.loading);

  /// The editable draft, seeded from the base record when nothing is stored.
  TherapistEditableProfile get draft {
    final stored = _stored();
    return stored ?? TherapistEditableProfile.fromTherapist(_base);
  }

  TherapistModel get _base => _serverProfile ?? TherapistModel.empty();

  /// Fetches the real profile and recomposes.
  Future<void> fetchFromServer() async {
    loadStatus.value = TherapistProfileLoadStatus.loading;
    try {
      final detail = await injector.get<TherapistRepository>().getMyProfile();
      
      TherapistReviewsResponse? reviews;
      try {
        reviews = await injector.get<BookingRepository>().getTherapistReviews(detail.id);
      } catch (e) {
        // Silently fail if reviews can't be fetched
      }
      
      _serverProfile = TherapistModel.fromProfileDetail(detail, reviews);
      reload();
      loadStatus.value = TherapistProfileLoadStatus.loaded;
    } catch (error, stack) {
      logger.e(error, stackTrace: stack);
      final statusCode = error is ApiError ? error.statusCode : null;
      loadStatus.value = (statusCode == 401 || statusCode == 403)
          ? TherapistProfileLoadStatus.unauthorized
          : TherapistProfileLoadStatus.error;
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
