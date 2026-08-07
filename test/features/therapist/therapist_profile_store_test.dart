import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:talkam/core/services/data/session_manager.dart';
import 'package:talkam/features/therapist/data/models/availability_slot.dart';
import 'package:talkam/features/therapist/data/models/therapist_editable_profile.dart';
import 'package:talkam/features/therapist/data/models/therapist_model.dart';
import 'package:talkam/features/therapist/data/therapist_profile_store.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  final store = TherapistProfileStore.instance;

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    await SessionManager().init();
    store.clear();
  });

  group('TherapistProfileStore', () {
    test('seeds from the mock record when nothing is stored', () {
      expect(store.profile.value.name, MockTherapistData.currentTherapist.name);
      expect(store.draft.fullName, MockTherapistData.currentTherapist.name);
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
      final base = MockTherapistData.currentTherapist;
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

      expect(store.profile.value.name, MockTherapistData.currentTherapist.name);
      expect(store.draft.fullName, MockTherapistData.currentTherapist.name);
    });

    test('clear drops saved edits', () {
      store.save(store.draft.copyWith(fullName: 'Dr. Ada Okafor'));
      store.clear();

      expect(store.profile.value.name, MockTherapistData.currentTherapist.name);
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
