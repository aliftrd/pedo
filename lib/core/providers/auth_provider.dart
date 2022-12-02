import 'package:flutter/cupertino.dart';
import 'package:pedo/core/services/auth_service.dart';
import 'package:pedo/utils/secure_storage_service.dart';

class AuthProvider with ChangeNotifier {
  // Login
  Future login(String email, String password) async {
    try {
      var response = await AuthService.login(email, password);

      return response;
    } catch (err) {
      debugPrint(err.toString());
    }
  }

  // Login With Token
  Future loginWithToken() async {
    String token = await SecureStorageService.getToken();

    try {
      var response = await AuthService.loginWithToken(token);

      return response;
    } catch (err) {
      debugPrint(err.toString());
    }
  }

  Future register(String name, String email, String password) async {
    try {
      var response = await AuthService.register(name, email, password);

      return response;
    } catch (err) {
      debugPrint(err.toString());
    }
  }

  // Logout
  Future logout() async {
    try {
      var token = await SecureStorageService.getToken();
      SecureStorageService.removeToken();

      await AuthService.logout(token.toString());
    } catch (err) {
      debugPrint(err.toString());
    }
  }
}
