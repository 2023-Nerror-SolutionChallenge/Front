import 'package:flutter/material.dart';
import 'package:marbon/size.dart';

import '../../color.dart';

class SmartScanDetail extends StatelessWidget {
  const SmartScanDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 40,
        shadowColor: transparent_color,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(
          color: text_green_color,
        ),
        actions: <Widget>[
          IconButton(
              // 선택 전부 취소
              onPressed: () {},
              icon: const Icon(Icons.cancel_presentation_outlined)),
          IconButton(
              // 선택 삭제
              onPressed: () {},
              icon: const Icon(Icons.check_box_outlined)),
          IconButton(
              // 전체 삭제
              onPressed: () {},
              icon: const Icon(Icons.delete_forever)),
        ],
      ),
      body: Column(
        children: [
          Container(
            height: 110,
            width: double.infinity, // 주지않으면 텍스트의 크기와 동일해짐
            padding: const EdgeInsets.only(
              top: 40,
              left: smartscan_title_left,
            ),
            color: Colors.white,
            child: const Text(
              "Smartscan",
              style: TextStyle(
                color: text_green_color,
                fontSize: 35,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Container(
            color: const Color(0xffFFE8A6),
            child: Container(
              height: 50,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(50.0),
                ),
              ),
            ),
          ),
          Expanded(
            // Vertical viewport was given unbounded height error 방지
            child: ListView(
              scrollDirection: Axis.vertical,
              children: const <Widget>[
                CurvedListItem(
                  category: 'Promotion',
                  mailamount: 100,
                  prevColor: Colors.white,
                  color: Color(0xffFFE8A6),
                  nextColor: Color(0xffB6BB6F),
                ),
                CurvedListItem(
                  category: 'SNS',
                  mailamount: 49,
                  prevColor: Color(0xffFFE8A6),
                  color: Color(0xffB6BB6F),
                  nextColor: Color(0xff769A58),
                ),
                CurvedListItem(
                  category: 'Bill Payment',
                  mailamount: 78,
                  prevColor: Color(0xffB6BB6F),
                  color: Color(0xff769A58),
                  nextColor: Color(0xff186235),
                ),
                CurvedListItem(
                  category: 'Pinterest',
                  mailamount: 78,
                  prevColor: Color(0xff769A58),
                  color: Color(0xff186235),
                  nextColor: Color(0xff186235),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CurvedListItem extends StatelessWidget {
  const CurvedListItem({
    super.key,
    required this.category,
    required this.mailamount,
    required this.prevColor,
    required this.color,
    required this.nextColor,
  });

  final String category;
  final int mailamount;
  final Color prevColor;
  final Color color;
  final Color nextColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          // 위쪽커브
          color: prevColor,
          child: Container(
            height: 50,
            decoration: BoxDecoration(
              color: color,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(50.0),
              ),
            ),
          ),
        ),
        Container(
          // 내용
          height: 50,
          color: color,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                category,
                style: const TextStyle(color: Colors.white, fontSize: 12),
              ),
              const SizedBox(
                height: 2,
              ),
              Text(
                mailamount.toString(),
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold),
              ),
              Row(),
            ],
          ),
        ),
        Container(
          // 아랫쪽커브
          color: nextColor,
          child: Container(
            height: 50,
            decoration: BoxDecoration(
              color: color,
              borderRadius: const BorderRadius.only(
                bottomRight: Radius.circular(50.0),
              ),
            ),
          ),
        ),
      ],
    );

    // return Container(
    //   color: nextColor,
    //   child: Container(
    //     decoration: BoxDecoration(
    //       color: color,
    //       borderRadius: const BorderRadius.only(
    //         bottomLeft: Radius.circular(80.0),
    //       ),
    //     ),
    //     padding: const EdgeInsets.only(
    //       left: 32,
    //       top: 80.0,
    //       bottom: 50,
    //     ),
    //     child: Column(
    //         crossAxisAlignment: CrossAxisAlignment.start,
    //         children: <Widget>[
    //           Text(
    //             category,
    //             style: const TextStyle(color: Colors.white, fontSize: 12),
    //           ),
    //           const SizedBox(
    //             height: 2,
    //           ),
    //           Text(
    //             mailamount.toString(),
    //             style: const TextStyle(
    //                 color: Colors.white,
    //                 fontSize: 22,
    //                 fontWeight: FontWeight.bold),
    //           ),
    //           Row(),
    //         ]),
    //   ),
    // );
  }
}
