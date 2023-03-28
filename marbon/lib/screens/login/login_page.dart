import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marbon/color.dart';
import 'package:marbon/size.dart';
import '../../service/api_service.dart';
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
                    style: TextStyle(
                      fontSize: 40,
                      color: dark_green_color,
                      fontWeight: FontWeight.w800,
                    ),
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
                        Container(
                          height: 40,
                          padding: const EdgeInsets.only(right: 40),
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            style: TextButton.styleFrom(
                              backgroundColor: transparent_color,
                              foregroundColor: dark_green_color,
                            ),
                            child: const Text(
                              "Forget Password?",
                              style: TextStyle(fontSize: 14),
                            ),
                            onPressed: () {
                              Navigator.pushNamed(
                                context,
                                "/forget_pw",
                              );
                            },
                          ),
                        ),
                        const SizedBox(height: 30),
                        SizedBox(
                          width: button_width,
                          height: button_height,
                          child: TextButton(
                            child: const Text(
                              "Login",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w600),
                            ),

                            //로그인 성공시 해당 정보들을 받아서 getX에 등록하기
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                final returnData = await ApiService().postLogin(
                                    emailController.text.toString(),
                                    passwordController.text.toString());
                                if (returnData["flag"]) {
                                  Get.find<UserController>().upadateUserInform(
                                    id: returnData["id"],
                                    nick: returnData["nick"],
                                    pw: returnData["pw"],
                                    accessToken: returnData["accessToken"],
                                    refreshToken: returnData["refreshToken"],
                                    deleteCount: returnData["deleteCount"],
                                    totalCount: returnData['totalCount'],
                                    currentLevel: returnData['currentLevel'],
                                    badges: returnData["badgeList"],
                                    mailAccounts: returnData["mailAccounts"],
                                  );
                                  Navigator.pushNamed(context, "/bottom_bar");
                                  // Navigator.pushNamed(context, "/bottomBar", arguments: returnData);
                                }
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 135),
                  Row(
                    // 계정 추가 텍스트버튼
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Don’t have an account?",
                        style: TextStyle(
                            fontSize: 16,
                            color: dark_green_color,
                            fontWeight: FontWeight.w400),
                      ),
                      TextButton(
                        style: TextButton.styleFrom(
                          backgroundColor: transparent_color,
                        ),
                        child: const Text(
                          "Register Now",
                          style: TextStyle(
                              fontSize: 16,
                              color: yellow_green_color,
                              fontWeight: FontWeight.w600),
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
  String _id = "";
  String _nick = "";
  String _pw = "";
  String _accessToken = "";
  String _refreshToken = "";
  int _deleteCount = 0;
  int _totalCount = 0;
  int _currentLevel = 0;
  List<int> _badges = [];
  List<dynamic> _mailAccounts = [];

  get id => _id;
  get nick => _nick;
  get pw => _pw;
  get accessToken => _accessToken;
  get refreshToken => _refreshToken;
  get deleteCount => _deleteCount;
  get totalCount => _totalCount;
  get currentLevel => _currentLevel;
  get badges => _badges;
  get mailAccounts => _mailAccounts;

  void upadateUserInform(
      {required String id,
      required String nick,
      required String pw,
      required String accessToken,
      required String refreshToken,
      required int deleteCount,
      required int totalCount,
      required int currentLevel,
      required List<int> badges,
      required List<dynamic> mailAccounts}) {
    _id = id;
    _nick = nick;
    _pw = pw;
    _accessToken = accessToken;
    _refreshToken = refreshToken;
    _deleteCount = deleteCount;
    _totalCount = totalCount;
    _currentLevel = currentLevel;
    _badges = badges;
    _mailAccounts = mailAccounts;

    update();
  }
}
