import 'package:flutter/material.dart';
import 'package:marbon/color.dart';
import 'package:marbon/size.dart';
import 'package:marbon/widgets/email_pinput.dart';

class ForgetPwEmailPage extends StatelessWidget {
  const ForgetPwEmailPage({super.key});

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
                    "Enter authentication coder",
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
                      // 코드 다시 전송하는 함수
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
                        // 인증코드가 맞는지 확인하고
                        // 맞으면 이메일로 이전 비밀번호 보내주고 로그인페이지로 이동 (보냈다고 팝업띄우기)
                        // 인증코드가 틀리다면 잘못된 코드입니다 알림 띄우고 숫자 지우기
                        Navigator.pushNamed(context, "/login");
                      },
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
