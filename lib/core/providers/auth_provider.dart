import 'package:flutter/cupertino.dart';
import 'package:pedo/config/endpoint.dart';
import 'package:pedo/core/models/user_model.dart';
import 'package:pedo/utils/secure_storage_service.dart';

class AuthProvider with ChangeNotifier {
  bool isLoading = false;
  UserModel? setUser;
  UserModel? get getUser => setUser;

  // Login
  Future login(String email, String password) async {
    isLoading = true;
    notifyListeners();

    try {
      var response = await Endpoint.urlLogin(
        body: {
          'email': email,
          'password': password,
        },
      );

      if (response['code'] == 200) {
        await SecureStorageService.setToken(response['data']['token']);
        setUser = UserModel.fromJson(response['data']['user'])
          ..token = response['data']['token'];
        isLoading = false;

        notifyListeners();
        return response;
      } else {
        return response;
      }
    } catch (err) {
      debugPrint(err.toString());
    }
  }

  // Login With Token
  Future loginWithToken() async {
    try {
      String token = await SecureStorageService.getToken();
      var response = await Endpoint.urlProfile();

      if (response['code'] == 200) {
        setUser = UserModel.fromJson(response['data']['user'])..token = token;
        isLoading = false;

        notifyListeners();
        return response;
      } else {
        SecureStorageService.removeToken();
        return response;
      }
    } catch (err) {
      debugPrint(err.toString());
    }
  }

// Register
  Future register(String name, String email, String password) async {
    try {
      Map<String, dynamic> body = {
        'name': name,
        'email': email,
        'password': password,
      };
      var response = await Endpoint.urlRegister(body);

      return response;
    } catch (err) {
      debugPrint(err.toString());
    }
  }

  // Logout
  Future logout() async {
    try {
      var response = await Endpoint.urlLogout();
      if (response['code'] == 200) {
        SecureStorageService.removeToken();
        setUser = null;
        isLoading = false;

        notifyListeners();
        return response;
      } else {
        return response;
      }
    } catch (err) {
      debugPrint(err.toString());
    }
  }
}
