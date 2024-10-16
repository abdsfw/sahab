import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahab_project/core/theme/app_textsyle.dart';

import '../../../feature/boarding/presentation/manager/lang_cubit/lang_cubit.dart';
import '../../theme/app_color.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    Key? key,
    this.width,
    this.height,
    required this.onTap,
    required this.text,
    required this.color,
    required this.radius,
    required this.fontSize,
    this.fontFamily,
    required this.textColor,
    required this.fontWeight,
  }) : super(key: key);
  final double? width;
  final double? height;
  final double radius;
  final void Function()? onTap;
  final Color color;
  final Color textColor;
  final String text;
  final String? fontFamily;
  final double fontSize;
  final FontWeight fontWeight;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: color,
      borderRadius: BorderRadius.all(
        Radius.circular(
          radius,
        ),
      ),
      child: InkWell(
        splashColor: textColor.withOpacity(0.5),
        onTap: onTap,
        borderRadius: BorderRadius.circular(radius),
        child: Container(
          padding: EdgeInsets.all(5),
          width: width,
          height: height,
          decoration: BoxDecoration(
              // color: color,
              borderRadius: BorderRadius.all(Radius.circular(radius))),
          child: Center(
              child: Text(
            text,
            style: TextStyle(
                fontSize: fontSize,
                fontFamily: AppStyles.getFontFamily(context),
                color: textColor,
                fontWeight: fontWeight),
          )),
        ),
      ),
    );
  }
}
