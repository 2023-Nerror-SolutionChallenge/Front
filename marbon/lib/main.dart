import 'package:flutter/material.dart';
import 'package:marbon/screens/smartscan/smartscan.dart';
import 'package:marbon/screens/smartscan/smartscan_detail.dart';

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
      theme: ThemeData(),
      initialRoute: "/smartscan",
      routes: {
        "/smartscan": (context) => const SmartScan(),
        "/smartscan_detail": (context) => const SmartScanDetail(),
      },
    );
  }
}
