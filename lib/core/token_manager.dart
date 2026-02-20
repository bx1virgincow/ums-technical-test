import 'dart:convert';
import 'dart:developer';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:ums/core/pref_keys.dart';
import 'package:ums/feature/bottom_nav/domain/entity/user_entity.dart';

class TokenManager {
  static SharedPreferences? _prefs;

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // save access token
  static Future<void> saveAccessToken(String token) async {
    await _prefs?.setString(PrefKeys.accessToken, token);
    log(' saved access token: $token');
  }

  // save refresh token
  static Future<void> saveRefreshToken(String token) async {
    await _prefs?.setString(PrefKeys.refreshToken, token);
  }

  // get access token
  static Future<String?> getAccessToken() async {
    return _prefs?.getString(PrefKeys.accessToken);
  }

  // get refresh token
  static Future<String?> getRefreshToken() async {
    return _prefs?.getString(PrefKeys.refreshToken);
  }

  // clear tokens
  static Future<void> clearTokens() async {
    await _prefs?.remove(PrefKeys.accessToken);
    await _prefs?.remove(PrefKeys.refreshToken);
    await _prefs?.remove(PrefKeys.user);
  }

  // save user to shared preferences
  static Future<void> saveUser(UserEntity user) async {
    final userJson = user.toJson();
    await _prefs?.setString(PrefKeys.user, jsonEncode(userJson));
  }

  // get user from shared preferences
  static Future<UserEntity?> getUser() async {
    final userString = _prefs?.getString(PrefKeys.user);
    if (userString != null) {
      final userJson = jsonDecode(userString);
      return UserEntity.fromJson(userJson);
    }
    return null;
  }
}
