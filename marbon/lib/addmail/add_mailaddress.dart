import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../service/api_service.dart';
import '../../widgets/input_field.dart';

class AddMailAddressPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  AddMailAddressPage({super.key});
  renderTextFormField({
    required String label,
    required FormFieldSetter onSaved,
    required FormFieldValidator validator,

  }) {
    assert(onSaved != null);
    assert(validator != null);

    return Column(
      children: [
        Row(
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 12.0,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        TextFormField(
          onSaved: onSaved,
          validator: validator,
        ),
      ],
    );
  }

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
        "이메일 주소 추가",
        textAlign: TextAlign.center,
        style: TextStyle(
            fontSize: 35,
            fontWeight: FontWeight.bold),
      ),
      const SizedBox(
        height: 20,
      ),
      Container(width: 500,
          child: Divider(color: Colors.black, thickness: 3.0)),

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

          const SizedBox(
            height: 50,
          ),
          const SizedBox(
            height: 20,
          ),


          Form(
              key: this._formKey,
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  children: [
                  renderTextFormField(
                  label: 'Email Address',
                  onSaved: (val) {},
                  validator: (val) {
                    return null;
                  },
                ),
    ],
    ),
              ),
    ),

    ])
    );
  }

}


class EmailAddController extends GetxController{
  List<String> _email = [];
  get email => _email;

  void upadateEmail(
      {
        required List<String> email
      }) {

    _email = email;
  }

}

// Get.find<EmailAddController>().upadateEmail(
// email: returnData["email"],
// );