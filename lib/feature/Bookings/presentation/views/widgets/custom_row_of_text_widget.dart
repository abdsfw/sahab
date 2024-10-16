import 'package:flutter/material.dart';
import 'package:sahab_project/core/theme/app_textsyle.dart';

class CustomRowOfTextWidget extends StatelessWidget {
  const CustomRowOfTextWidget({
    super.key,
    required this.text1,
    required this.text2,
    this.style,
  });
  final String text1;
  final String text2;
  final TextStyle? style;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Text(
            text1,
            style: (style == null)
                ? AppStyles.textStyle16w400Black(context)
                : style,
          ),
        ),
        Expanded(
          child: Text(
            text2,
            textAlign: TextAlign.end,
            style: (style == null)
                ? AppStyles.textStyle16w400Black(context)
                : style,
          ),
        ),
      ],
    );
  }
}
