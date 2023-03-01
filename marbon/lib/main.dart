import 'package:flutter/material.dart';
import 'package:marbon/color.dart';
import 'package:marbon/screens/login/forget_pw_email_page.dart';
import 'package:marbon/screens/login/forget_pw_page.dart';
import 'package:marbon/screens/login/login_page.dart';
import 'package:marbon/screens/login/register_email_page.dart';
import 'package:marbon/screens/login/register_page.dart';
import 'package:marbon/screens/smart_scan.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Marbon',
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
      initialRoute: "/login",
      routes: {
        "/login": (context) => const LoginPage(),
        "/register": (context) => const RegisterPage(),
        "/register_email": (context) => RegisterEmailPage(),
        "/forget_pw": (context) => ForgetPwPage(),
        "/forget_pw_email": (context) => const ForgetPwEmailPage(),
        "/smart_scan": (context) => const SmartScan(),
      },
    );
  }
}
