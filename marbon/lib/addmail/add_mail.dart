 import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddMailPage extends StatelessWidget {
  const AddMailPage({Key? key}) : super(key: key);

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
            "이메일 설정",
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


          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [

                   // ClipRect(
                   //      child:
                   //      Image.asset("assets/img/google.png"),
                   //
                   //  ),

                    Text(
                      "Google",
                      style: TextStyle(fontSize: 17),
                    ),


                  ],
                ),
                IconButton(
                  onPressed: () {
                    Navigator.pushNamed(context, "/add_mailaddress");
                  },
                  icon: const Icon(Icons.navigate_next_outlined),
                  iconSize: 30,
                ),
              ],
            ),

          ),
          Container(width: 500,
              child: Divider(color: Colors.grey, thickness: 1.0)),
          SizedBox(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [

                    Text(
                      "iCloud",
                      style: TextStyle(fontSize: 17),
                    ),
                  ],
                ),
                IconButton(
                  onPressed: () {
                    Navigator.pushNamed(context, "/add_mailaddress");
                  },
                  icon: const Icon(Icons.navigate_next_outlined),
                  iconSize: 30,
                ),
              ],
            ),

          ),
          Container(width: 500,
              child: Divider(color: Colors.grey, thickness: 1.0)),
          SizedBox(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: const [
                    Text(
                      "Naver",
                      style: TextStyle(fontSize: 17),
                    ),
                  ],
                ),
                IconButton(
                  onPressed: () {
                    Navigator.pushNamed(context, "/add_mailaddress");
                  },
                  icon: const Icon(Icons.navigate_next_outlined),
                  iconSize: 30,
                ),
              ],
            ),

          ),
          Container(width: 500,
              child: Divider(color: Colors.grey, thickness: 1.0)),


          SizedBox(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: const [
                    Text(
                      "Daum",
                      style: TextStyle(fontSize: 17),
                    ),
                  ],
                ),
                IconButton(
                  onPressed: () {
                    Navigator.pushNamed(context, "/add_mailaddress");
                  },
                  icon: const Icon(Icons.navigate_next_outlined),
                  iconSize: 30,
                ),
              ],
            ),

          ),
          Container(width: 500,
              child: Divider(color: Colors.grey, thickness: 1.0)),




          SizedBox(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: const [
                    Text(
                      "IMAP",
                      style: TextStyle(fontSize: 17),
                    ),
                  ],
                ),
                IconButton(
                  onPressed: () {
                    Navigator.pushNamed(context, "/add_mailaddress");
                  },
                  icon: const Icon(Icons.navigate_next_outlined),
                  iconSize: 30,
                ),
              ],
            ),

          ),
          Container(width: 500,
              child: Divider(color: Colors.grey, thickness: 1.0)),
        ],
      ),

    );
  }
}

