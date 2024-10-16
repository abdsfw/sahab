import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sahab_project/core/theme/app_textsyle.dart';

import '../../../../core/theme/app_color.dart';

class TextLanWidget extends StatelessWidget {
  const TextLanWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 29.h,
        ),
        Text(
          'Choose your language',
          style: TextStyle(
            fontSize: 22.sp,
            fontWeight: FontWeight.w600,
            fontFamily: AppStyles.getFontFamily(context),
          ),
        ),
        SizedBox(
          height: 11.h,
        ),
        Text(
          'Please choose your language!',
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.w400,
            fontFamily: AppStyles.getFontFamily(context),
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.05,
        ),
      ],
    );
  }
}
