import 'package:flutter/material.dart';

import '../../theme/app_color.dart';

class AppSnackBarMessage {
  void showSnackBar(
      {required String message,
      required Color backgroundColor,
      required BuildContext context}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message.toString(),
          style: const TextStyle(
            color: AppColor.textColor,
          ),
        ),
        backgroundColor: backgroundColor,
      ),
    );
  }
}
