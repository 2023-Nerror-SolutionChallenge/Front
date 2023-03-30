import 'package:flutter/material.dart';
import '../color.dart';

class AddMailServerPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController imapController = TextEditingController();
  TextEditingController portController = TextEditingController();
  AddMailServerPage({super.key});


  @override
  Widget build(BuildContext context) {
    final arguments = (ModalRoute.of(context)?.settings.arguments ??
        <String, dynamic>{}) as Map;
    final String mailAddress =
        arguments["mailAddress"]; //mailAddress가 내가 등록한 이메일 주소

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
            onPressed: () async {
              // 메일 추가 api
              // Navigator.pushNamed(
              //   context,
              //   "/add_mail",
              //   arguments: {
              //     "email": emailController.text.toString(),
              //   },
              // );

              // if (address == "") {
              //   address = companyController.text.toString();
              // }
              // if (_formKey.currentState!.validate()) {
              //   Navigator.pushNamed(context, "/bottom_tab_bar", arguments: {
              //     "mailAddress": "${emailController.text.toString()}@$address"
              //   });
              // }

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
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    TextFormField(
                        decoration: InputDecoration(
                          hintText: 'Your Nickname',
                          labelText: '사용자이름',
                        ),

                      keyboardType: TextInputType.name,
                      controller: emailController,
                      validator: (value) {
                        if ((value?.length)! < 1) {
                          return "값을 입력하세요";
                        }
                        return null;
                      }
                      ),
                    const SizedBox(height: 40),
                    TextFormField(
                        decoration: InputDecoration(
                          hintText: 'Your Password',
                          labelText: '비밀번호',
                        ),
                        keyboardType: TextInputType.name,
                        controller: passwordController,
                        validator: (value) {
                          if ((value?.length)! < 1) {
                            return "값을 입력하세요";
                          }
                          return null;
                        }
                    ),
                    const SizedBox(height: 40),
                    TextFormField(
                        decoration: InputDecoration(
                          hintText: 'IMAP Server',
                          labelText: 'IMAP 서버',
                        ),
                        keyboardType: TextInputType.name,
                        controller: imapController,
                        validator: (value) {
                          if ((value?.length)! < 1) {
                            return "값을 입력하세요";
                          }
                          return null;
                        }
                    ),
                    const SizedBox(height: 40),
                    TextFormField(
                        decoration: InputDecoration(
                          hintText: 'PORT',
                          labelText: '포트',
                        ),
                        keyboardType: TextInputType.name,
                        controller: portController,
                        validator: (value) {
                          if ((value?.length)! < 1) {
                            return "값을 입력하세요";
                          }
                          return null;
                        }
                    ),
              ]),
            ),
          ),
    )],
      ),
    );
  }
}
