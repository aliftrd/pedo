import 'package:pedo/views/screens/article/article_page.dart';
import 'package:pedo/views/screens/notification_page.dart';
import 'package:pedo/views/screens/partner/partner_post_page.dart';
import 'package:pedo/views/screens/partner/partner_register_page.dart';
import 'package:pedo/views/screens/partner/partner_thankyou_page.dart';
import 'package:pedo/views/screens/animal/animal_detail_page.dart';
import 'package:pedo/views/screens/animal/animal_page.dart';
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
  PartnerThankyouPage.route: (context) => const PartnerThankyouPage(),
  PartnerPostPage.route: (context) => const PartnerPostPage(),
  AnimalPage.route: (context) => const AnimalPage(),
  NotificationPage.route: (context) => const NotificationPage(),
};
