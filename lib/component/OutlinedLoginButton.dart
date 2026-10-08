import 'package:flutter/material.dart';

Widget OutlinedLoginButton({Widget? icon, required String label}) {
  return OutlinedButton(
    onPressed: () {},
    child: Row(
      spacing: 10,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (icon != null) icon,
        Text(
          label.toUpperCase(),
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: Colors.white,
          ),
        ),
      ],
    ),
    style: OutlinedButton.styleFrom(
      fixedSize: Size(double.infinity, 48),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      side: BorderSide(color: Color(0xFF8875FF), width: 2),
    ),
  );
}
