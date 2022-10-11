import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pedo/constant/themes.dart';
import 'package:pedo/core/providers/auth_provider.dart';
import 'package:pedo/views/screens/login_page.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MorePage extends StatelessWidget {
  static String route = '/more';

  @override
  Widget build(BuildContext context) {
    void signOutHandle() {}
    // TODO: implement build
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: 200,
          child: Consumer<AuthProvider>(
            builder: (context, auth, _) => TextButton.icon(
              icon: Icon(Icons.logout, color: colorPrimary),
              label: Text(
                "Keluar",
                style: primaryTextStyle.copyWith(color: colorPrimary),
              ),
              onPressed: () async {
                auth.logout(token: auth.user.token.toString());
                SharedPreferences prefs = await SharedPreferences.getInstance();
                prefs.remove("authToken");
                Navigator.pushReplacementNamed(context, LoginPage.route);
              },
            ),
          ),
        ),
      ),
    );
  }
}
