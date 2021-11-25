
import 'package:bima_finance/core/constant/app_color.dart';
import 'package:bima_finance/locator.dart';
import 'package:bima_finance/ui/view/splash_screen_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() async {
  setupLocator();
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bima Finance',
      theme: ThemeData(
        primaryColor: colorPrimary,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textTheme: TextTheme(body1: TextStyle(fontSize: 12), body2: TextStyle(fontSize: 12)),
        fontFamily: 'DMSans',
        scaffoldBackgroundColor: Colors.white,
      ),
      debugShowCheckedModeBanner: false,
      home: SplashScreenView(),
    );
  }
}