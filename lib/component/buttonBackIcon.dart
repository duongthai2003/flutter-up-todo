import 'package:flutter/material.dart';

Widget buttonBackIcon({required VoidCallback onBackPressed}) {
  return GestureDetector(
    onTap: onBackPressed,
    child: Container(
      // margin: EdgeInsets.only(left: 24),
      width: 24,
      height: 24,
      alignment: Alignment.center,
      child: Icon(Icons.arrow_back_ios_new, color: Colors.white),
    ),
  );
}
