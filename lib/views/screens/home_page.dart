import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pedo/constant/themes.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void showUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey('authData')) {
      String authData = prefs.getString('authData')!;
      print(authData);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    showUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Text(
            'Bonjour',
            style: primaryTextStyle.copyWith(
              fontSize: 36,
              fontWeight: light,
            ),
          ),
        ),
      ),
    );
  }
}
