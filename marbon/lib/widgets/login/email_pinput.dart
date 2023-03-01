import 'package:flutter/material.dart';
import 'package:marbon/color.dart';
import 'package:pinput/pinput.dart';

class EmailPinput extends StatefulWidget {
  const EmailPinput({Key? key}) : super(key: key);

  @override
  _EmailPinputState createState() => _EmailPinputState();
}

class _EmailPinputState extends State<EmailPinput> {
  final controller = TextEditingController();
  final focusNode = FocusNode();

  @override
  void dispose() {
    controller.dispose();
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 60,
      height: 60,
      textStyle: const TextStyle(
        fontSize: 25,
        color: text_green_color,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(35),
        border: Border.all(
          width: 1,
          color: yellow_green_color,
        ),
      ),
    );

    return Pinput(
      length: 4,
      controller: controller,
      focusNode: focusNode,
      defaultPinTheme: defaultPinTheme,
      separator: const SizedBox(width: 16),
      focusedPinTheme: defaultPinTheme.copyWith(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(35),
          border: Border.all(
            width: 1,
            color: dark_green_color,
          ),
        ),
      ),
      onCompleted: (pin) {
        // 비밀번호 값 줄 것
      },
      showCursor: false,
    );
  }
}
