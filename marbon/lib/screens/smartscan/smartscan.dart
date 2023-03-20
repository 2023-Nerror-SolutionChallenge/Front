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
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                SizedBox(
                  width: 300,
                  height: 300,
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
                        ),
                      ),
                      onPressed: () =>
                          {Navigator.pushNamed(context, "/smartscan_detail")}),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
