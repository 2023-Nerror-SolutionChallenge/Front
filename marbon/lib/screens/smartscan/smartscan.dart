import 'package:blobs/blobs.dart';
import 'package:flutter/material.dart';
import 'package:marbon/color.dart';
import 'package:marbon/size.dart';
import 'package:marbon/widgets/title_painter.dart';

class SmartScan extends StatelessWidget {
  const SmartScan({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constrains) => Container(
        color: Colors.white,
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: <Color>[
                gradient1_color,
                gradient2_color,
                gradient3_color
              ],
              tileMode: TileMode.mirror,
            ),
          ),
          child: Scaffold(
            backgroundColor: transparent_color,
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Stack(
                  children: [
                    SizedBox(
                      height: 300, // 원하는높이 + 반지름길이
                      width: constrains.maxWidth,
                      child: CustomPaint(
                        painter: TitlePainter(),
                      ),
                    ),
                    const Positioned(
                      left: smartscan_title_left,
                      top: 130,
                      child: Text(
                        "Smartscan",
                        style: TextStyle(
                          color: text_green_color,
                          fontSize: 40,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  width: constrains.maxHeight - (300 + 140 + 15),
                  height: constrains.maxHeight - (300 + 140 + 15),
                  child: Image.asset(
                    'assets/img/scan.png',
                    fit: BoxFit.fill,
                  ),
                ),
                Blob.fromID(
                  id: const ['8-7-698'],
                  size: 140,
                  styles: BlobStyles(
                      gradient: const RadialGradient(colors: [
                    Color(0xffffffff),
                    Color.fromARGB(253, 247, 247, 247)
                  ]).createShader(
                          const Rect.fromLTRB(0, 140, 140, 0))), //0, y, x, 0
                  child: TextButton(
                      style: const ButtonStyle(
                        backgroundColor:
                            MaterialStatePropertyAll(transparent_color),
                      ),
                      child: const Text(
                        "scanning",
                        style: TextStyle(
                            color: text_green_color,
                            fontSize: 18,
                            fontWeight: FontWeight.w600),
                      ),
                      onPressed: () {
                        // 스마트스캔 api 호출 후 다되면 smartscan detail에 인자로 결과 넘겨주기
                        // 만약 회사별로 한다면 Future.wait(회사별 스마트스캔 api 호출) 한꺼번에 받아서
                        // 카테고리별로 찢어서 다 합쳐야함

                        // 따라서 mail 모델에 username이 인자로 더 들어가야함

                        // 삭제할때도 리스트에 id, username 형태로 들어간 후 삭제 요청은
                        // username별로 묶어서 그걸로 요청 여러개 보내야함

                        Navigator.pushNamed(context, "/smartscan_detail");
                      }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
