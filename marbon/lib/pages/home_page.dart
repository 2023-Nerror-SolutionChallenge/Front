import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super (key: key);

  @override
  _HomePageState createState() => _HomePageState();
}
class _HomePageState extends State<HomePage>{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Color(0xffedeedd),
      body:
      Stack(
        children: [
          Positioned(
            top: 100,
            left: 0,
            height: 400,
            child: Container(
              height: 400,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/img/round_mail.png"),
                  fit: BoxFit.cover
                )
              ),
            ),
          ),
          Positioned(
            bottom: 100,
            left: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Mail",
                style: TextStyle(
                  fontSize: 42,
                  color: Colors.black,
                  fontWeight: FontWeight.w700
                ),),
                Text("Cleaner",
                style: TextStyle(
                  fontSize: 42,
                  color: Colors.black,
                  fontWeight: FontWeight.w400
                ),),
                Text("By deleting unnecessary emails",
                  style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey,
                      fontWeight: FontWeight.w500
                  ),),
                Text("Shall we reduce our digital",
                  style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey,
                      fontWeight: FontWeight.w500
                  ),),

                Text("carbon footprint?",
                  style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey,
                      fontWeight: FontWeight.w500
                  ),),

                SizedBox(height: 40,),
                Container(
                  width: 150,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(90),
                    color: Color(0xffffffff)
                  ),

                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      primary: Color(0xffffffff),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(90.0),

                      ),),
                    onPressed: ()=>Container(),
                    child: Text(
                      "Get Statred",
                      style: TextStyle(
                        color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w700
                      ),
                    ),
                  ),
                )
              ],
            )

          )
        ],
      ),
    );
  }

}


