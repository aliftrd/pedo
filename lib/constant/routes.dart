import 'package:pedo/views/screens/article/article_page.dart';
import 'package:pedo/views/screens/pet_list/pet_detail.dart';
import 'package:pedo/views/screens/pet_list/pet_list.dart';
import 'package:pedo/views/screens/profile_page.dart';
import 'package:pedo/views/screens/article/article_detail_page.dart';
import 'package:pedo/views/screens/home_page.dart';
import 'package:pedo/views/screens/login_page.dart';
import 'package:pedo/views/screens/more_page.dart';
import 'package:pedo/views/screens/page_switcher.dart';
import 'package:pedo/views/screens/register_page.dart';
import 'package:pedo/views/screens/splash_page.dart';

dynamic routes = {
  '/': (context) => const SplashPage(),
  LoginPage.route: (context) => LoginPage(),
  RegisterPage.route: (context) => RegisterPage(),
  PageSwitcher.route: (context) => PageSwitcher(),
  HomePage.route: (context) => HomePage(),
  ProfilePage.route: (context) => ProfilePage(),
  MorePage.route: (context) => MorePage(),
  ArticlePage.route: (context) => ArticlePage(),
  petList.route: (context) => petList(),
  petDetail.route: (context) => petDetail(),
  SplashPage.route: (context) => const SplashPage(),
  LoginPage.route: (context) => const LoginPage(),
  RegisterPage.route: (context) => const RegisterPage(),
  PageSwitcher.route: (context) => const PageSwitcher(),
  HomePage.route: (context) => const HomePage(),
  ProfilePage.route: (context) => const ProfilePage(),
  MorePage.route: (context) => const MorePage(),
  ArticlePage.route: (context) => const ArticlePage(),
  ArticleDetailPage.route: (context) => const ArticleDetailPage(),
};
