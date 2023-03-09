import 'package:flutter/material.dart';
import 'package:marbon/screens/home/home_page.dart';
import 'package:marbon/screens/login/forget_pw_email_page.dart';
import 'package:marbon/screens/login/forget_pw_page.dart';
import 'package:marbon/screens/login/login_page.dart';
import 'package:get/get.dart';
import 'package:marbon/screens/login/register_email_page.dart';
import 'package:marbon/screens/login/register_page.dart';
import 'package:marbon/screens/mainscreen/smart_scan.dart';
import 'package:marbon/tabbar/bottom_bar.dart';
import 'package:marbon/tabbar/motion_tab_bar.dart';
import 'color.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Marbon',
      home: MotionTabBarPage(),
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xffEDEEDD),
        // 버튼 테마
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: white_90_color,
            backgroundColor: dark_green_color,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(67),
            ),
          ),
        ),
      ),
     // home: const BottomBar(),
      initialRoute: "/home",
      routes: {
        "/home": (context) => const HomePage(),
        "/login": (context) => const LoginPage(),
        "/register": (context) => const RegisterPage(),
        "/register_email": (context) => RegisterEmailPage(),
        "/forget_pw": (context) => ForgetPwPage(),
        "/forget_pw_email": (context) => ForgetPwEmailPage(),
        "/bottom_bar": (context) =>  BottomBar(),
        "/smart_scan" : (context) => const SmartScan(),
      },
    );
  }
}

