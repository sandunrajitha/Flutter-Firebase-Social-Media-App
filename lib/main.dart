import 'package:flutter/material.dart';
import 'package:fluttergram/responsive/mobile_screen_layout.dart';
import 'package:fluttergram/responsive/responsive_screen_layout.dart';
import 'package:fluttergram/responsive/web_screen_layout.dart';
import 'package:fluttergram/utils/colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'FlutterGram',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: mobileBackgroundColor
      ),
      home:  const ResponsiveLayout(webScreenLayout: WebScreenLayout(), mobileScreenLayout: MobileScreenLayout(),),
    );
  }
}