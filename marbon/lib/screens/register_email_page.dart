import 'package:flutter/material.dart';
import 'package:marbon/color.dart';
import 'package:marbon/size.dart';
import '../widgets/input_field.dart';

class RegisterEmailPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>(); // 글로벌 key

  RegisterEmailPage({super.key});

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
                        const InputField("  Ex) 1918787", "none"),
                        const SizedBox(height: input_button_gap),
                        SizedBox(
                          width: button_width,
                          height: button_height,
                          child: TextButton(
                            child: const Text(
                              "Register",
                              style: TextStyle(fontSize: 20),
                            ),
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                Navigator.pushNamed(context, "/login");
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
