import 'package:flutter/material.dart';
import 'package:marbon/color.dart';
import 'package:marbon/size.dart';

import '../../widgets/input_field.dart';

class ForgetPwPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  ForgetPwPage({super.key});
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
                    "Forget password?",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 35, color: dark_green_color),
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
                          "Don't worry! Please enter the phone ",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 16, color: explain_text_color),
                        ),
                        Text(
                          "number linked with your account",
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
                        const InputField("Email", "email"),
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
                                Navigator.pushNamed(
                                    context, "/forget_pw_email");
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
