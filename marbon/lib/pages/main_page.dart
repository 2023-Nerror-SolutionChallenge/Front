import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget{
  const MainPage ({Key? key}) : super (key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage>{
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
              height: 500,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(10)),

              ),
              child: Column(
                children: [
                  Text(
                    "",
                    style: TextStyle(
                    fontSize: 18,
                    fontWeight:FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 200),
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(
                          width: 2,),

                    ),
                    child: Row(
                      children: [
                        SizedBox(height: 20, width: 20)
                      ],
                    ),

                  )
                ],
              ),
            )
          )],
      ),
    );
  }

}


