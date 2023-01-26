import 'package:shared_preferences/shared_preferences.dart';

class UserPersistence {

  saveUserPersistence(String username, String role) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList("userdata", [
      username, role
    ]);
  }

  getUserPreference() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final data = prefs.getStringList("userdata");
    return data;
  }

  removeUserPreference() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('userdata');
  }
}