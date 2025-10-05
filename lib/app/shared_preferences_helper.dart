import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class SharedPreferencesHelper {
  static const String authKey = 'isAuthenticated';
  static const String loginResponseKey = 'loginResponse';
  static const String emailKey = 'rememberedEmail';
  static const String passwordKey = 'rememberedPassword';
  static const String languageCodeKey = 'languageCode';

  static Future<bool> getIsAuthenticated() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(authKey) ?? false;
  }

  static Future<void> setIsAuthenticated(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(authKey, value);
  }

  static Future<void> setLoginResponse(Map<String, dynamic> response) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(loginResponseKey, response != null ? jsonEncode(response) : '');
  }

  static Future<Map<String, dynamic>?> getLoginResponse() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(loginResponseKey);
    if (jsonString != null && jsonString.isNotEmpty) {
      try {
        return jsonDecode(jsonString) as Map<String, dynamic>;
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  static Future<void> setRememberedCredentials(String email, String password) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(emailKey, email);
    await prefs.setString(passwordKey, password);
  }

  static Future<Map<String, String>?> getRememberedCredentials() async {
    final prefs = await SharedPreferences.getInstance();
    final email = prefs.getString(emailKey);
    final password = prefs.getString(passwordKey);
    if (email != null && password != null) {
      return {'email': email, 'password': password};
    }
    return null;
  }

  static Future<void> removeRememberedCredentials() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(emailKey);
    await prefs.remove(passwordKey);
  }

  static Future<void> setLanguageCode(String code) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(languageCodeKey, code);
  }

  static Future<String?> getLanguageCode() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(languageCodeKey);
  }
}
