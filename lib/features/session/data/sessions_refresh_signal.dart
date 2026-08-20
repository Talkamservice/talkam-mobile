import 'package:flutter/foundation.dart';

/// Bumped whenever something outside the Sessions tab means its list is
/// stale (e.g. a payment just confirmed a booking).
///
/// `SessionsScreen` lives inside a `StatefulShellRoute.indexedStack` branch
/// that's kept alive across tab switches, so returning to it after paying
/// does not rerun `initState`/refetch on its own — listening to this signal
/// is how it knows to refresh anyway. Same pattern as
/// `SessionManager.isTherapistAccountListenable`.
class SessionsRefreshSignal {
  SessionsRefreshSignal._();

  static final ValueNotifier<int> value = ValueNotifier<int>(0);

  static void ping() => value.value++;
}
