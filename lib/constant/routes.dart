import 'package:pedo/views/screens/about_page.dart';
import 'package:pedo/views/screens/home_page.dart';
import 'package:pedo/views/screens/login_page.dart';
import 'package:pedo/views/screens/more_page.dart';
import 'package:pedo/views/screens/register_page.dart';
import 'package:pedo/views/screens/splash_page.dart';

dynamic routes = {
  '/': (context) => SplashPage(),
  LoginPage.route: (context) => LoginPage(),
  RegisterPage.route: (context) => RegisterPage(),
  HomePage.route: (context) => HomePage(),
  AboutPage.route: (context) => AboutPage(),
  MorePage.route: (context) => MorePage(),
};
