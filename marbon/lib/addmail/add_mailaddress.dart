import 'package:flutter/material.dart';

class AddMailAddressPage extends StatelessWidget {
  const AddMailAddressPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(
        ),
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

          const Text(
            "이메일 주소 ",
            textAlign: TextAlign.start,
            style: TextStyle(
                fontSize: 15,
          ),
          ),
          const SizedBox(
            height: 20,
          ),
          TextFormField(
            decoration: const InputDecoration(
              labelText: "email address"

            ),
          ),
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, "/mail_server");
            },
            icon: const Icon(Icons.check),
            iconSize: 30,
          ),
        ])
    );
  }
}
