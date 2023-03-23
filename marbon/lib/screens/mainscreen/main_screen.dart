import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constrains) => Center(
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
                progressColor: const Color(0xff5C823D),
                backgroundColor: const Color(0xffC4C78C),
                circularStrokeCap: CircularStrokeCap.round,
              ),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Container(
                  child: const Text("탄소배출감소"),
                ),
                Container(
                  child: const Text("7.624 kg"),
                ),
              ]),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Container(
                  child: const Text("Total"),
                ),
                Container(
                  child: const Text("2016 건"),
                ),
              ]),
              LinearPercentIndicator(
                animation: true,
                animationDuration: 10000,
                lineHeight: 30,
                percent: 0.8,
                progressColor: const Color(0xff369C33),
                backgroundColor: const Color(0xffD0D0D0),
              ),


              Container(
                height: 130,
                width: MediaQuery.of(context).size.width - 20,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                      bottomLeft: Radius.circular(30),
                      topLeft: Radius.circular(30)),
                ),

                child: Container(
                  margin: const EdgeInsets.only(top: 10, left: 10),
                  child: Row(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              const SizedBox(
                                width: 10,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  Text(
                                    "98 %",
                                    style: TextStyle(
                                        fontSize: 30,
                                        color: Color(0xff369C33),
                                        fontWeight: FontWeight.w900),
                                  ),
                                  SizedBox(
                                    height: 7,
                                  ),
                                  Text(
                                    "최대 98%의 메일을 정리할 수 있어요.",
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              Container(
                height: 130,
                width: MediaQuery.of(context).size.width - 20,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                      bottomLeft: Radius.circular(30),
                      topLeft: Radius.circular(30)),
                ),
                child: Container(
                  margin: const EdgeInsets.only(top: 10, left: 10),
                  child: Row(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              const SizedBox(
                                width: 10,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  Text(
                                    "24.195 %",
                                    style: TextStyle(
                                        fontSize: 30,
                                        color: Color(0xff369C33),
                                        fontWeight: FontWeight.w900),
                                  ),
                                  SizedBox(
                                    height: 7,
                                  ),
                                  Text(
                                    "메일을 삭제한 비율이 현재 24.195 % 입니다.",
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              Container(
                height: 130,
                width: MediaQuery.of(context).size.width - 20,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                      bottomLeft: Radius.circular(30),
                      topLeft: Radius.circular(30)),
                ),
                child: Container(
                  margin: const EdgeInsets.only(top: 10, left: 10),
                  child: Row(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              const SizedBox(
                                width: 10,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  Text(
                                    "3024개",
                                    style: TextStyle(
                                        fontSize: 30,
                                        color: Color(0xff369C33),
                                        fontWeight: FontWeight.w900),
                                  ),
                                  SizedBox(
                                    height: 7,
                                  ),
                                  Text(
                                    "총 메일 개수는 3024개 입니다.",
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
