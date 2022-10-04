import 'package:flutter/material.dart';
import 'package:pedo/views/screens/login_page.dart';
import 'package:pedo/views/screens/register_page.dart';
import 'package:pedo/views/screens/home_page.dart';
import 'package:pedo/views/screens/splash_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => SplashPage(),
        '/login': (context) => LoginPage(),
        '/register': (context) => RegisterPage(),
        '/home': (context) => HomePage(),
      },
    );
  }
}
