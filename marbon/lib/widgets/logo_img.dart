import 'package:flutter/widgets.dart';

Widget logoImage(String company) {
  return ClipRRect(
    borderRadius: BorderRadius.circular(40),
    child: Image.asset(
      "assets/img/$company.png",
      width: 40,
      height: 40,
      fit: BoxFit.fill,
    ),
  );
}
