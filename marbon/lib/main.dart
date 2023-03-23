import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:marbon/color.dart';
import 'package:marbon/screens/home/home_page.dart';

import 'package:marbon/screens/login/forget_pw_email_page.dart';
import 'package:marbon/screens/login/forget_pw_new.dart';
import 'package:marbon/screens/login/forget_pw_page.dart';
import 'package:marbon/screens/login/login_page.dart';
import 'package:marbon/screens/login/register_email_page.dart';
import 'package:marbon/screens/login/register_page.dart';
import 'package:marbon/screens/mainscreen/main_screen.dart';
import 'package:marbon/screens/mypage/change_pw1.dart';
import 'package:marbon/screens/mypage/change_pw2.dart';
import 'package:marbon/screens/mypage/change_pw3.dart';

import 'package:marbon/tabbar/bottom_bar.dart';
import 'package:marbon/tabbar/motion_tab_bar.dart';
import 'package:marbon/screens/smartscan/smartscan.dart';
import 'package:marbon/screens/smartscan/smartscan_delete.dart';
import 'package:marbon/screens/smartscan/smartscan_detail.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Checks()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final userController = Get.put(UserController());
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
      initialRoute: "/home",
      routes: {
        "/home": (context) => const HomePage(),
        "/register_email": (context) => RegisterEmailPage(),
        "/forget_pw": (context) => ForgetPwPage(),
        "/forget_pw_email": (context) => ForgetPwEmailPage(),
        "/forget_pw_new": (context) => ForgetPwNew(),
        "/login": (context) => LoginPage(),
        "/register": (context) => RegisterPage(),
        "/mainscreen": (context) => const MainScreen(),
        "/bottom_bar": (context) => BottomBar(),
        "/smartscan": (context) => const SmartScan(),
        "/smartscan_detail": (context) => const SmartScanDetail(),
        "/smartscan_delete": (context) => const SmartScanDelete(),
        "/change_pw1": (context) => ChangePw1(),
        "/change_pw2": (context) => ChangePw2(),
        "/change_pw3": (context) => ChangePw3(),
      },
    );
  }
}
