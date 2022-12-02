import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pedo/constant/themes.dart';
import 'package:pedo/core/models/user_model.dart';
import 'package:pedo/core/providers/auth_provider.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatelessWidget {
  static String route = '/profile';

  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Profil',
          style: primaryTextStyle.copyWith(
            fontSize: 16,
            fontWeight: semibold,
          ),
        ),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            Icons.arrow_back,
            color: colorDark,
          ),
        ),
        centerTitle: true,
        backgroundColor: background,
        elevation: 0.0,
      ),
      backgroundColor: background,
      body: SafeArea(
        child: Text('Hello World'),
      ),
    );
  }
}
