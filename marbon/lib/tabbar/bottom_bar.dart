import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../controller/bottom_navigation_controller.dart';
import '../screens/mypage/my_page.dart';
import '../screens/mainscreen/main_screen.dart';
import '../screens/smartscan/smartscan.dart';

class BottomBar extends StatelessWidget {
  BottomNavigationController bottomNavigationController =
      Get.put(BottomNavigationController());
  BottomBar({Key? key}) : super(key: key);

  final screens = [
    MainScreen(),
    const SmartScan(),
    const MyPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => IndexedStack(
          index: bottomNavigationController.selectedIndex.value,
          children: screens,
        ),
      ),
      bottomNavigationBar: Obx(() => BottomNavigationBar(
            type: BottomNavigationBarType.shifting,
            selectedItemColor: const Color(0xff5C823D),
            unselectedItemColor: const Color(0xff5C823D),
            showSelectedLabels: true,
            // showUnselectedLabels: false,
            onTap: (index) {
              bottomNavigationController.changeIndex(index);
            },
            currentIndex: bottomNavigationController.selectedIndex.value,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: "Home",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.mark_email_read),
                label: "SmartScan",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.contact_page),
                label: "MyPage",
              )
            ],
          )),
    );
  }
}
