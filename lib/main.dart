import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pedo/constant/routes.dart';
import 'package:pedo/constant/themes.dart';
import 'package:pedo/core/controller/image_controller.dart';
import 'package:pedo/core/providers/animal_provider.dart';
import 'package:pedo/core/providers/article_provider.dart';
import 'package:pedo/core/providers/auth_provider.dart';
import 'package:pedo/core/providers/partner_post_provider.dart';
import 'package:pedo/core/providers/partner_provider.dart';
import 'package:pedo/core/providers/partner_register_provider.dart';
import 'package:provider/provider.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() {
  HttpOverrides.global = MyHttpOverrides();
  runApp(const MyApp());
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark,
    systemNavigationBarColor: colorLight,
    systemNavigationBarIconBrightness: Brightness.dark,
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // =========================== Provider =========================== //
        ChangeNotifierProvider(create: (context) => AuthProvider()),
        ChangeNotifierProvider(create: (context) => ArticleProvider()),
        ChangeNotifierProvider(create: (context) => AnimalProvider()),
        ChangeNotifierProvider(create: (context) => PartnerRegisterProvider()),
        ChangeNotifierProvider(create: (context) => PartnerProvider()),
        ChangeNotifierProvider(create: (context) => PartnerPostProvider()),
        // =========================== Controller =========================== //
        ChangeNotifierProvider(create: (context) => ImageController()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: routes,
      ),
    );
  }
}
