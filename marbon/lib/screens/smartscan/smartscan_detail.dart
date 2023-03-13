import 'package:flutter/material.dart';
import 'package:marbon/size.dart';

import '../../color.dart';
import '../../models/mail_category.dart';

class SmartScanDetail extends StatefulWidget {
  const SmartScanDetail({super.key});

  @override
  State<SmartScanDetail> createState() => _SmartScanDetailState();
}

class _SmartScanDetailState extends State<SmartScanDetail> {
  final List<MailCategory> _mails = generateMailCategory(jsonMailData);
  final int mailCount = 100; // mails lenth 만큼 반복하면서 _mails.
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
              onPressed: () {
                //체크박스 전부 취소되도록
              },
              icon: const Icon(Icons.cancel_presentation_outlined)),
          IconButton(
              // 선택 삭제
              onPressed: () {
                Navigator.pushNamed(context, "/smartscan_delete");
              },
              icon: const Icon(Icons.check_box_outlined)),
          IconButton(
              // 전체 삭제
              onPressed: () {
                Navigator.pushNamed(context, "/smartscan_delete");
              },
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
            color: yellow_color,
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
            child: SingleChildScrollView(
              child: Container(
                child: _buildExpansionPanel(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExpansionPanel() {
    int index = 0;

    return ExpansionPanelList(
      expansionCallback: (int index, bool isExpanded) {
        setState(() {
          _mails[index].isExpanded = !isExpanded;
        });
      },
      children: _mails.map<ExpansionPanel>((MailCategory mailCategory) {
        index += 1;
        return ExpansionPanel(
          headerBuilder: (BuildContext context, bool isExpanded) {
            return Column(
              children: [
                Container(
                  // 위쪽커브
                  color: color_list[index - 1],
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                      color: color_list[index],
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(50.0),
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 50,
                  color: color_list[index],
                  padding: const EdgeInsets.only(left: 10, right: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        children: [
                          //체크박스자리
                          Text(
                            mailCategory.category!,
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
                          mailCategory.mailamount.toString(), // 메일 총 갯수
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              color: text_green_color,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  // 아랫쪽커브
                  color: color_list[index > _mails.length ? index + 1 : index],
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                      color: color_list[index],
                      borderRadius: const BorderRadius.only(
                        bottomRight: Radius.circular(50.0),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
          body: Container(
              // 받은 색상으로 해야함
              color: color_list[index],
              height: mail_list_height * 4,
              child: ListView(
                scrollDirection: Axis.vertical,
                // mailCategory.mails 는 리스트이고 이걸 반복하면서 mailitem에 넣어야함
                children:
                    mailCategory.mails!.map((m) => _buildMailItem(m)).toList(),
              )),
          isExpanded: mailCategory.isExpanded,
          canTapOnHeader: true,
        );
      }).toList(),
    );
  }

  // 카테고리별 메일내용
  Widget _buildMailItem(Mails mails) {
    return Container(
      height: mail_list_height,
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: [
              // 체크박스 추가해야함
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      mails.author!,
                      style: const TextStyle(
                        fontSize: 15,
                        color: text_green_color,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(mails.title!,
                        style: const TextStyle(
                          fontSize: 15,
                          color: text_green_color,
                        ),
                        overflow: TextOverflow.ellipsis),
                    Text(mails.content!,
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

// json mail data 임시
List<dynamic> jsonMailData = [
  {
    "category": "promotion",
    "mailamount": 999,
    "mails": [
      {
        "id": 1,
        "author": "WISET",
        "title": "네이버페이와 삼성페이가 손잡을 줄이야",
        "content": "안녕하세요, 요즘IT입니다. 👋"
      },
      {
        "id": 2,
        "author": "GDSC Event Platform",
        "title": "You're now registered for GDSC Sookmyung 10분 세미나 ",
        "content":
            "You have successfully registered for GDSC Sookmyung 10분 세미나 + 팀별 "
      },
      {
        "id": 3,
        "author": "프로그래머스",
        "title": "[프로그래머스] 이용약관 개정 안내",
        "content": "안녕하세요, 프로그래머스입니다."
      },
      {
        "id": 4,
        "author": "GitKraken",
        "title": "Only a few days left in your GitKraken Client trial!",
        "content":
            "Enjoying the GitKraken Client trial? Consider exploring these features next:"
      }
    ]
  },
  {
    "category": "SNS",
    "mailamount": 104,
    "mails": [
      {
        "id": 5,
        "author": "WISET",
        "title": "네이버페이와 삼성페이가 손잡을 줄이야",
        "content": "안녕하세요, 요즘IT입니다. 👋"
      },
      {
        "id": 6,
        "author": "GDSC Event Platform",
        "title": "You're now registered for GDSC Sookmyung 10분 세미나 ",
        "content":
            "You have successfully registered for GDSC Sookmyung 10분 세미나 + 팀별 "
      },
      {
        "id": 7,
        "author": "프로그래머스",
        "title": "[프로그래머스] 이용약관 개정 안내",
        "content": "안녕하세요, 프로그래머스입니다."
      },
      {
        "id": 8,
        "author": "GitKraken",
        "title": "Only a few days left in your GitKraken Client trial!",
        "content":
            "Enjoying the GitKraken Client trial? Consider exploring these features next:"
      }
    ]
  },
  {
    "category": "bill payment",
    "mailamount": 88,
    "mails": [
      {
        "id": 9,
        "author": "WISET",
        "title": "네이버페이와 삼성페이가 손잡을 줄이야",
        "content": "안녕하세요, 요즘IT입니다. 👋"
      },
      {
        "id": 10,
        "author": "GDSC Event Platform",
        "title": "You're now registered for GDSC Sookmyung 10분 세미나 ",
        "content":
            "You have successfully registered for GDSC Sookmyung 10분 세미나 + 팀별 "
      },
      {
        "id": 11,
        "author": "프로그래머스",
        "title": "[프로그래머스] 이용약관 개정 안내",
        "content": "안녕하세요, 프로그래머스입니다."
      },
      {
        "id": 12,
        "author": "GitKraken",
        "title": "Only a few days left in your GitKraken Client trial!",
        "content":
            "Enjoying the GitKraken Client trial? Consider exploring these features next:"
      }
    ]
  },
  {
    "category": "From pinterest",
    "mailamount": 21,
    "mails": [
      {
        "id": 13,
        "author": "WISET",
        "title": "네이버페이와 삼성페이가 손잡을 줄이야",
        "content": "안녕하세요, 요즘IT입니다. 👋"
      },
      {
        "id": 14,
        "author": "GDSC Event Platform",
        "title": "You're now registered for GDSC Sookmyung 10분 세미나 ",
        "content":
            "You have successfully registered for GDSC Sookmyung 10분 세미나 + 팀별 "
      },
      {
        "id": 15,
        "author": "프로그래머스",
        "title": "[프로그래머스] 이용약관 개정 안내",
        "content": "안녕하세요, 프로그래머스입니다."
      },
      {
        "id": 16,
        "author": "GitKraken",
        "title": "Only a few days left in your GitKraken Client trial!",
        "content":
            "Enjoying the GitKraken Client trial? Consider exploring these features next:"
      }
    ]
  }
];

// json 형태의 자료를 mailCategory 모델로 변환
List<MailCategory> generateMailCategory(List<dynamic> mailDatas) {
  List<MailCategory> mailCategories = [];

  for (var mailData in mailDatas) {
    // json을 웹툰 인스턴스로 만들어주는 코드
    mailCategories.add(MailCategory.fromJson(mailData));
  }
  return mailCategories;
}
