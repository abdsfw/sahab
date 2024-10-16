import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sahab_project/core/theme/app_textsyle.dart';

import '../../theme/app_color.dart';
import 'app_button.dart';

class CustomTwoButton extends StatelessWidget {
  const CustomTwoButton({
    super.key,
    this.onTap1,
    this.onTap2,
    required this.buttonColor1,
    required this.buttonColor2,
    required this.text1,
    required this.text2,
    required this.textColor1,
    required this.textColor2,
  });
  final void Function()? onTap1;
  final void Function()? onTap2;
  final Color buttonColor1;
  final Color buttonColor2;
  final String text1;
  final String text2;
  final Color textColor1;
  final Color textColor2;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: AppButton(
            width: double.infinity,
            height: 50.h,
            onTap: onTap1,
            text: text1,
            color: buttonColor1,
            radius: 5.r,
            fontSize: 16.sp,
            fontFamily: AppStyles.getFontFamily(context),
            textColor: textColor1,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(
          width: 20.w,
        ),
        Expanded(
          child: AppButton(
            width: double.infinity,
            height: 50.h,
            onTap: onTap2,
            text: text2,
            color: buttonColor2,
            radius: 5.r,
            fontSize: 16.sp,
            fontFamily: AppStyles.getFontFamily(context),
            textColor: textColor2,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
