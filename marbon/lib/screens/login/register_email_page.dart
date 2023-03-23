import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:marbon/color.dart';
import 'package:marbon/size.dart';
import 'package:quickalert/quickalert.dart';
import '../../widgets/input_field.dart';

var logger = Logger();

class RegisterEmailPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>(); // 글로벌 key

  TextEditingController textController = TextEditingController();

  RegisterEmailPage({super.key});

  @override
  Widget build(BuildContext context) {
    // 전 회원가입 페이지에서 인자로 보내준 인증 코드 가져오기
    final arguments = (ModalRoute.of(context)?.settings.arguments ??
        <String, dynamic>{}) as Map;
    final String authCode = arguments["code"];
    logger.d(authCode); // authcode 나오나 확인해볼 것ㄴ

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: toolbar_height,
        shadowColor: transparent_color,
        backgroundColor: transparent_color,
        iconTheme: const IconThemeData(
          color: text_green_color,
        ),
      ),
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
                    "Register",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 40,
                      color: dark_green_color,
                    ),
                  ),
                  const SizedBox(height: title_input_gap),
                  SizedBox(
                    height: two_line_text_box,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          "We have sent an email to your email account",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 16, color: explain_text_color),
                        ),
                        Text(
                          "with a verification code!",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                            color: explain_text_color,
                          ),
                        )
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
                        InputField("  Ex) fs18dx4", "none", textController),
                        const SizedBox(height: input_button_gap),
                        SizedBox(
                          width: button_width,
                          height: button_height,
                          child: TextButton(
                            child: const Text(
                              "Register",
                              style: TextStyle(fontSize: 20),
                            ),
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                if (authCode ==
                                    textController.text.toString()) {
                                  // 등록 완료됨을 띄우고 okay -> 로그인창
                                  QuickAlert.show(
                                    context: context,
                                    type: QuickAlertType.success,
                                    text: "Signup Completed Successfully",
                                    onConfirmBtnTap: () {
                                      Navigator.pushNamed(context, "/login");
                                    },
                                  );
                                } else {
                                  QuickAlert.show(
                                    context: context,
                                    type: QuickAlertType.warning,
                                    text: "Please Check your verification code",
                                  );
                                  // + 입력된 값 자동으로 지워주는것도 추가
                                }
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
