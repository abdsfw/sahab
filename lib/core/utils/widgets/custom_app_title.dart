import 'package:flutter/material.dart';

import '../../theme/app_textsyle.dart';

class CustomAppTitle extends StatelessWidget {
  const CustomAppTitle({
    super.key,
    required this.title,
    this.style,
  });
  final String title;
  final TextStyle? style;
  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: style ?? AppStyles.textStyle20w600DarkBlue(context),
    );
  }
}
