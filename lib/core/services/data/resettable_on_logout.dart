/// Implemented by every GetIt-registered singleton bloc/cubit
/// (`lib/core/di/bloc_module.dart`). Its cached data is scoped to whoever
/// is currently signed in, so it must be cleared on logout — otherwise the
/// next person to sign in on this device can momentarily see the previous
/// account's cached posts, messages, notifications, etc. Re-emit the bloc's
/// own already-existing initial state; don't dispose/close the instance —
/// it stays registered and alive for the next session.
///
/// Any new singleton added to `bloc_module.dart` must implement this and be
/// added to `resettableSingletons()` (`lib/core/di/resettable_singletons.dart`).
abstract class ResettableOnLogout {
  void resetForLogout();
}
