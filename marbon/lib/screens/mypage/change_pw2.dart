import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marbon/screens/login/login_page.dart';
import 'package:marbon/size.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

import '../../color.dart';
import '../../service/api_service.dart';
import '../../widgets/input_field.dart';

class ChangePw2 extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  TextEditingController textController = TextEditingController();

  ChangePw2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: toolbar_height,
        shadowColor: transparent_color,
        backgroundColor: transparent_color,
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
            "Settings Password",
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
                  "Please Enter your new password",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, color: explain_text_color),
                ),
                Text(
                  "8~16 length, letters and numbers combination",
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
                InputField("Password", "pw", textController),
                const SizedBox(height: input_button_gap),
                SizedBox(
                  width: button_width,
                  height: button_height,
                  child: TextButton(
                    child: const Text(
                      "Confirm",
                      style: TextStyle(fontSize: 20),
                    ),
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        // pw를 바꾸는 api 성공하면 성공했다 알람띄우고 이동
                        logger.d(Get.find<UserController>().id);
                        bool flag = await ApiService().modifyPassword(
                            Get.find<UserController>().id,
                            textController.text.toString());

                        if (flag) {
                          await QuickAlert.show(
                            context: context,
                            type: QuickAlertType.success,
                            confirmBtnColor: text_green_color,
                            text: 'Change password successfully',
                          );

                          Navigator.popUntil(
                              context, ModalRoute.withName('/bottom_bar'));
                        } else {
                          QuickAlert.show(
                              context: context,
                              type: QuickAlertType.error,
                              text: "Failed to save password. Retry!");
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
