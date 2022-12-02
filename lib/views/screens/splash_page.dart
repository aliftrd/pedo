import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pedo/constant/themes.dart';
import 'package:pedo/core/models/user_model.dart';
import 'package:pedo/core/providers/auth_provider.dart';
import 'package:pedo/core/providers/user_provider.dart';
import 'package:pedo/utils/secure_storage_service.dart';
import 'package:pedo/views/screens/login_page.dart';
import 'package:pedo/views/screens/page_switcher.dart';
import 'package:provider/provider.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    autoLogin();
  }

  Future<void> autoLogin() async {
    AuthProvider authProvider =
        Provider.of<AuthProvider>(context, listen: false);
    UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: false);

    if (!await SecureStorageService.hasToken()) {
      Timer(Duration(seconds: 3),
          () => Navigator.pushReplacementNamed(context, LoginPage.route));
      return;
    }

    var response = await authProvider.loginWithToken();
    if (response['code'] == 200) {
      var data = response['data'];
      UserModel user = UserModel.fromJson(data['user']);
      user.token = "Bearer ${data['token']}";
      userProvider.user = user;

      SecureStorageService.setToken(user.token.toString());
      Navigator.pushReplacementNamed(context, PageSwitcher.route);
    } else {
      SecureStorageService.removeToken();
      Navigator.pushReplacementNamed(context, LoginPage.route);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      body: SafeArea(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Spacer(flex: 2),
              Container(
                width: 99,
                height: 158,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/logo.png'),
                  ),
                ),
              ),
              const Spacer(),
              Container(
                width: 99,
                height: 158,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/essentials_light.png'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
