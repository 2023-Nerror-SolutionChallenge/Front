import 'package:flutter/material.dart';
import 'package:marbon/color.dart';
import 'package:marbon/size.dart';
import 'package:marbon/widgets/login/email_pinput.dart';

class ForgetPwEmailPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  ForgetPwEmailPage({super.key});

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
                    "Enter authentication code",
                    style: TextStyle(
                      fontSize: 25,
                      color: dark_green_color,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: two_line_text_box,
                    width: 330,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          "Enter the 4-digit that we have sent via the Email",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 16, color: explain_text_color),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        const EmailPinput(),
                        const SizedBox(
                          height: 20,
                        ),
                        TextButton(
                          style: TextButton.styleFrom(
                            backgroundColor: transparent_color,
                            foregroundColor: dark_green_color,
                          ),
                          child: const Text(
                            "Resend code",
                            style: TextStyle(fontSize: 17),
                          ),
                          onPressed: () {
                            // ?????? ?????? ???????????? ??????
                          },
                        ),
                        const SizedBox(height: 20),
                        SizedBox(
                          width: button_width,
                          height: button_height,
                          child: TextButton(
                            child: const Text(
                              "Login",
                              style: TextStyle(fontSize: 20),
                            ),
                            onPressed: () {
                              // ??????????????? ????????? ????????????
                              // ????????? ???????????? ?????? ???????????? ???????????? ????????????????????? ?????? (???????????? ???????????????)
                              // ??????????????? ???????????? ????????? ??????????????? ?????? ????????? ?????? ?????????
                              if (_formKey.currentState!.validate()) {
                                Navigator.pushNamed(context, "/login");
                              }
                            },
                          ),
                        ),
                      ],
                    ),
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
