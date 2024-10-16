import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sahab_project/core/theme/app_color.dart';
import 'package:sahab_project/core/theme/app_textsyle.dart';

import '../../../../core/utils/widgets/app_text.dart';

class LoginLogoTextWidget extends StatelessWidget {
  const LoginLogoTextWidget({
    Key? key,
    required this.imagePath,
    required this.firstText,
    required this.secondText,
  }) : super(key: key);
  final String imagePath;
  final String firstText;
  final String secondText;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.asset(
          imagePath,
          width: 98.w,
          height: 106.h,
        ),
        SizedBox(
          height: 22.h,
        ),
        AppText(
            text: firstText,
            fontSize: 24.sp,
            fontWeight: FontWeight.w600,
            fontFamily: AppStyles.getFontFamily(context),
            color: const Color(0xff07183B)),
        AppText(
            text: secondText,
            fontSize: 24.sp,
            fontWeight: FontWeight.w600,
            fontFamily: AppStyles.getFontFamily(context),
            color: const Color(0xff07183B)),
        SizedBox(height: 34.h),
      ],
    );
  }
}
