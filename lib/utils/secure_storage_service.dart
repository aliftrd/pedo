import 'package:shared_preferences/shared_preferences.dart';

String authKey = "authToken";

class SecureStorageService {
  static getPreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs;
  }

  static hasToken() async {
    SharedPreferences prefs = await SecureStorageService.getPreference();
    return prefs.containsKey(authKey);
  }

  static setToken(String token) async {
    SharedPreferences prefs = await SecureStorageService.getPreference();
    return prefs.setString(authKey, token);
  }

  static getToken() async {
    SharedPreferences prefs = await SecureStorageService.getPreference();
    var token = prefs.getString(authKey);

    return token.toString();
  }

  static removeToken() async {
    SharedPreferences prefs = await SecureStorageService.getPreference();
    return prefs.remove(authKey);
  }
}
