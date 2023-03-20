import 'package:flutter/material.dart';
import 'package:marbon/size.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

import '../../color.dart';
import '../../widgets/input_field.dart';

class ChangePw2 extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  TextEditingController textController = TextEditingController();

  // api로 auth 코드 async로 가져올것
  final String authCode = "123456";

  ChangePw2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: toolbar_height,
        shadowColor: transparent_color,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(
          color: text_green_color,
        ),
      ),
      body: ListView(
        children: [
          const SizedBox(
            height: circle_start - 50,
          ),
          const Text(
            "Authentication",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 35,
                color: dark_green_color,
                fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 20,
          ),
          SizedBox(
            height: two_line_text_box,
            width: 330,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: const [
                Text(
                  "We have sent an email to your email account",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, color: explain_text_color),
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
                      "Confirm",
                      style: TextStyle(fontSize: 20),
                    ),

                    // 기존에 만들어둔거 사용하기
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        if (authCode == textController.text.toString()) {
                          // 등록 완료됨을 띄우고 okay 누르면 로그인창으로 넘기기
                          Navigator.pushNamed(context, "/change_pw3");
                        } else {
                          // 인증번호 일치하지 않는다고 알리기
                          // ++ 입력된 값 자동으로 지워주는것도 추가
                          QuickAlert.show(
                              context: context,
                              type: QuickAlertType.warning,
                              text: "Please Check your verification code");
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
    );
  }
}
