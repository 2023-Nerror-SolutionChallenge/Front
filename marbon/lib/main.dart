import 'package:flutter/material.dart';
import 'package:marbon/screens/home/home_page.dart';
import 'package:marbon/screens/login/login_page.dart';
import 'package:get/get.dart';

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
      theme: ThemeData(     
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
      initialRoute: "/",
      getPages: [
        GetPage(name: "/", page: ()=>LoginPage())
      ],
    );
  }
}