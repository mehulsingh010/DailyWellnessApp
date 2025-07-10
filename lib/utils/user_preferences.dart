import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {
  static Future<void> saveEmail(String email) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('email', email);
  }

  static Future<String?> getEmail() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('email');
  }har

  static Future<void> clearEmail() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('email');
  }
}
