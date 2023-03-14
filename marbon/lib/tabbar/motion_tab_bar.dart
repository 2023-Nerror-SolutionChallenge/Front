import 'package:flutter/material.dart';
import 'package:marbon/screens/mypage/my_page.dart';
import '../controller/bottom_navigation_controller.dart';
import 'package:get/get.dart';
import 'package:motion_tab_bar/motiontabbar.dart';

import '../screens/mainscreen/main_screen.dart';
import '../screens/smartscan/smartscan.dart';

class MotionTabBarPage extends StatelessWidget {
  MotionTabBarPage({Key? key}) : super(key: key);

  BottomNavigationController bottomNavigationController =
      Get.put(BottomNavigationController());

  final screens = [
    MainScreen(),
    const SmartScan(),
    const MyPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => IndexedStack(
            index: bottomNavigationController.selectedIndex.value,
            children: screens,
          )),
      bottomNavigationBar: MotionTabBar(
        labels: const ["Home", "SmartScan", "MyPage"],
        initialSelectedTab: "Home",
        tabIconColor: Colors.green,
        tabSelectedColor: Colors.purple,
        icons: const [Icons.home, Icons.mark_email_read, Icons.contact_page],
        textStyle: const TextStyle(color: Colors.purple),
        onTabItemSelected: (index) {
          bottomNavigationController.changeIndex(index);
        },
      ),
    );
  }
}
