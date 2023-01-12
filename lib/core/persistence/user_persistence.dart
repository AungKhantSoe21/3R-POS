import 'package:shared_preferences/shared_preferences.dart';

class UserPersistence {

  saveUserPersistence(String userId) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('userId', userId);
  }

  getUserPreference() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final uId = prefs.getString('userId');
    return uId;
  }

  removeUserPreference() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('userId');
  }
}