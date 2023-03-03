import 'package:flutter/material.dart';
import 'package:marbon/widgets/input_field.dart';
import '../../size.dart';

class RegisterForm extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  RegisterForm({super.key});
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          const InputField("Email", "email"),
          const SizedBox(height: input_input_gap),
          const InputField("nickname", "nick"),
          const SizedBox(height: input_input_gap),
          const InputField("Password", "pw"),
          const SizedBox(height: input_button_gap),
          // 3. TextButton 추가
          SizedBox(
            width: button_width,
            height: button_height,
            child: TextButton(
              child: const Text(
                "Register",
                style: TextStyle(fontSize: 20),
              ),
              onPressed: () {
                // 3. 유효성 검사
                if (_formKey.currentState!.validate()) {
                  Navigator.pushNamed(context, "/register_email");
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
