import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

Widget PrimaryButton({
  required Function() onPressed,
  ButtonStyle? style,
  TextStyle? textStyle,
  String? label,
}) {
  return ElevatedButton(
    // ElevatedButton tạo button nền màu
    onPressed: () {
      onPressed();
    },
    child: Text(
      label ?? "",
      style: TextStyle(
        color: Colors.white,
        fontSize: 16,
        fontWeight: FontWeight.w400,
      ).merge(textStyle),
    ),
    style: (style ?? const ButtonStyle()).merge(
      ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF8875FF),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        minimumSize: const Size.fromHeight(48),
        disabledBackgroundColor: const Color.fromARGB(
          255,
          255,
          187,
          0,
        ).withValues(alpha: 0.5),
      ),
    ),
  );
}
