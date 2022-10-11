import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:pedo/core/models/user_model.dart';
import 'package:pedo/core/services/auth_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider with ChangeNotifier {
  late UserModel _user;

  UserModel get user => _user;

  void setUser(UserModel user) {
    _user = user;
    notifyListeners();
  }

  // Login
  Future login({
    required String email,
    required String password,
  }) async {
    Response response = await AuthService.login(
      email: email,
      password: password,
    );
    var body = jsonDecode(response.body);

    if (response.statusCode != 200) {
      var errors = body['message'];

      if (body['errors'] != null) {
        var errorsList = body['errors'];
        errors = errorsList[errorsList.keys.toList().first];
      }

      return errors;
    }

    var data = body['data'];
    UserModel user = UserModel.fromJson(data['user']);
    user.token = "Bearer ${data['token']}";

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("authToken", user.token.toString());

    setUser(user);
    return true;
  }

  // Login With Token
  Future loginWithToken({
    required String token,
  }) async {
    Response response = await AuthService.loginWithToken(token: token);
    var body = jsonDecode(response.body);
    if (response.statusCode != 200) {
      var errors = body['message'];

      if (body['errors'] != null) {
        var errorsList = body['errors'];
        errors = errorsList[errorsList.keys.toList().first];
      }

      return errors;
    }

    var data = body['data'];
    UserModel user = UserModel.fromJson(data['user']);
    user.token = "Bearer ${data['token']}";

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("authToken", user.token.toString());

    setUser(user);
    return true;
  }

  // Logout
  Future logout({
    required String token,
  }) async {
    await AuthService.logout(token: token);

    UserModel user = UserModel(null, null, null, null, null, null, null);
    setUser(user);
    notifyListeners();
  }
}
