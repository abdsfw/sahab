import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahab_project/core/theme/app_textsyle.dart';
import 'package:sahab_project/feature/boarding/presentation/manager/lang_cubit/lang_cubit.dart';

import '../../theme/app_color.dart';

class AppText extends StatelessWidget {
  AppText({
    Key? key,
    required this.text,
    required this.fontSize,
    required this.fontWeight,
    this.fontFamily,
    // required this.lan,
    required this.color,
    this.decoration,
  }) : super(key: key);
  String text;
  double fontSize;
  FontWeight fontWeight;
  String? fontFamily;
  // String lan;
  Color color;
  TextDecoration? decoration;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
          fontSize: fontSize,
          fontWeight: fontWeight,
          decoration: decoration,
          fontFamily: AppStyles.getFontFamily(context),
          color: color),
    );
  }
}
