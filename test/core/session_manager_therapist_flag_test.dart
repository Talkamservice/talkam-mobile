import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:talkam/core/services/data/session_manager.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    await SessionManager().init();
    // Singleton carries across tests; reset the flag explicitly.
    SessionManager.instance.isTherapistAccount = false;
  });

  group('SessionManager.isTherapistAccount', () {
    test('defaults to false', () {
      expect(SessionManager.instance.isTherapistAccount, isFalse);
    });

    test('persists through the getter', () {
      SessionManager.instance.isTherapistAccount = true;
      expect(SessionManager.instance.isTherapistAccount, isTrue);
    });

    test('listenable mirrors the current value', () {
      SessionManager.instance.isTherapistAccount = true;
      expect(SessionManager.instance.isTherapistAccountListenable.value, isTrue);

      SessionManager.instance.isTherapistAccount = false;
      expect(
        SessionManager.instance.isTherapistAccountListenable.value,
        isFalse,
      );
    });

    test('notifies listeners when the account type changes', () {
      final seen = <bool>[];
      final listenable = SessionManager.instance.isTherapistAccountListenable;
      void record() => seen.add(listenable.value);

      listenable.addListener(record);
      addTearDown(() => listenable.removeListener(record));

      // Regression guard: surfaces that switch on account type live inside a
      // StatefulShellRoute.indexedStack and are never rebuilt on their own, so
      // becoming a therapist mid-session must push a notification.
      SessionManager.instance.isTherapistAccount = true;

      expect(seen, [true]);
    });
  });
}
