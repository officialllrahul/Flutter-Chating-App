import 'package:flutter/material.dart';
import 'package:talkindia/Config/routes.dart';
import 'package:talkindia/config/theme.dart';
import 'package:talkindia/presentations/splash_screen/splash_screen.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TalkIndia',
      theme: lightTheme,
      getPages: routes,
      darkTheme: darkTheme,
      themeMode: ThemeMode.dark,
      home: SplashScreen(),
    );
  }
}
