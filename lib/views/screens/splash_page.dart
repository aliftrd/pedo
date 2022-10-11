import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pedo/constant/themes.dart';
import 'package:pedo/core/providers/auth_provider.dart';
import 'package:pedo/views/screens/home_page.dart';
import 'package:pedo/views/screens/login_page.dart';
import 'package:pedo/views/screens/page_switcher.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashPage extends StatefulWidget {
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
    AuthProvider authProvider = context.read<AuthProvider>();
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (!prefs.containsKey("authToken")) {
      Timer(Duration(seconds: 3),
          () => Navigator.pushReplacementNamed(context, LoginPage.route));
      return;
    }

    var token = prefs.getString("authToken");
    var response = await authProvider.loginWithToken(token: token.toString());

    if (response != true) {
      prefs.remove("authToken");
      Navigator.pushReplacementNamed(context, LoginPage.route);
      return;
    }

    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => PageSwitcher()),
    );
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
