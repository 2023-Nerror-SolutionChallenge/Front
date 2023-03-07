import 'package:flutter/material.dart';
import 'package:marbon/size.dart';

import '../../color.dart';

class SmartScanDetail extends StatelessWidget {
  const SmartScanDetail({super.key});

  @override
  Widget build(BuildContext context) {
    int mailCount = 100;

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
            height: 120,
            width: double.infinity, // 주지않으면 텍스트의 크기와 동일해짐
            padding: const EdgeInsets.only(
              top: 40,
              left: smartscan_title_left,
            ),
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Smartscan",
                  style: TextStyle(
                    color: text_green_color,
                    fontSize: 35,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Text(
                  "총 $mailCount건의 메일이 발견되었습니다.",
                  style: const TextStyle(
                    color: text_green_color,
                    fontSize: 18,
                  ),
                ),
              ],
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
            child: ScrollConfiguration(
              behavior: const ScrollBehavior()
                  .copyWith(overscroll: false), // 위로 스크롤 금지하도록 하는게 나을듯
              child: ListView(
                scrollDirection: Axis.vertical,
                children: const <Widget>[
                  CurvedListItem(
                    category: 'Promotion',
                    mailamount: 9999,
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
          ),
        ],
      ),
    );
  }
}

class CurvedListItem extends StatefulWidget {
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
  State<CurvedListItem> createState() => _CurvedListItemState();
}

class _CurvedListItemState extends State<CurvedListItem> {
  @override
  Widget build(BuildContext context) {
    bool isAllChecked = false;
    bool panelActive = false;

    return Column(
      children: [
        Container(
          // 위쪽커브
          color: widget.prevColor,
          child: Container(
            height: 50,
            decoration: BoxDecoration(
              color: widget.color,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(50.0),
              ),
            ),
          ),
        ),
        // 접힘대상
        ExpansionPanelList(
          expansionCallback: (panelIndex, isExpanded) {
            panelActive = !panelActive;
            setState(() {
              print(panelIndex);
            });
          },
          children: <ExpansionPanel>[
            // 기준 panel
            ExpansionPanel(
              isExpanded: panelActive, // 인덱스가 안먹혀서 그런듯
              canTapOnHeader: true,
              headerBuilder: (context, isExpanded) {
                return Container(
                  height: 50,
                  color: widget.color,
                  padding: const EdgeInsets.only(left: 10, right: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        children: [
                          Checkbox(
                            side: const BorderSide(
                              color: text_green_color,
                            ),
                            value: isAllChecked,
                            checkColor: text_green_color,
                            onChanged: (bool? value) {
                              setState(
                                () {
                                  isAllChecked = value!;
                                },
                              );
                            },
                          ),
                          Text(
                            widget.category,
                            style: const TextStyle(
                                color: text_green_color,
                                fontSize: 25,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 70,
                        child: Text(
                          widget.mailamount.toString(),
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              color: text_green_color,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                );
              },
              // 펼쳐질 panel
              body: Container(
                color: widget.color,
                height: mail_list_height * 4,
                child: ListView(
                  scrollDirection: Axis.vertical,
                  children: const [
                    MailListItem(
                        sender: "헬로 인프런",
                        title: "(광고) 사이드 프로젝트로 돌멩이 키우는 개발자가 있다?",
                        content: "키드위님, 안녕하세요! 인프런 콘텐츠 에디터 아셀입니다."),
                    MailListItem(
                        sender: "헬로 인프런",
                        title: "(광고) 사이드 프로젝트로 돌멩이 키우는 개발자가 있다?",
                        content: "키드위님, 안녕하세요! 인프런 콘텐츠 에디터 아셀입니다."),
                    MailListItem(
                        sender: "헬로 인프런",
                        title: "(광고) 사이드 프로젝트로 돌멩이 키우는 개발자가 있다?",
                        content: "키드위님, 안녕하세요! 인프런 콘텐츠 에디터 아셀입니다."),
                  ],
                ),
              ),
            ),
          ],
        ),
        Container(
          // 아랫쪽커브
          color: widget.nextColor,
          child: Container(
            height: 50,
            decoration: BoxDecoration(
              color: widget.color,
              borderRadius: const BorderRadius.only(
                bottomRight: Radius.circular(50.0),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class MailListItem extends StatefulWidget {
  const MailListItem(
      {super.key,
      required this.sender,
      required this.title,
      required this.content});

  final String sender;
  final String title;
  final String content;

  @override
  State<MailListItem> createState() => _MailListItemState();
}

class _MailListItemState extends State<MailListItem> {
  @override
  Widget build(BuildContext context) {
    bool isChecked = false;

    return Container(
      height: mail_list_height,
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: [
              Checkbox(
                side: const BorderSide(
                  color: text_green_color,
                ),
                value: isChecked,
                checkColor: text_green_color,
                onChanged: (bool? value) {
                  setState(
                    () {
                      isChecked = value!;
                    },
                  );
                },
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.sender,
                      style: const TextStyle(
                        fontSize: 15,
                        color: text_green_color,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(widget.title,
                        style: const TextStyle(
                          fontSize: 15,
                          color: text_green_color,
                        ),
                        overflow: TextOverflow.ellipsis),
                    Text(widget.content,
                        style: const TextStyle(
                          fontSize: 15,
                          color: placeholder_color,
                        ),
                        overflow: TextOverflow.ellipsis),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
