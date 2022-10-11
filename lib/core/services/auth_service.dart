import 'dart:convert';

import 'package:pedo/constant/app_url.dart';
import 'package:http/http.dart' as http;

class AuthService {
  static Future login({
    required String email,
    required String password,
  }) async {
    var uri = Uri.parse(AppUrl.login);
    var headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
    var body = jsonEncode({
      'email': email,
      'password': password,
    });

    try {
      var response = await http.post(
        uri,
        headers: headers,
        body: body,
      );

      return response;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  static Future loginWithToken({
    required String token,
  }) async {
    var uri = Uri.parse(AppUrl.tokenVerify);
    var headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': token
    };

    try {
      var response = await http.post(
        uri,
        headers: headers,
      );

      return response;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  static Future register({
    required String name,
    required String email,
    required String password,
  }) async {
    var uri = Uri.parse(AppUrl.register);
    var headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
    var body = jsonEncode({
      'name': name,
      'email': email,
      'password': password,
    });

    try {
      var response = await http.post(
        uri,
        headers: headers,
        body: body,
      );

      return response;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  static Future logout({
    required String token,
  }) async {
    var uri = Uri.parse(AppUrl.logout);
    var headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': token
    };

    try {
      var response = await http.post(
        uri,
        headers: headers,
      );

      return response;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
