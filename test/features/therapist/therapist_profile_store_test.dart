import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:talkam/core/di/injector.dart';
import 'package:talkam/core/services/data/session_manager.dart';
import 'package:talkam/core/services/network/api_error.dart';
import 'package:talkam/features/booking/data/models/therapist_directory_response.dart';
import 'package:talkam/features/therapist/data/models/availability_slot.dart';
import 'package:talkam/features/therapist/data/models/session_note.dart';
import 'package:talkam/features/therapist/data/models/session_request_sheet.dart';
import 'package:talkam/features/therapist/data/models/therapist_client.dart';
import 'package:talkam/features/therapist/data/models/therapist_editable_profile.dart';
import 'package:talkam/features/therapist/data/models/therapist_model.dart';
import 'package:talkam/features/therapist/data/models/therapist_note_library_item.dart';
import 'package:talkam/features/therapist/data/models/therapist_session_item.dart';
import 'package:talkam/features/therapist/data/therapist_profile_store.dart';
import 'package:talkam/features/therapist/dormain/repository/therapist_repository.dart';

/// Only [getMyProfile] is exercised by [TherapistProfileStore.fetchFromServer]
/// — every other method is unused by these tests and left unimplemented.
class _FakeTherapistRepository implements TherapistRepository {
  _FakeTherapistRepository(this._result);

  /// Either a [TherapistProfileDetail] to return, or an [Object] (typically
  /// an [ApiError]) to throw.
  final Object _result;

  @override
  Future<TherapistProfileDetail> getMyProfile() async {
    final result = _result;
    if (result is TherapistProfileDetail) return result;
    throw result;
  }

  @override
  Future<void> updateMyProfile({
    required String name,
    required String bio,
    required int yearsExperience,
    required int sessionRate,
    String? avatarPath,
  }) =>
      throw UnimplementedError();

  @override
  Future<List<TherapistClientListItem>> getClients() =>
      throw UnimplementedError();

  @override
  Future<TherapistClientDetail> getClientDetails(int clientId) =>
      throw UnimplementedError();

  @override
  Future<TreatmentPlan> setTreatmentPlan(
    int clientId, {
    required int totalSessions,
    required String progressStatus,
    String? notes,
  }) =>
      throw UnimplementedError();

  @override
  Future<SessionNote> getSessionNote(int sessionId) =>
      throw UnimplementedError();

  @override
  Future<SessionNote> saveSessionNote(
    int sessionId, {
    required String title,
    required String content,
    required bool sharedWithClient,
    required String status,
    required List<int> tags,
  }) =>
      throw UnimplementedError();

  @override
  Future<TherapistSessionsResponse> getSessions() => throw UnimplementedError();

  @override
  Future<SessionRequestSheet> getSessionRequest(int sessionId) =>
      throw UnimplementedError();

  @override
  Future<SessionAcknowledgeResult> acknowledgeSession(int sessionId) =>
      throw UnimplementedError();

  @override
  Future<TherapistNoteLibraryPage> getNotesLibrary({
    int? clientId,
    String? query,
    int page = 1,
  }) =>
      throw UnimplementedError();

  @override
  Future<WeeklyAvailability> getMyAvailability() => throw UnimplementedError();

  @override
  Future<WeeklyAvailability> updateMyAvailability(
          WeeklyAvailability availability) =>
      throw UnimplementedError();
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  // flutter_secure_storage has no shared_preferences-style
  // setMockInitialValues helper — without this, SessionManager.init()'s
  // secureStorage.read() throws MissingPluginException in the test
  // environment (caught internally and just logged, but still noise on
  // every run). Mock its channel directly instead.
  const secureStorageChannel =
      MethodChannel('plugins.it_nomads.com/flutter_secure_storage');
  TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
      .setMockMethodCallHandler(secureStorageChannel, (call) async {
    switch (call.method) {
      case 'read':
        return null;
      case 'readAll':
        return <String, String>{};
      default:
        return null;
    }
  });

  final store = TherapistProfileStore.instance;

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    await SessionManager().init();
    store.clear();
  });

  group('TherapistProfileStore', () {
    test('seeds from an empty record when nothing is stored or loaded', () {
      expect(store.profile.value.name, TherapistModel.empty().name);
      expect(store.draft.fullName, TherapistModel.empty().name);
    });

    test('overlays saved edits onto the base record', () {
      store.save(store.draft.copyWith(
        fullName: 'Dr. Ada Okafor',
        title: 'Counselling Psychologist',
        sessionRate: '30000',
      ));

      expect(store.profile.value.name, 'Dr. Ada Okafor');
      expect(store.profile.value.title, 'Counselling Psychologist');
      expect(store.profile.value.pricePerSession, 30000);
    });

    test('leaves server-owned fields untouched', () {
      final base = TherapistModel.empty();
      store.save(store.draft.copyWith(fullName: 'Dr. Ada Okafor'));

      expect(store.profile.value.rating, base.rating);
      expect(store.profile.value.reviewsCount, base.reviewsCount);
      expect(store.profile.value.totalSessions, base.totalSessions);
      expect(store.profile.value.isVerified, base.isVerified);
    });

    test('notifies listeners on save', () {
      // The reason the store is a ValueNotifier at all: the profile tab lives
      // in a StatefulShellRoute.indexedStack and will not rebuild on its own,
      // so without this a therapist saves and sees nothing change.
      var notifications = 0;
      void listener() => notifications++;
      store.profile.addListener(listener);
      addTearDown(() => store.profile.removeListener(listener));

      store.save(store.draft.copyWith(fullName: 'Dr. Ada Okafor'));

      expect(notifications, 1);
    });

    test('persists across a reload', () {
      final availability = const WeeklyAvailability().upsert(
        const AvailabilitySlot(
          id: 'slot-1',
          day: Weekday.thursday,
          startMinutes: 9 * 60,
          endMinutes: 10 * 60 + 30,
        ),
      );
      store.save(store.draft.copyWith(
        fullName: 'Dr. Ada Okafor',
        availability: availability,
      ));

      store.reload();

      expect(store.profile.value.name, 'Dr. Ada Okafor');
      expect(store.draft.availability.slots.single.endMinutes, 10 * 60 + 30);
    });

    test('falls back to the base record when storage is corrupt', () {
      SessionManager.instance.therapistProfile = 'not json at all';
      store.reload();

      expect(store.profile.value.name, TherapistModel.empty().name);
      expect(store.draft.fullName, TherapistModel.empty().name);
    });

    test('clear drops saved edits', () {
      store.save(store.draft.copyWith(fullName: 'Dr. Ada Okafor'));
      store.clear();

      expect(store.profile.value.name, TherapistModel.empty().name);
    });

    group('fetchFromServer', () {
      tearDown(() {
        if (injector.isRegistered<TherapistRepository>()) {
          injector.unregister<TherapistRepository>();
        }
      });

      // Ordered before the success case below: `_serverProfile` is only ever
      // replaced by a *successful* fetch (deliberately — a transient failure
      // shouldn't wipe previously-known-good data), so asserting these leave
      // it untouched only works starting from the store's still-empty state.
      test('reports unauthorized on a 401, without touching the base record',
          () async {
        injector.registerFactory<TherapistRepository>(
          () => _FakeTherapistRepository(
              ApiError('Unauthorized', statusCode: 401)),
        );

        await store.fetchFromServer();

        expect(
            store.loadStatus.value, TherapistProfileLoadStatus.unauthorized);
        expect(store.profile.value.name, TherapistModel.empty().name);
      });

      test('reports unauthorized on a 403 too', () async {
        injector.registerFactory<TherapistRepository>(
          () => _FakeTherapistRepository(
              ApiError('Account not verified', statusCode: 403)),
        );

        await store.fetchFromServer();

        expect(
            store.loadStatus.value, TherapistProfileLoadStatus.unauthorized);
      });

      test('reports a generic error for anything else', () async {
        injector.registerFactory<TherapistRepository>(
          () => _FakeTherapistRepository(
              ApiError('Something went wrong', statusCode: 500)),
        );

        await store.fetchFromServer();

        expect(store.loadStatus.value, TherapistProfileLoadStatus.error);
      });

      test('loads the real profile and reports loaded', () async {
        injector.registerFactory<TherapistRepository>(
          () => _FakeTherapistRepository(TherapistProfileDetail(
            id: 3,
            name: 'Dr Adaora Nwosu',
            username: 'Njgdf9cjle',
            isVerified: true,
            rating: 4.5,
            reviewsCount: 12,
            specialties: const [],
            completedSessions: 40,
          )),
        );

        await store.fetchFromServer();

        expect(store.loadStatus.value, TherapistProfileLoadStatus.loaded);
        expect(store.profile.value.name, 'Dr Adaora Nwosu');
        expect(store.profile.value.totalSessions, 40);
      });
    });
  });

  group('TherapistEditableProfile', () {
    test('round-trips through encode/decode', () {
      final profile = TherapistEditableProfile(
        fullName: 'Dr. Ada Okafor',
        title: 'Counselling Psychologist',
        yearsExperience: 12,
        bio: 'Bio text',
        avatarUrl: 'https://example.test/a.png',
        specialties: const ['Anxiety', 'Stress'],
        sessionRate: '30000',
        availability: const WeeklyAvailability().upsert(
          const AvailabilitySlot(
            id: 's',
            day: Weekday.friday,
            startMinutes: 540,
            endMinutes: 600,
          ),
        ),
      );

      expect(TherapistEditableProfile.decode(profile.encode()), profile);
    });

    test('isValid requires every field the profile depends on', () {
      const empty = TherapistEditableProfile();
      expect(empty.isValid, isFalse);

      final complete = TherapistEditableProfile(
        fullName: 'Dr. Ada Okafor',
        title: 'Counselling Psychologist',
        yearsExperience: 12,
        bio: 'Bio text',
        specialties: const ['Anxiety'],
        sessionRate: '30000',
        availability: const WeeklyAvailability().upsert(
          const AvailabilitySlot(
            id: 's',
            day: Weekday.friday,
            startMinutes: 540,
            endMinutes: 600,
          ),
        ),
      );
      expect(complete.isValid, isTrue);

      // Each requirement individually blocks saving.
      expect(complete.copyWith(fullName: ' ').isValid, isFalse);
      expect(complete.copyWith(title: ' ').isValid, isFalse);
      expect(complete.copyWith(bio: ' ').isValid, isFalse);
      expect(complete.copyWith(specialties: const []).isValid, isFalse);
      expect(complete.copyWith(sessionRate: '10').isValid, isFalse);
      expect(
        complete.copyWith(availability: const WeeklyAvailability()).isValid,
        isFalse,
      );
    });

    test('rejects a bio over the limit', () {
      final long = 'x' * (kBioMaxLength + 1);
      expect(const TherapistEditableProfile().copyWith(bio: long).isBioValid,
          isFalse);
      expect(
        const TherapistEditableProfile()
            .copyWith(bio: 'x' * kBioMaxLength)
            .isBioValid,
        isTrue,
      );
    });
  });
}
