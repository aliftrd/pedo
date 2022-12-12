import 'package:pedo/config/network.dart';

class Endpoint {
  static urlLogin({
    required Map<String, dynamic> body,
  }) async {
    return Network().post(
      url: 'login.php',
      body: body,
      useToken: false,
    );
  }

  static urlRegister(
    Map<String, dynamic> body,
  ) async {
    return Network().post(
      url: 'register.php',
      body: body,
      useToken: false,
    );
  }

  static urlLogout() async {
    return Network().post(
      url: 'logout.php',
    );
  }

  static urlProfile() async {
    return Network().get(
      url: 'profile.php',
    );
  }

  static urlUpdateProfile(Map<String, dynamic> body) async {
    return Network().post(
      url: 'profile.php',
      body: body,
    );
  }

  static urlArticle({
    String? page,
  }) async {
    return Network().get(
      url: 'articles.php',
      params: {
        'page': page.toString(),
      },
    );
  }
}
