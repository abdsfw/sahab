import 'package:flutter/material.dart';

import '../../theme/app_textsyle.dart';

class CustomTitleInputField extends StatelessWidget {
  const CustomTitleInputField({
    super.key,
    required this.title,
    this.textStyle,
  });
  final String title;
  final TextStyle? textStyle;
  @override
  Widget build(BuildContext context) {
    return Text(
      title, //"Name*",
      style: textStyle ?? AppStyles.textstyle16w500Brown(context),
    );
  }
}
