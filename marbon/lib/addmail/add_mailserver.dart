import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../service/api_service.dart';
import '../../widgets/input_field.dart';
class AddMailServerPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  AddMailServerPage({super.key});

  @override
  Widget build(BuildContext context) {
    final arguments = (ModalRoute.of(context)?.settings.arguments ??
        <String, dynamic>{}) as Map;
    final String authCode = arguments["code"];
    final String email = arguments["email"];

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          iconTheme: const IconThemeData(
          ),
          actions: <Widget>[
            IconButton(

              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  String authCode = await ApiService()
                      .postEmail(emailController.text.toString());
                  Navigator.pushNamed(
                    context,
                    "/mail_server",
                    arguments: {
                      "code": authCode,
                      "email": emailController.text.toString(),
                    },
                  );
                }
              },
              icon: const Icon(Icons.check),
              iconSize: 30,
            ),

          ],
        ),
        body:
        ListView(
            children: [
              Positioned(
                top: 100,
                left: 0,
                height: 400,
                child: Container(
                  height: 200,
                  width: MediaQuery
                      .of(context)
                      .size
                      .width,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/img/mail.png"),
                          fit: BoxFit.none)),
                ),
              ),
              const Text(
                "수신 서버 설정",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 5,
              ),
              Container(width: 500,
                  child: Divider(color: Colors.black, thickness: 3.0)),
              const SizedBox(
                height: 30,
              ),

              SizedBox(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: const [
                        Text(
                          "Google",
                          style: TextStyle(fontSize: 27),
                        ),
                      ],
                    ),
                  ],
                ),

              ),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    InputField("Your Username", "username", emailController),
                  ],
                ),
              ),

              Form(
                key: _formKey,
                child: Column(
                  children: [
                    InputField("Your Password", "username", emailController),
                  ],
                ),
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    InputField("IMAP Server", "username", emailController),
                  ],
                ),
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    InputField("Port", "username", emailController),
                  ],
                ),
              ),

            ])


    );
  }
}

class EmailAddController extends GetxController{
  String _id = "";
  String _username = "";
  String _pw = "";
  String _host = "";
  String _port = "";

  List<String> _email = [];
  get email => _email;
  get id => _id;
  get pw => _pw;
  get username => _username;
  get host => _host;
  get port => _port;

  void upadateEmail(
      {
        required String id,
        required String username,
        required String host,
        required String port,
        required List<String> email,

      }) {

    _id = id;
    _username = username;
    _pw = pw;
    _host = host;
    _port = port;
  }
}
