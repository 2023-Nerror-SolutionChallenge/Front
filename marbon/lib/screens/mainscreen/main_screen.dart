import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:percent_indicator/percent_indicator.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);


  @override
  _MainScreenState createState() => _MainScreenState();
}


class _MainScreenState extends State<MainScreen>{
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CircularPercentIndicator(
                animation: true,
                animationDuration: 10000,
                radius: 200,
                lineWidth: 15,
                percent: 0.8,
                progressColor: Color(0xff5C823D),
                backgroundColor: Color(0xffC4C78C),
                circularStrokeCap: CircularStrokeCap.round,
              ),
              LinearPercentIndicator(
                animation: true,
                animationDuration: 10000,
                lineHeight: 30,
                percent: 0.8,
                progressColor: Color(0xff369C33),
                backgroundColor: Color(0xffD0D0D0),
              )


            ],
          ),
        ),
      ),
    );


  }

}