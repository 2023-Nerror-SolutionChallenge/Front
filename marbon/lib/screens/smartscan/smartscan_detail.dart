import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:marbon/size.dart';
import 'package:provider/provider.dart';

import '../../color.dart';
import '../../controller/userController.dart';
import '../../models/mail_category.dart';

class SmartScanDetail extends StatefulWidget {
  const SmartScanDetail({super.key});

  @override
  State<SmartScanDetail> createState() => _SmartScanDetailState();
}

var logger = Logger();

class _SmartScanDetailState extends State<SmartScanDetail> {
  // smartsan에서 인자로 보낸 mailcategorys 를 mail이라고 할것임
  final List<MailCategory> _mails = generateMailCategory(jsonMailData1);
  final List<dynamic> accounts = Get.find<UserController>().mailAccounts;

  @override
  void initState() {
    context.read<Checks>().settingMap(accounts);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final arguments = (ModalRoute.of(context)?.settings.arguments ??
        <String, dynamic>{}) as Map; // _mails에 arguments["mails"]넣어서 해야할것
    //final List<MailCategory> _mails = arguments["mails"];
    int mailCount = 0;
    for (int i = 0; i < _mails.length; i++) {
      mailCount += _mails.elementAt(i).mails!.length;
    }

    //final String mails = arguments["mails"];  // 스마트스캔 결과임  _mails에 해당함
    final List<MailCategory> mails = generateMailCategory(jsonMailData1);

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
                  for (int i = 0; i < mails.length; i++) {
                    for (int j = 0; j < mails.elementAt(i).mails!.length; j++) {
                      mails.elementAt(i).mails!.elementAt(j).isChecked = false;
                    }
                    mails.elementAt(i).isChecked = false;
                  }
                  context.read<Checks>().settingMap(accounts);
                  logger.d(context.read<Checks>()._data);
                });
              },
              icon: const Icon(Icons.cancel_presentation_outlined)),
          IconButton(
              // 선택 삭제
              onPressed: () {
                //  context.read<Checks> 에 있는 값들 삭제요청 보낸 후 안의 data값 삭제
                logger.d("@@@ ${context.read<Checks>()._data}");
                Navigator.pushNamed(context, "/smartscan_delete",
                    arguments: {"deleteData": context.read<Checks>()._data});
              },
              icon: const Icon(Icons.check_box_outlined)),
          IconButton(
              // 전체 삭제
              onPressed: () {
                setState(() {
                  // 카테고리 안의 메일들을 하나씩 돌면서 모두 추가
                  for (int i = 0; i < mails.length; i++) {
                    for (int j = 0; j < mails.elementAt(i).mails!.length; j++) {
                      context.read<Checks>().addItem(
                          mails.elementAt(i).mails!.elementAt(j).username,
                          mails.elementAt(i).mails!.elementAt(j).id);
                    }
                  }
                });

                // 해당값들 모두 삭제해달라고 요청 보낸후  context.read<Checks> 의 data 모두 삭제
                logger.d(context.read<Checks>()._data);

                Navigator.pushNamed(context, "/smartscan_delete",
                    arguments: {"deleteData": context.read<Checks>()._data});
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
                child: Column(
                  children: [
                    _buildExpansionPanel(),
                    Container(
                      // 위쪽커브
                      color: color_list[3],
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                          color: color_list[4],
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(50.0),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      color: color_list[4],
                      height: 90,
                    )
                  ],
                ),
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
                                      context.read<Checks>().addItem(
                                            mailCategory.mails!
                                                .elementAt(i)
                                                .username,
                                            mailCategory.mails!.elementAt(i).id,
                                          );
                                      mailCategory.mails!
                                          .elementAt(i)
                                          .isChecked = true;
                                    }
                                  } else {
                                    // 메일 카테고리 전체 삭제
                                    for (int i = 0;
                                        i < mailCategory.mails!.length;
                                        i++) {
                                      context.read<Checks>().removeItem(
                                            mailCategory.mails!
                                                .elementAt(i)
                                                .username,
                                            mailCategory.mails!.elementAt(i).id,
                                          );
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
                  color: color_list[headerIndex + 1],
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
                      logger.d("${mails.id} ${mails.username}");
                      // 해당 메일 체크 및 전체 체크면 카테고리의 체크도 킬 것 & provider의 값 조정
                      context.read<Checks>().addItem(mails.username, mails.id);
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
                      context
                          .read<Checks>()
                          .removeItem(mails.username, mails.id);
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
                      mails.sender,
                      style: const TextStyle(
                        fontSize: 15,
                        color: text_green_color,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(mails.subject,
                        style: const TextStyle(
                          fontSize: 15,
                          color: text_green_color,
                        ),
                        overflow: TextOverflow.ellipsis),
                    Text(mails.contents,
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
List<dynamic> jsonMailData1 = [
  {
    "category": "payment",
    "removableMailList": [
      {
        "id": 2,
        "msgNum": 2,
        "msgId": 0,
        "subject": "보안 알림",
        "sender": "Google <no-reply@accounts.google.com>",
        "contents":
            "<!DOCTYPE html>.awl a {color: #FFFFFF; text-decoration: none;} .abml a {color: #000000; font-family: Roboto-Medium,Helvetica,Arial,sans-serif; font-weight: bold; text-decoration: none;} .adgl a {color: rgba(0, 0, 0, 0.87); text-decoration: none;} .afal a {color: #b0b0b0; text-decoration: none;} @media screen and (min-width: 600px) {.v2sp {padding: 6px 30px 0px;} .v2rsp {padding: 0px 10px;}} @media screen and (min-width: 600px) {.mdv2rw {padding: 40px 40px;}} <div itemscope itemtype=\"//schema.org/EmailMessage\">2단계 인증을 위한 전화번호가 추가되었습니다 marbonkr@gmail.com 계정 로그인을 위한 코드가 이제 새 전화번호로 전송됩니다. 내가 전화번호를 추가하지 않았다면 다른 사람이 내 계정을 사용하는 것일 수 있습니다. 지금 계정 보안을 점검하고 강화하세요.활동 확인다음 페이지에서 보안 활동도 확인할 수 있습니다.https://myaccount.google.com/notifications이 이메일은 Google 계정 및 서비스의 중요한 변경사항을 알려드리기 위해 발송되었습니다.&copy; 2023 Google LLC, 1600 Amphitheatre Parkway, Mountain View, CA 94043, USA",
        "receivedDate": "2023-02-19T03:52:23.000+00:00",
        "attachmentSize": 0,
        "attachments": [],
        "tag": "payment",
        "username": "yundabin0608@naver.com"
      },
      {
        "id": 3,
        "msgNum": 3,
        "msgId": 0,
        "subject": "2단계 인증이 사용 설정됨",
        "sender": "Google <no-reply@accounts.google.com>",
        "contents":
            "<!DOCTYPE html>.awl a {color: #FFFFFF; text-decoration: none;} .abml a {color: #000000; font-family: Roboto-Medium,Helvetica,Arial,sans-serif; font-weight: bold; text-decoration: none;} .adgl a {color: rgba(0, 0, 0, 0.87); text-decoration: none;} .afal a {color: #b0b0b0; text-decoration: none;} @media screen and (min-width: 600px) {.v2sp {padding: 6px 30px 0px;} .v2rsp {padding: 0px 10px;}} @media screen and (min-width: 600px) {.mdv2rw {padding: 40px 40px;}} <div itemscope itemtype=\"//schema.org/EmailMessage\">2단계 인증이 사용 설정됨 marbonkr@gmail.com 내 Google 계정(marbonkr@gmail.com)이 이제 2단계 인증으로 보호됩니다. 새로운 기기나 신뢰할 수 없는 기기에서 로그인하시는 경우 두 번째 인증 수단으로 본인 확인을 해야 합니다.계정에 액세스하지 못할 경우에 대비하세요두 번째 인증 수단이 없을 때 사용할 백업 전화번호를 추가하시거나 백업 코드를 받으실 수 있습니다.설정을 변경하시려면 2단계 인증 설정을 검토하세요.다음 페이지에서 보안 활동도 확인할 수 있습니다.https://myaccount.google.com/notifications이 이메일은 Google 계정 및 서비스의 중요한 변경사항을 알려드리기 위해 발송되었습니다.&copy; 2023 Google LLC, 1600 Amphitheatre Parkway, Mountain View, CA 94043, USA",
        "receivedDate": "2023-02-19T03:52:25.000+00:00",
        "attachmentSize": 0,
        "attachments": [],
        "tag": "payment",
        "username": "yundabin0608@naver.com"
      },
      {
        "id": 4,
        "msgNum": 4,
        "msgId": 0,
        "subject": "보안 알림",
        "sender": "Google <no-reply@accounts.google.com>",
        "contents":
            "<!DOCTYPE html>.awl a {color: #FFFFFF; text-decoration: none;} .abml a {color: #000000; font-family: Roboto-Medium,Helvetica,Arial,sans-serif; font-weight: bold; text-decoration: none;} .adgl a {color: rgba(0, 0, 0, 0.87); text-decoration: none;} .afal a {color: #b0b0b0; text-decoration: none;} @media screen and (min-width: 600px) {.v2sp {padding: 6px 30px 0px;} .v2rsp {padding: 0px 10px;}} @media screen and (min-width: 600px) {.mdv2rw {padding: 40px 40px;}} <div itemscope itemtype=\"//schema.org/EmailMessage\">계정에 로그인하기 위해 만든 앱 비밀번호 marbonkr@gmail.com Mac의 메일에 비밀번호를 생성하지 않았다면 다른 사람이 계정을 사용하는 것일 수 있습니다. 지금 계정 보안을 점검하고 강화하세요.활동 확인다음 페이지에서 보안 활동도 확인할 수 있습니다.https://myaccount.google.com/notifications이 이메일은 Google 계정 및 서비스의 중요한 변경사항을 알려드리기 위해 발송되었습니다.&copy; 2023 Google LLC, 1600 Amphitheatre Parkway, Mountain View, CA 94043, USA",
        "receivedDate": "2023-02-19T03:53:07.000+00:00",
        "attachmentSize": 0,
        "attachments": [],
        "tag": "payment",
        "username": "yundabin0608@naver.com"
      },
      {
        "id": 5,
        "msgNum": 5,
        "msgId": 0,
        "subject": "보안 알림",
        "sender": "Google <no-reply@accounts.google.com>",
        "contents":
            "<!DOCTYPE html>.awl a {color: #FFFFFF; text-decoration: none;} .abml a {color: #000000; font-family: Roboto-Medium,Helvetica,Arial,sans-serif; font-weight: bold; text-decoration: none;} .adgl a {color: rgba(0, 0, 0, 0.87); text-decoration: none;} .afal a {color: #b0b0b0; text-decoration: none;} @media screen and (min-width: 600px) {.v2sp {padding: 6px 30px 0px;} .v2rsp {padding: 0px 10px;}} @media screen and (min-width: 600px) {.mdv2rw {padding: 40px 40px;}} <div itemscope itemtype=\"//schema.org/EmailMessage\">계정에 로그인하기 위해 만든 앱 비밀번호 marbonkr@gmail.com Windows 컴퓨터의 메일에 비밀번호를 생성하지 않았다면 다른 사람이 계정을 사용하는 것일 수 있습니다. 지금 계정 보안을 점검하고 강화하세요.활동 확인다음 페이지에서 보안 활동도 확인할 수 있습니다.https://myaccount.google.com/notifications이 이메일은 Google 계정 및 서비스의 중요한 변경사항을 알려드리기 위해 발송되었습니다.&copy; 2023 Google LLC, 1600 Amphitheatre Parkway, Mountain View, CA 94043, USA",
        "receivedDate": "2023-02-19T03:53:54.000+00:00",
        "attachmentSize": 0,
        "attachments": [],
        "tag": "payment",
        "username": "yundabin0608@naver.com"
      },
      {
        "id": 11,
        "msgNum": 11,
        "msgId": 0,
        "subject": "Google: 세금 정보 변경 완료",
        "sender": "Google Payments <payments-noreply@google.com>",
        "contents":
            "  \r\n\r\n\r\n\r\n\r\n   \r\n \r\n    \r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n \r\n<!doctype html>\r\n<!--- accessibility handle -->\r\n\r\n\r\nGoogle: 세금 정보 변경 완료\r\n\r\n   <meta http-equiv=Content-Type content=\"text/html; charset=UTF-8\">\r\n<!--- accessibility handle -->\r\n        \r\n        \r\n          a {color: #166BDA;}\r\n          #body_container{max-width:600px;}\r\n            \r\n     @media screen and (min-width: 812px) and (max-width: 812px),\r\nscreen and (min-width: 736px) and (max-width: 736px),\r\nscreen and (min-width: 667px) and (max-width: 667px),\r\nscreen and (min-width: 568px) and (max-width: 568px),\r\nscreen and (min-width: 414px) and (max-width: 414px),\r\nscreen and (min-width: 375px) and (max-width: 375px),\r\nscreen and (min-width: 320px) and (max-width: 320px) {\r\n  .body {\r\n    min-width: 100vw !important;\r\n    margin:0px !important; padding:0px !important; \r\n  }\r\n}\r\n\r\n    \r\n\t:root {     color-scheme: light dark;     supported-color-schemes: light dark;   }     \r\n\t@media (prefers-color-scheme: dark ) {   /* Custom Dark Mode Font Colors */   \r\n\t\ttd, span, h1, h2, h3, h4, h5, h6, h7, p, div {     \r\n\t\tcolor: #bfbfbf !important;}\r\n      .dark_headline{color:#1A73E8 !important;}\r\n      .dark_link_color{color:#166BDA !important;}\r\n\t\tdiv, table, td { background-color: transparent !important;  }\r\n  \t\ttable.cart_bg{background-color:#444444 !important;}\r\n\t\tbody { background-color: #202124 !important; }\r\n  \t\t\t.footer_wrapper{background-color:#202124 !important;}\r\n      .darkmode_fix_datacard{background-color:#292b2c !important; border-bottom:1px solid #333537 !important;}\r\n      .link_fixNative{color:#bfbfbf !important;}\r\n      .header_dm_fix{background-color: transparent !important;}\r\n\t\t}\r\n\t\r\n    \r\n    \r\n\r\n  \r\n<!--- accessibility handle -->  \r\n\r\n<!--- accessibility handle -->\r\n\r\n\r\n<!--- accessibility handle -->  \r\n  \r\n<!--- accessibility handle --> \r\n\r\n  \r\n      \t\r\n  \r\n   \r\n \r\n\r\n\r\n\r\n<!--- accessibility handle -->\r\n  \r\n<!--- accessibility handle -->\r\n\r\n\r\n\r\n  \r\n     세금 정보 변경 완료\r\n  \r\n  \r\n    2023년 3월 7일에 Google용 세금 정보가 변경되었습니다.\r\n  \r\n  \r\n    보안을 위해 변경을 직접 승인하지 않은 경우 저희에게 연락해 주세요.\r\n  \r\n  \r\n    세금 정보 검토 방법은 다음과 같습니다.\r\n  \r\n\r\n\r\n \r\n  \r\n    pay.google.com에서 결제 프로필을 관리하세요.\r\n  \r\n\r\n   \r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n     \r\n\r\n\r\n\r\n    \r\n       고객센터\r\n     \r\n    \r\n       문의하기\r\n     \r\n  \r\n  \r\n  \r\n\r\n  \r\n    결제 프로필 ID:  3489-2802-5014  \r\n  \r\n  \r\n  \r\n    Google LLC 1600 Amphitheatre Parkway, Mountain View, CA 94043\r\n  \r\n\r\n\r\n  \r\n    본 이메일은 Google 제품 또는 계정 관련 중요 변경사항을 알려 드리기 위해 발송되는 필수 서비스 공지입니다.\r\n  \r\n\r\n     \r\n     \r\n\r\n\r\n\t\r\n\r\n  \r\n  \r\n\r\n\r\n\r\n<!-- end body_container -->\r\n\r\n\r\n \t\r\n",
        "receivedDate": "2023-03-07T16:45:01.000+00:00",
        "attachmentSize": 0,
        "attachments": [],
        "tag": "payment",
        "username": "yundabin0608@naver.com"
      },
    ]
  },
  {
    "category": "SNS",
    "removableMailList": [
      {
        "id": 13,
        "msgNum": 13,
        "msgId": 0,
        "subject": "[Firebase] Google Cloud의 활동으로 인해 'Marbon' 프로젝트가 업그레이드되었습니다",
        "sender": "firebase-noreply@google.com",
        "contents":
            " MarbonGoogle Cloud의 활동으로 인해 프로젝트가 업그레이드되었습니다콘솔 열기Firebase는 Google Cloud와 긴밀하게 통합되어 있습니다. 결제 정보 및 공동작업자를 비롯한 여러 설정이 Firebase와 Google Cloud 간에 공유됩니다. 자세히 알아보기사용자가 Google Cloud Console에서 프로젝트에 대한 새 결제 계정을 설정했습니다. 이에 따라 프로젝트에 대한 결제가 시작되어 프로젝트의 Firebase 요금제가 업그레이드되었습니다.프로젝트 업그레이드 완료Marbon요금제Blaze - 사용한 만큼만 지불궁금한 점이 있거나 본 이메일이 잘못 전송되었다면 Firebase 지원팀에 문의하거나 Firebase 가격 책정 FAQ를 참조하시기 바랍니다.Google LLC1600 Amphitheatre PkwyMountain View, CA, 94043 USA",
        "receivedDate": "2023-03-07T16:55:35.000+00:00",
        "attachmentSize": 0,
        "attachments": [],
        "tag": "SNS",
        "username": "yundabin0608@naver.com"
      },
      {
        "id": 51,
        "msgNum": 51,
        "msgId": 0,
        "subject": "[Firebase] Google Cloud의 활동으로 인해 'Marbon' 프로젝트가 업그레이드되었습니다",
        "sender": "firebase-noreply@google.com",
        "contents":
            " MarbonGoogle Cloud의 활동으로 인해 프로젝트가 업그레이드되었습니다Console 열기Firebase는 Google Cloud와 긴밀하게 통합되어 있습니다. 결제 정보 및 공동작업자를 비롯한 여러 설정이 Firebase와 Google Cloud 간에 공유됩니다. 자세히 알아보기사용자가 Google Cloud Console에서 프로젝트에 대한 새 결제 계정을 설정했습니다. 이에 따라 프로젝트에 대한 결제가 시작되어 프로젝트의 Firebase 요금제가 업그레이드되었습니다.프로젝트 업그레이드 완료Marbon요금제Blaze - 사용한 만큼만 지불궁금한 점이 있거나 본 이메일이 잘못 전송되었다면 Firebase 지원팀에 문의하거나 Firebase 가격 책정 FAQ를 참조하시기 바랍니다.Google LLC1600 Amphitheatre PkwyMountain View, CA, 94043 USA",
        "receivedDate": "2023-03-26T14:44:07.000+00:00",
        "attachmentSize": 0,
        "attachments": [],
        "tag": "SNS",
        "username": "yundabin0608@naver.com"
      },
    ]
  },
  {
    "category": "promotion",
    "removableMailList": [
      {
        "id": 124,
        "msgNum": 115,
        "msgId": 0,
        "subject": "ㅅㄷㄱ4며ㅓ5ㄱㄷㅅㅁ",
        "sender": "\"박소윤\" <happine2s@naver.com>",
        "contents":
            "p{margin-top:0px;margin-bottom:0px;}&nbsp;북토크 포함] 3개 이상 수료 시, &lt;제1기 인권아라 숙명인권서포터즈&gt;&nbsp;수료증 발급&nbsp;(전원) &amp;&nbsp;커피 기프티콘&nbsp;1매&nbsp;(10명 추첨)②&nbsp;교육 후기 선정&nbsp;:&nbsp;2만원 상당의 선물&nbsp;또는&nbsp;저자 친필 사인『위험사회학』증정(※&nbsp;단,&nbsp;숙명인권센터 홈페이지 게시에 대한 동의)(※&nbsp;각 프로그램별 혜택과 중복 가능)",
        "receivedDate": "2023-03-29T13:02:38.000+00:00",
        "attachmentSize": 0,
        "attachments": [],
        "tag": "promotion",
        "username": "yundabin0608@naver.com"
      },
      {
        "id": 127,
        "msgNum": 118,
        "msgId": 0,
        "subject": "654덧ㄱ너",
        "sender": "\"박소윤\" <happine2s@naver.com>",
        "contents":
            "p{margin-top:0px;margin-bottom:0px;}본 약관 고지 대상은 비씨카드를 이용하시는 모든 고객님을 대상으로 안내하여 드립니다.☞ 신용 및 체크카드 회원, 페이북머니 회원, 비씨카드금융상품",
        "receivedDate": "2023-03-29T13:03:22.000+00:00",
        "attachmentSize": 0,
        "attachments": [],
        "tag": "promotion",
        "username": "yundabin0608@naver.com"
      },
      {
        "id": 130,
        "msgNum": 121,
        "msgId": 0,
        "subject": "ㄱㄷ뵥ㄷㅂㅁ",
        "sender": "\"박소윤\" <happine2s@naver.com>",
        "contents":
            "p{margin-top:0px;margin-bottom:0px;}본 보안메일은 멀티브라우저 및 멀티OS 환경을 지원 합니다.PC 환경에서는 Windows와 Mac의 다양한 브라우저를 지원하며 모바일 환경에서는 Android와 iOS를 지원합니다.",
        "receivedDate": "2023-03-29T13:04:01.000+00:00",
        "attachmentSize": 0,
        "attachments": [],
        "tag": "promotion",
        "username": "yundabin0608@naver.com"
      },
      {
        "id": 131,
        "msgNum": 122,
        "msgId": 0,
        "subject": "ㅎㄹ엏ㄴㄱㅈ",
        "sender": "\"박소윤\" <happine2s@naver.com>",
        "contents":
            "p{margin-top:0px;margin-bottom:0px;}역을 변경하시려면,하나은행 홈페이지의 [이메일서비스]메뉴를 이용하시기 바랍니다.고객 만족을 위해 최선을 다하는 하나은행이 되도록 노력하겠습니다. 감사\n\n",
        "receivedDate": "2023-03-29T13:04:16.000+00:00",
        "attachmentSize": 0,
        "attachments": [],
        "tag": "promotion",
        "username": "yundabin0608@naver.com"
      },
    ]
  },
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
  Map<String, List<int>> data =
      {}; // data 형태는 {username1:[해당 메일 선택리스트], username2:[해당 메일 선택 리스트]}

  bool _disposed = false; // 메모리 해제
  Map<String, List<int>> get _data => data;

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

  void settingMap(accountList) {
    for (String username in accountList) {
      data[username] = [];
    }
  }

  // 메일 선택 추가 (data에 없는 경우만 mail 리스트에 추가)
  void addItem(String username, int value) {
    // data에 없는 경우에만 mail리스트에 추가
    var flag = data[username]!.contains(value);
    logger.d("dsafdfsasd $data");

    if (!flag) {
      data[username]!.add(value);
      logger.d(data);
      notifyListeners();
    }
  }

  // 메일 선택 해제 (data에 있을경우)
  void removeItem(String username, int value) {
    var flag = data[username]!.contains(value);
    if (flag) {
      data[username]!.remove(value);
    }
    logger.d(data);
    notifyListeners();
  }

  // 메일 선택 전체 해제
  void clearItem() {
    data.clear();
    notifyListeners();
  }
}
