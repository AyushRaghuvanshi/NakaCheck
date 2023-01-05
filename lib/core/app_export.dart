import 'package:shared_preferences/shared_preferences.dart';

class App {
  static bool authorized = false;

  static Future<void> loginCheck() async {
    final prefs = await SharedPreferences.getInstance();
    App.authorized = prefs.containsKey("access");
    
  }
}
