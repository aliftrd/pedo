import 'dart:convert';
import 'package:pedo/constant/api_path.dart';
import 'package:http/http.dart';

class AuthService {
  static Future login(String email, String password) async {
    var uri = Uri.https(BASE_URL, '/api/login.php');
    var headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
    var body = jsonEncode({
      'email': email,
      'password': password,
    });

    Response response = await post(uri, headers: headers, body: body);

    switch (response.statusCode) {
      case 200:
        return jsonDecode(response.body);
      case 401:
        return jsonDecode(response.body);
      default:
        throw Exception('Server Error');
    }
  }

  static Future loginWithToken(String token) async {
    var uri = Uri.https(BASE_URL, '/api/profile.php');
    var headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': token
    };

    Response response = await get(
      uri,
      headers: headers,
    );

    switch (response.statusCode) {
      case 200:
        return jsonDecode(response.body);
      case 401:
        return jsonDecode(response.body);
      default:
        throw Exception('Server Error');
    }
  }

  static Future register(String name, String email, String password) async {
    var uri = Uri.https(BASE_URL, '/api/register.php');
    var headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
    var body = jsonEncode({
      'name': name,
      'email': email,
      'password': password,
    });

    Response response = await post(
      uri,
      headers: headers,
      body: body,
    );

    switch (response.statusCode) {
      case 201:
        return jsonDecode(response.body);
      case 409:
        return jsonDecode(response.body);
      default:
        throw Exception('Server Error');
    }
  }

  static Future logout(String token) async {
    var uri = Uri.https(BASE_URL, '/api/logout.php');
    var headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': token
    };

    Response response = await post(
      uri,
      headers: headers,
    );

    switch (response.statusCode) {
      case 200:
        return jsonDecode(response.body);
      case 401:
        return jsonDecode(response.body);
      default:
        throw Exception('Server Error');
    }
  }
}
