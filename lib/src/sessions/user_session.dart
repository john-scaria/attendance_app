import 'package:shared_preferences/shared_preferences.dart';

class UserSession {
  static const String userIdKey = 'user_id';
  static const String userTypeKey = 'user_type';

  static Future<void> saveData({
    required String key,
    required String data,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, data);
  }

  static Future<String?> getData({
    required String key,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }

  static Future<bool> removeData({
    required String key,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.remove(key);
  }
}
