import 'package:flutter/material.dart';
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
                                Navigator.pushNamed(context, "/smartscan");
                              }
                            },
                            // onPressed: () async {
                            //   if (_formKey.currentState!.validate()) {
                            //     if (context.mounted) return;
                            //     Navigator.pushNamed(context, "/smartscan");
                            //     final flag = await ApiService().postLogin(
                            //         emailController.text.toString(),
                            //         passwordController.text.toString());
                            //     if (flag) {
                            //
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
