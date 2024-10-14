import 'dart:convert';
import 'package:talkam/core/di/injector.dart';
import 'package:talkam/core/services/data/session_manager.dart';
import 'package:talkam/features/authentication/data/models/auth_response.dart';
// import 'package:talkam/features/authentication/signup/data/models/signup_response.dart';

class UserStorage {
  // static const _kUserTokenKey = StorageKeys.token;

  UserStorage();

  // Save user data to SharedPreferences
  Future<void> saveUser(TalkamUser user) async {
    final userJson = jsonEncode(user.toJson());
    SessionManager.instance.usersData = user.toJson();
  }

  // Retrieve user data from SharedPreferences
  Future<TalkamUser?> getUser() async {
    final userJson = SessionManager.instance.usersData;
    return userJson.isNotEmpty ? TalkamUser.fromJson(userJson) : null;
    // return null;
    // return null;

    /// Return null if user data doesn't exist
  }

  // Clear user data from SharedPreferences
  Future<void> clearUser() async {

    SessionManager.instance.usersData = {};
  }

  Future<void> saveUserToken(String token) async {
    SessionManager.instance.authToken = token;
  }

  Future<void> savePasKey(String? key) async {
    SessionManager.instance.userPassKeySet = key;
  }
}
