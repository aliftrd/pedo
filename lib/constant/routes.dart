import 'package:pedo/views/screens/article/article_page.dart';
import 'package:pedo/views/screens/partner_register_page.dart';
import 'package:pedo/views/screens/partner_thankyou.dart';
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
  SplashPage.route: (context) => const SplashPage(),
  LoginPage.route: (context) => const LoginPage(),
  RegisterPage.route: (context) => const RegisterPage(),
  PageSwitcher.route: (context) => const PageSwitcher(),
  HomePage.route: (context) => const HomePage(),
  ProfilePage.route: (context) => const ProfilePage(),
  MorePage.route: (context) => const MorePage(),
  ArticlePage.route: (context) => const ArticlePage(),
  ArticleDetailPage.route: (context) => const ArticleDetailPage(),
  PartnerRegisterPage.route: (context) => const PartnerRegisterPage(),
  PartnerThankyou.route: (context) => const PartnerThankyou(),
  PetList.route: (context) => PetList(),
  PetDetail.route: (context) => PetDetail(),
};
