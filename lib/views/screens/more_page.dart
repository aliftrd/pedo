import 'package:flutter/material.dart';
import 'package:pedo/constant/themes.dart';
import 'package:pedo/core/providers/auth_provider.dart';
import 'package:pedo/core/providers/user_provider.dart';
import 'package:pedo/views/screens/login_page.dart';
import 'package:provider/provider.dart';

class MorePage extends StatelessWidget {
  static String route = '/more';

  const MorePage({super.key});

  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    UserProvider userProvider = Provider.of<UserProvider>(context);

    void signOutHandle() {}
    // TODO: implement build
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: 200,
          child: TextButton.icon(
            icon: Icon(Icons.logout, color: colorPrimary),
            label: Text(
              "Keluar",
              style: primaryTextStyle.copyWith(color: colorPrimary),
            ),
            onPressed: () async {
              authProvider.logout();
              userProvider.user = null;
              Navigator.pushReplacementNamed(context, LoginPage.route);
            },
          ),
        ),
      ),
    );
  }
}
