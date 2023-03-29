import 'package:flutter/material.dart';
import '../color.dart';

class AddMailServerPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  AddMailServerPage({super.key});

  @override
  Widget build(BuildContext context) {
    final arguments = (ModalRoute.of(context)?.settings.arguments ??
        <String, dynamic>{}) as Map;
    final String mailAddress =
        arguments["mailAddress"]; //mailAddress가 내가 등록한 이메일 ㅈ소임

    print(mailAddress);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        shadowColor: transparent_color,
        iconTheme: const IconThemeData(),
        actions: [
          TextButton(
            style: TextButton.styleFrom(
              backgroundColor: transparent_color,
              foregroundColor: dark_green_color,
            ),
            onPressed: () {
              // 메일 추가 api
            },
            child: const Text(
              "NEXT",
              style: TextStyle(fontWeight: FontWeight.w900, fontSize: 17),
            ),
          )
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.only(left: 10, right: 10),
        children: [
          const SizedBox(height: 20),
          Image.asset(
            "assets/img/mail.png",
            width: 100,
            height: 100,
            fit: BoxFit.contain,
          ),
          const SizedBox(height: 40),
          const Text(
            "수신 서버 설정",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 35, fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 20),
          const Divider(color: text_green_color, thickness: 2.5),
          const SizedBox(height: 30),
          Container(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Form(
              key: _formKey,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: const [
                  // 폼에 맞는 Textformfield 넣어주쇼
                  //
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
