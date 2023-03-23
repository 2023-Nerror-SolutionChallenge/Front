import 'package:flutter/material.dart';
import 'package:flutter_advanced_switch/flutter_advanced_switch.dart';
import 'package:get/get.dart';
import 'package:marbon/color.dart';
import 'package:marbon/widgets/input_field.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:tab_container/tab_container.dart';


class MyPage extends StatelessWidget {
  var nick = "Song Kim".obs;
  // 뱃지 소유 여부 -> 가짐1 안가짐0
  final List<int> HaveBadge = [1, 1, 0, 1, 0, 0];

  final _lightController = ValueNotifier<bool>(false);
  MyPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(NickController());
    return LayoutBuilder(
      builder: (context, constrains) => Column(
        children: [
          // 프로필부분
          _BuildProfileContainer(
              constrains.maxHeight * 0.45, constrains.maxWidth, context),
          // tab bar 부분
          Stack(
            children: [
              Container(
                height: constrains.maxHeight * 0.08,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(40),
                        bottomRight: Radius.circular(40))),
              ),
              SizedBox(
                height: constrains.maxHeight * 0.55,
                child: TabContainer(
                  selectedTextStyle: const TextStyle(
                      color: green_color,
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                  unselectedTextStyle: const TextStyle(
                      color: unselected_color,
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                  tabs: const [
                    "BADGES",
                    "MY MAILS",
                    "SETTINGS",
                  ],
                  children: [
                    _BuildBadgeContainer(
                        constrains.maxHeight * 0.6, constrains.maxWidth * 0.9),
                    _BuildMymailsContainer(
                        constrains.maxHeight * 0.6, constrains.maxWidth * 0.9, context),
                    _BuildSettingsContainer(constrains.maxHeight * 0.6,
                        constrains.maxWidth * 0.9, context),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _BuildProfileContainer(double h, double w, BuildContext context) {
    const double imgSizePercent = 0.45;
    return Container(
      width: w,
      height: h,
      color: Colors.white,
      padding: EdgeInsets.only(left: w * 0.1, right: w * 0.1, top: h * 0.22),
      child: Center(
          child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(w * imgSizePercent),
            child: Image.asset(
              'assets/img/signup_default.png',
              width: w * imgSizePercent,
              height: w * imgSizePercent,
              fit: BoxFit.fill,
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Obx(() {
                return Text(
                  Get.find<NickController>().nick.value.toString(),
                  style: const TextStyle(
                      color: text_green_color,
                      fontSize: 22,
                      fontWeight: FontWeight.bold),
                );
              }),
              IconButton(
                onPressed: () {
                  _BuildNickModal(context);
                },
                icon: Container(
                  width: 25,
                  height: 25,
                  decoration: const BoxDecoration(
                      color: placeholder_color,
                      borderRadius: BorderRadius.all(Radius.circular(25))),
                  child: const Icon(
                    Icons.edit_rounded,
                    color: text_green_color,
                    size: 18,
                  ),
                ),
              ),
            ],
          )
        ],
      )),
    );
  }

  Future<dynamic> _BuildNickModal(BuildContext context) {
    String newNick = '';
    return QuickAlert.show(
      context: context,
      type: QuickAlertType.custom,
      barrierDismissible: true,
      confirmBtnText: 'Save',
      confirmBtnColor: text_green_color,
      // customAsset: 'assets/custom.gif',
      widget: TextFormField(
        decoration: const InputDecoration(
          alignLabelWithHint: true,
          hintText: 'Enter Your Nickname',
          prefixIcon: Icon(
            Icons.person_outline,
            color: text_green_color,
          ),
        ),
        textInputAction: TextInputAction.next,
        keyboardType: TextInputType.name,
        onChanged: (value) => newNick = value,
      ),
      onConfirmBtnTap: () async {
        if (newNick.length < minNick) {
          await QuickAlert.show(
            context: context,
            type: QuickAlertType.error,
            confirmBtnColor: text_green_color,
            text: 'Please input something',
          );
          return;
        }
        Navigator.pop(context);
        await Future.delayed(const Duration(milliseconds: 500));
        if ((newNick.length) > minNick) {
          await QuickAlert.show(
            context: context,
            type: QuickAlertType.success,
            confirmBtnColor: text_green_color,
            confirmBtnText: "OK",
            text: "Your Nickname has been saved!",
          );
        }
        Get.find<NickController>().setNick(newNick);
      },
    );
  }

  Widget _BuildBadgeContainer(double h, double w) {
    return Container(
      padding: EdgeInsets.only(top: h * 0.16, bottom: h * 0.11),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(3, (index) {
              return Center(
                child: HaveBadge[index] == 0
                    ? LockBadgeImage(index + 1, w)
                    : BadgeImage(index + 1, w),
              );
            }),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(3, (index) {
              return Center(
                child: HaveBadge[index + 3] == 0
                    ? LockBadgeImage(index + 4, w)
                    : BadgeImage(index + 4, w),
              );
            }),
          )
        ],
      ),
    );
  }

  Widget LockBadgeImage(int idx, double w) {
    return Stack(
      children: [
        // 잠긴 이미지의 경우
        Image.asset(
          'assets/img/badges$idx.png',
          width: w * 0.25,
          height: w * 0.25,
        ),
        Positioned(
          child: Container(
            width: w * 0.25,
            height: w * 0.25,
            decoration: BoxDecoration(
              color: const Color.fromARGB(155, 158, 158, 158),
              borderRadius: BorderRadius.circular(w * 0.25),
            ),
          ),
        ),
        Positioned(
          top: w * 0.072,
          left: w * 0.075,
          child: const Icon(
            Icons.lock_outline_sharp,
            color: Color.fromARGB(251, 255, 254, 254),
            size: 35,
          ),
        )
      ],
    );
  }

  Widget BadgeImage(int idx, double w) {
    return Image.asset(
      'assets/img/badges$idx.png',
      width: w * 0.25,
      height: w * 0.25,
    );
  }

  Widget _BuildMymailsContainer(double h, double w, BuildContext c) {
    return Scaffold(

      backgroundColor: const Color(0xffedeedd),
      body: Stack(

        children: [
          Positioned(

              bottom: 100,
              left: 20,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 40,
                  ),
                  Container(
                    width: 150,
                    height: 50,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(90),
                        color: const Color(0xffffffff)),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        backgroundColor: const Color(0xffffffff),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(90.0),
                        ),
                      ),
                      onPressed: () {
                        Navigator.pushNamed(c, "/add_mail");
                      },
                      child:
                      const Text(
                        "+ Add Mail",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                  )
                ],
              ))
        ],
      ),
    );
  }


  Widget _BuildSettingsContainer(double h, double w, BuildContext c) {
    return Container(
      padding: EdgeInsets.only(left: w * 0.1, right: w * 0.1, top: h * 0.06),
      child: Column(
        children: [
          SizedBox(
            height: h * 0.15,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: const [
                    Icon(
                      Icons.lock_outline,
                      size: 26,
                      color: yellow_green_color,
                    ),
                    SizedBox(width: 20),
                    Text(
                      "Change Password",
                      style: TextStyle(fontSize: 17, color: yellow_green_color),
                    ),
                  ],
                ),
                IconButton(
                  onPressed: () {
                    Navigator.pushNamed(c, "/change_pw1");
                  },
                  icon: const Icon(Icons.navigate_next_outlined),
                  iconSize: 30,
                  color: yellow_green_color,
                ),
              ],
            ),
          ),
          SizedBox(
            height: h * 0.15,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: const [
                    Icon(
                      Icons.dark_mode_outlined,
                      size: 26,
                      color: yellow_green_color,
                    ),
                    SizedBox(width: 20),
                    Text(
                      "Dark Mode",
                      style: TextStyle(fontSize: 17, color: yellow_green_color),
                    ),
                  ],
                ),
                AdvancedSwitch(
                  controller: _lightController,
                  height: 25,
                  width: 40,
                  activeColor: yellow_green_color,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class NickController extends GetxController {
  RxString nick = "Song Kim".obs;

  void setNick(String newNick) {
    nick.value = newNick;
    update();
  }
}
