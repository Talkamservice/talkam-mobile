import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:talkam/core/di/injector.dart';
import 'package:talkam/core/services/network/network_service.dart';
import 'package:talkam/features/profile/presentation/bloc/profile_bloc/profile_bloc.dart';

// final sessionProvider = Provider<SessionManager>((ref) {
//   SessionManager().init();
//   final sessionManager = SessionManager.instance;
//   return sessionManager;
// });

/// A class for managing sessions, handles saving and retrieving of data
///
// Sesion
class SessionManager {

  SessionManager._internal();
  SharedPreferences? sharedPreferences;
  FlutterSecureStorage? secureStorage;


  static final SessionManager _instance = SessionManager._internal();

  factory SessionManager() => _instance;

  static SessionManager get instance => _instance;




  Future<void> init() async {





    try {
      sharedPreferences = await SharedPreferences.getInstance();
      secureStorage = const FlutterSecureStorage();
    } catch (e) {
      logger.e(e.toString());
    }
  }

  static const String KEY_USERS_DATA = 'usersData';
  static const String KEY_AUTH_TOKEN = 'authToken';
  static const String KEY_USE_BIO = 'useBiometrics';
  static const String KEY_AUTH_PASS = 'password_koey';
  static const String KEY_BALANCE = 'balance';
  static const String HAS_ONBOARDED = 'has_onboarded';
  static const String KEY_IS_LOGIN = 'is_logged_in';
  static const String BIOMETRIC_ENABLED = 'biometric_enabled';
  static const String SOUND_ENABLED = 'sound_enabled';
  static const String NOTIFICATIONS_ENABLED = 'notifications_enabled';
  static const String IS_CONTACT_PERMITTED = 'permit_contact';
  static const String KEY_USER_EMAIL = 'logged_in_user_email';
  static const String KEY_ANONYMOUS_USERNAME = 'anonymous_username';
  static const String KEY_CONSENT_SETTINGS = 'consent_settings';
  static const String KEY_IS_THERAPIST_ACCOUNT = 'is_therapist_account';
  static const String KEY_THERAPIST_PROFILE = 'therapist_profile';
  static const String KEY_LAST_MOOD_CHECK_DATE = 'last_mood_check_date';


  Map<String, dynamic> get usersData =>
      json.decode(sharedPreferences!.getString(KEY_USERS_DATA) ?? '{}');

  set usersData(Map<String, dynamic> map) =>
      sharedPreferences!.setString(KEY_USERS_DATA, json.encode(map));

  bool get doesUserDataExists {
    return sharedPreferences!.containsKey(KEY_AUTH_TOKEN) &&
        authToken.isNotEmpty;
  }

  set arrivedHome(bool allowed) {
    sharedPreferences!.setBool(IS_CONTACT_PERMITTED, allowed);
  }

  bool isMe(String id) => usersData["id"].toString() == id;

  bool get arrivedHome =>
      sharedPreferences!.getBool(IS_CONTACT_PERMITTED) ?? false;

  bool get useBio => sharedPreferences!.getBool(KEY_USE_BIO) ?? false;

  String get authToken => sharedPreferences?.getString(KEY_AUTH_TOKEN) ?? '';

  String get userEmail => sharedPreferences!.getString(KEY_USER_EMAIL) ?? '';

  Future<String?>? get userPassKeyGet async =>
      await secureStorage?.read(key: KEY_AUTH_PASS);

  // Future<String> getUserPassKey() async =>
  //     await secureStorage?.read(key: KEY_AUTH_PASS) ?? '';

  set authToken(String authToken) =>
      sharedPreferences!.setString(KEY_AUTH_TOKEN, authToken);

  set useBio(bool useBio) => sharedPreferences!.setBool(KEY_USE_BIO, useBio);

  set userEmail(String userEmail) =>
      sharedPreferences!.setString(KEY_USER_EMAIL, userEmail);

  set userPassKeySet(String? userPassKey) =>
      secureStorage?.write(key: KEY_AUTH_PASS, value: userPassKey);

  String get balance => sharedPreferences!.getString(KEY_BALANCE) ?? '';

  set balance(String balance) =>
      sharedPreferences!.setString(KEY_BALANCE, balance);

  /// Alias chosen on the anonymous sign-in screen. Device-local only — it is
  /// never sent to the backend, since guests have no account.
  String get anonymousUsername =>
      sharedPreferences!.getString(KEY_ANONYMOUS_USERNAME) ?? '';

  set anonymousUsername(String username) =>
      sharedPreferences!.setString(KEY_ANONYMOUS_USERNAME, username);

  /// Data & Privacy consents, stored as the JSON encoding of ConsentSettings.
  /// Device-local until a consent endpoint exists.
  String get consentSettings =>
      sharedPreferences!.getString(KEY_CONSENT_SETTINGS) ?? '';

  set consentSettings(String encoded) =>
      sharedPreferences!.setString(KEY_CONSENT_SETTINGS, encoded);

  /// The signed-in therapist's self-edited profile, stored as the JSON
  /// encoding of TherapistEditableProfile. Device-local until a therapist
  /// endpoint exists — see TherapistProfileStore.
  String get therapistProfile =>
      sharedPreferences!.getString(KEY_THERAPIST_PROFILE) ?? '';

  set therapistProfile(String encoded) =>
      sharedPreferences!.setString(KEY_THERAPIST_PROFILE, encoded);

  /// True once a therapist application has been submitted. Device-local
  /// stand-in until the backend returns a real account-type field on the
  /// user object (TalkamUser.role exists but nothing currently populates it).
  bool get isTherapistAccount =>
      sharedPreferences?.getBool(KEY_IS_THERAPIST_ACCOUNT) ?? false;

  set isTherapistAccount(bool value) {
    sharedPreferences?.setBool(KEY_IS_THERAPIST_ACCOUNT, value);
    isTherapistAccountListenable.value = value;
  }

  /// Observable mirror of [isTherapistAccount].
  ///
  /// The app shell is a `StatefulShellRoute.indexedStack`, so a branch that has
  /// already been visited stays alive and will not rebuild on its own. Reading
  /// the flag once during build therefore strands a user on the member profile
  /// after they become a therapist mid-session. Surfaces that switch on account
  /// type listen to this instead. SharedPreferences remains the source of
  /// truth; this is initialised from it on first access.
  late final ValueNotifier<bool> isTherapistAccountListenable =
      ValueNotifier<bool>(isTherapistAccount);

  /// ISO date (yyyy-MM-dd) the mood check-in dialog was last shown/dismissed.
  /// Empty until the first time it's shown.
  String get lastMoodCheckDate =>
      sharedPreferences?.getString(KEY_LAST_MOOD_CHECK_DATE) ?? '';

  set lastMoodCheckDate(String isoDate) =>
      sharedPreferences?.setString(KEY_LAST_MOOD_CHECK_DATE, isoDate);

  set isLoggedIn(bool loggedIn) {
    sharedPreferences!.setBool(KEY_IS_LOGIN, loggedIn);
  }

  set hasOnboarded(bool loggedIn) {
    sharedPreferences!.setBool(HAS_ONBOARDED, loggedIn);
  }

  set bioMetricEnabled(bool loggedIn) {
    sharedPreferences!.setBool(BIOMETRIC_ENABLED, loggedIn);
  }

  bool get bioMetricEnabled =>
      sharedPreferences!.getBool(BIOMETRIC_ENABLED) ?? false;

  bool get isLoggedIn => sharedPreferences?.getBool(KEY_IS_LOGIN) ?? false;

  bool get hasOnboarded => sharedPreferences!.getBool(HAS_ONBOARDED) ?? false;

  set soundEnabled(bool soundEnabled) {
    sharedPreferences!.setBool(SOUND_ENABLED, soundEnabled);
  }

  bool get soundEnabled => sharedPreferences!.getBool(SOUND_ENABLED) ?? false;

  set notificationEnabled(bool enabled) {
    sharedPreferences!.setBool(SOUND_ENABLED, enabled);
  }

  bool get notificationEnabled =>
      sharedPreferences!.getBool(SOUND_ENABLED) ?? false;

  Future<bool> logOut() async {

    final holdUseBio = sharedPreferences?.getBool(KEY_USE_BIO);
    await sharedPreferences!.clear();
    // sharedPreferences?.setString(KEY_USER_EMAIL, holdEmail ?? '')
    sharedPreferences?.setBool(KEY_USE_BIO, holdUseBio ?? false);

    instance.isLoggedIn = false;
    instance.hasOnboarded = false;

    injector.get<ProfileBloc>().add(const Logout());

    // await secureStorage?.deleteAll();
    // await sharedPreferences?.clear();
    // await HiveBoxes.clearAllBox();
    // try {
    //   DefaultCacheManager().emptyCache();
    // } catch (e) {
    //   logger.e(e);
    // }
    return true;
  }
}
