import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marbon/screens/smartscan/smartscan.dart';
import 'package:marbon/screens/smartscan/smartscan_delete.dart';
import 'package:marbon/screens/smartscan/smartscan_detail.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => Checks()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Marbon',
      theme: ThemeData(),
      initialRoute: "/smartscan",
      routes: {
        "/smartscan": (context) => const SmartScan(),
        "/smartscan_detail": (context) => const SmartScanDetail(),
        "/smartscan_delete": (context) => const SmartScanDelete(),
      },
    );
  }
}
