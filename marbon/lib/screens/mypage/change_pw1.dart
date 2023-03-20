import 'package:flutter/material.dart';
import 'package:marbon/size.dart';

import '../../color.dart';
import '../../widgets/input_field.dart';

class ChangePw1 extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  TextEditingController textController = TextEditingController();

  ChangePw1({super.key});

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
            "New password?",
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
                  "Would you like to change your password?",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, color: explain_text_color),
                ),
                Text(
                  "Put your Email linked with your account!",
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
                InputField("Email", "email", textController),
                const SizedBox(height: input_button_gap),
                SizedBox(
                  width: button_width,
                  height: button_height,
                  child: TextButton(
                    child: const Text(
                      "Send code",
                      style: TextStyle(fontSize: 20),
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        Navigator.pushNamed(context, "/change_pw2");
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
