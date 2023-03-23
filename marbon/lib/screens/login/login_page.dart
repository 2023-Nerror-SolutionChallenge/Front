import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marbon/color.dart';
import 'package:marbon/size.dart';
import '../../widgets/input_field.dart';

class LoginPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(
            height: circle_start,
          ),
          Expanded(
            child: Container(
              // 뒷배경 원
              decoration: const BoxDecoration(
                color: back_round_color,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(circle_radius),
                  topRight: Radius.circular(circle_radius),
                ),
              ),
              child: ListView(
                children: [
                  const Text(
                    "Login",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 40, color: dark_green_color),
                  ),
                  const SizedBox(height: title_input_gap),
                  // 로그인폼
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        InputField("Email", "email", emailController),
                        const SizedBox(height: input_input_gap),
                        InputField("Password", "pw", passwordController),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                              style: TextButton.styleFrom(
                                backgroundColor: transparent_color,
                                foregroundColor: dark_green_color,
                              ),
                              child: const Text(
                                "Forget Password?",
                                style: TextStyle(fontSize: 15),
                              ),
                              onPressed: () {
                                Navigator.pushNamed(
                                  context,
                                  "/forget_pw",
                                );
                              },
                            ),
                            const SizedBox(
                              width: 30,
                            )
                          ],
                        ),
                        const SizedBox(height: 30),
                        SizedBox(
                          width: button_width,
                          height: button_height,
                          child: TextButton(
                            child: const Text(
                              "Login",
                              style: TextStyle(fontSize: 20),
                            ),
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                Navigator.pushNamed(context, "/bottom_bar");
                              }
                            },
                            // 로그인 성공시 해당 정보들을 받아서 getX에 등록하기
                            // onPressed: () async {
                            //   if (_formKey.currentState!.validate()) {
                            //     if (context.mounted) return;
                            //     Navigator.pushNamed(context, "/bottomBar");
                            //     final returnData = await ApiService().postLogin(
                            //         emailController.text.toString(),
                            //         passwordController.text.toString());
                            //     if (returnData) {

                            //       //받아온값을 해당 인자에 넣어주기
                            //       // Get.find<UserController>().upadateUserInform(nick: nick, pw: pw, deleteCount: deleteCount, totalCount: totalCount, badges: badges)
                            //     }
                            //   }
                            // },
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 180),
                  Row(
                    // 계정 추가 텍스트버튼
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Don’t have an account?",
                        style: TextStyle(
                          fontSize: 18,
                          color: dark_green_color,
                        ),
                      ),
                      TextButton(
                        style: TextButton.styleFrom(
                          backgroundColor: transparent_color,
                        ),
                        child: const Text(
                          "Register Now",
                          style: TextStyle(
                            fontSize: 18,
                            color: yellow_green_color,
                          ),
                        ),
                        onPressed: () {
                          Navigator.pushNamed(context, "/register");
                        },
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class UserController extends GetxController {
  String _nick = "";
  String _pw = "";
  List<String> _badges = [];
  int _deleteCount = 0;
  int _totalCount = 0;

  void upadateUserInform(
      {required String nick,
      required String pw,
      required int deleteCount,
      required int totalCount,
      required List<String> badges}) {
    _nick = nick;
    _pw = pw;
    _badges = badges;
    _deleteCount = deleteCount;
    _totalCount = totalCount;
  }

  //   STARTERS("시작이 반"),
  //   ENVIRONMENTAL_TUTELARY("환경 수호자"),
  //   EARTH_TUTELARY("지구의 수호자"),
  //   MAIL_RICH("메일 부자"),
  //   MARBON_MARATHONER("말본 마라토너"),
  //   ENVIRONMENTAL_MODEL("환경 모범생");
}
