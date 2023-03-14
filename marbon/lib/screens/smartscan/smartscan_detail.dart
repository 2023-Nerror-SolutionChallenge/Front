import 'package:flutter/material.dart';
import 'package:marbon/size.dart';
import 'package:provider/provider.dart';

import '../../color.dart';
import '../../models/mail_category.dart';

class SmartScanDetail extends StatefulWidget {
  const SmartScanDetail({super.key});

  @override
  State<SmartScanDetail> createState() => _SmartScanDetailState();
}

class _SmartScanDetailState extends State<SmartScanDetail> {
  final List<MailCategory> _mails = generateMailCategory(jsonMailData);
  int mailCount = 0;

  @override
  void initState() {
    // 초기에 메일갯수 셈
    super.initState();
    for (int i = 0; i < _mails.length; i++) {
      mailCount += _mails.elementAt(i).mails!.length;
    }
  }

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
                setState(() {
                  // 카테고리 안의 메일들을 하나씩 돌면서 모두 추가
                  for (int i = 0; i < _mails.length; i++) {
                    for (int j = 0;
                        j < _mails.elementAt(i).mails!.length;
                        j++) {
                      _mails.elementAt(i).mails!.elementAt(j).isChecked = false;
                    }
                    _mails.elementAt(i).isChecked = false;
                  }
                  context.read<Checks>().clearItem();
                });
              },
              icon: const Icon(Icons.cancel_presentation_outlined)),
          IconButton(
              // 선택 삭제
              onPressed: () {
                //  context.read<Checks> 에 있는 값들 삭제요청 보낸 후 안의 data값 삭제

                Navigator.pushNamed(context, "/smartscan_delete");
              },
              icon: const Icon(Icons.check_box_outlined)),
          IconButton(
              // 전체 삭제
              onPressed: () {
                setState(() {
                  // 카테고리 안의 메일들을 하나씩 돌면서 모두 추가
                  for (int i = 0; i < _mails.length; i++) {
                    for (int j = 0;
                        j < _mails.elementAt(i).mails!.length;
                        j++) {
                      var newMail =
                          Mails(id: _mails.elementAt(i).mails!.elementAt(j).id);
                      context.read<Checks>().addItem(newMail);
                    }
                  }
                });

                // 해당값들 모두 삭제해달라고 요청 보낸후  context.read<Checks> 의 data 모두 삭제

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
    int headerIndex = 0;
    int contentIndex = 0;

    return ExpansionPanelList(
      // ExpansionPanel의 gap을 줄이기 위함 (위쪽gap)
      expandedHeaderPadding: const EdgeInsets.only(
        bottom: 1,
      ),
      expansionCallback: (int index, bool isExpanded) {
        setState(() {
          _mails[index].isExpanded = !isExpanded;
        });
      },
      children: _mails.map<ExpansionPanel>((MailCategory mailCategory) {
        contentIndex += 1;
        return ExpansionPanel(
          headerBuilder: (BuildContext context, bool isExpanded) {
            headerIndex += 1;
            return Column(
              children: [
                Container(
                  // 위쪽커브
                  color: color_list[headerIndex - 1],
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                      color: color_list[headerIndex],
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(50.0),
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 50,
                  color: color_list[headerIndex],
                  padding: const EdgeInsets.only(left: 10, right: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        children: [
                          Checkbox(
                              value: mailCategory.isChecked,
                              onChanged: (value) {
                                setState(() {
                                  // 체크여부 변동
                                  mailCategory.isChecked = value!;

                                  // 체크상태 업데이트
                                  if (mailCategory.isChecked) {
                                    //카테고리 전체선택
                                    for (int i = 0;
                                        i < mailCategory.mails!.length;
                                        i++) {
                                      var newMail = Mails(
                                          id: mailCategory.mails!
                                              .elementAt(i)
                                              .id);
                                      context.read<Checks>().addItem(newMail);
                                      mailCategory.mails!
                                          .elementAt(i)
                                          .isChecked = true;
                                    }
                                  } else {
                                    for (int i = 0;
                                        i < mailCategory.mails!.length;
                                        i++) {
                                      context.read<Checks>().removeItem(
                                          mailCategory.mails!.elementAt(i).id);
                                      mailCategory.mails!
                                          .elementAt(i)
                                          .isChecked = false;
                                    }
                                  }
                                });
                              }),
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
                          mailCategory.mails!.length.toString(), // 메일 총 갯수
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
                  color: color_list[headerIndex < _mails.length
                      ? headerIndex + 1
                      : headerIndex],
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                      color: color_list[headerIndex],
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
              color: color_list[contentIndex],
              height: mail_list_height * 4,
              child: ListView(
                scrollDirection: Axis.vertical,
                // mailCategory.mails 는 리스트이고 이걸 반복하면서 mailitem에 넣어야함
                children: mailCategory.mails!
                    .map((m) => _buildMailItem(m, mailCategory))
                    .toList(),
              )),
          isExpanded: mailCategory.isExpanded,
          canTapOnHeader: true,
        );
      }).toList(),
    );
  }

  // 카테고리별 메일내용
  Widget _buildMailItem(Mails mails, MailCategory mc) {
    return Container(
      height: mail_list_height,
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: [
              Checkbox(
                value: mails.isChecked,
                onChanged: (value) {
                  setState(() {
                    // 체크여부 변동
                    mails.isChecked = value!;

                    // 체크상태 업데이트
                    if (mails.isChecked) {
                      // 해당 메일 체크 및 전체 체크면 카테고리의 체크도 킬 것 & provider의 값 조정
                      var newMail = Mails(id: mails.id);
                      context.read<Checks>().addItem(newMail);
                      var flag = true;
                      for (int i = 0; i < mc.mails!.length; i++) {
                        if (mc.mails!.elementAt(i).isChecked == false) {
                          flag = false;
                          break;
                        }
                      }
                      mc.isChecked = flag ? true : false;
                    } else {
                      // 해당 메일의 체크 끄고 카테고리의 체크도 끌 것  & provider의 값 조정
                      context.read<Checks>().removeItem(mails.id);
                      mc.isChecked = false;
                    }
                  });
                },
              ),
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
      },
      {
        "id": 24,
        "author": "GitKraken",
        "title": "Only a few days left in your GitKraken Client trial!",
        "content":
            "Enjoying the GitKraken Client trial? Consider exploring these features next:"
      },
      {
        "id": 25,
        "author": "GitKraken",
        "title": "Only a few days left in your GitKraken Client trial!",
        "content":
            "Enjoying the GitKraken Client trial? Consider exploring these features next:"
      },
      {
        "id": 26,
        "author": "GitKraken",
        "title": "Only a few days left in your GitKraken Client trial!",
        "content":
            "Enjoying the GitKraken Client trial? Consider exploring these features next:"
      }
    ]
  },
  {
    "category": "SNS",
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
      },
      {
        "id": 100,
        "author": "GitKraken",
        "title": "Only a few days left in your GitKraken Client trial!",
        "content":
            "Enjoying the GitKraken Client trial? Consider exploring these features next:"
      },
      {
        "id": 89,
        "author": "GitKraken",
        "title": "Only a few days left in your GitKraken Client trial!",
        "content":
            "Enjoying the GitKraken Client trial? Consider exploring these features next:"
      }
    ]
  },
  {
    "category": "bill payment",
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

// 메일 체크시 구현되어야 할 기능 구현
class Checks extends ChangeNotifier {
  bool _disposed = false; // 메모리 해제
  List<Mails> data = []; // 생성될 데이터 변수 선언
  List<Mails> get _data => data;

  // 메모리 누수 방지
  @override
  void dispose() {
    _disposed = true;
    super.dispose();
  }

  // 메모리 해제가 아닐시 notifyListeners 호출
  @override
  notifyListeners() {
    if (!_disposed) {
      super.notifyListeners();
    }
  }

  // 메일 선택 추가 (data에 없는 경우만 mail 리스트에 추가)
  void addItem(value) {
    var index = data.indexWhere((item) => item.id == value.id);
    if (index == -1) {
      data.add(value);
      notifyListeners();
    }
  }

  // 메일 선택 해제
  void removeItem(value) {
    data.removeWhere((item) => item.id == value);
    notifyListeners();
  }

  // 메일 선택 전체 해제
  void clearItem() {
    data.clear();
    notifyListeners();
  }
}
