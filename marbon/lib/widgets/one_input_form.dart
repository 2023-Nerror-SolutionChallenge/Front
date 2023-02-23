import 'package:flutter/material.dart';
import 'package:marbon/size.dart';

import 'input_field.dart';

class OneInputForm extends StatelessWidget {
  final _formKey = GlobalKey<FormState>(); // 글로벌 key
  final String formText;
  final String formIcon;
  final String buttonText;
  final String nextLink;

  OneInputForm(this.formText, this.formIcon, this.buttonText, this.nextLink,
      {super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          InputField(formText, formIcon),
          const SizedBox(height: input_button_gap),
          SizedBox(
            width: button_width,
            height: button_height,
            child: TextButton(
              child: Text(
                // 여기서 중단점이 생기는데 문제되는게 아예 없어보임;;; 왜 중단점이 생기지?
                buttonText,
                style: const TextStyle(fontSize: 20),
              ),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  Navigator.pushNamed(context, nextLink);
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
