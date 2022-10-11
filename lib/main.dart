import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pedo/constant/routes.dart';
import 'package:pedo/constant/themes.dart';
import 'package:pedo/core/providers/auth_provider.dart';
import 'package:pedo/views/screens/home_page.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: colorPrimary,
    statusBarIconBrightness: Brightness.light,
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
        ChangeNotifierProvider(create: (context) => AuthProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: routes,
      ),
    );
  }
}
