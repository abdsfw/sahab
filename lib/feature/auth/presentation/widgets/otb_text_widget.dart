import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sahab_project/core/utils/functions/function.dart';

import '../../../../core/theme/app_color.dart';

class OTBTextWidget extends StatelessWidget {
  OTBTextWidget({
    Key? key,
    // required this.lan,
    required this.numberText,
    required this.firstText,
    required this.secondText,
    required this.thirdText,
  }) : super(key: key);
  // bool lan;
  String numberText;
  String firstText;
  String secondText;
  String thirdText;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 32,
        ),
        Text(
          numberText,
          style: TextStyle(
            fontSize: 18.sp,
            color: const Color(0xff07183B),
            fontWeight: FontWeight.w700,
            fontFamily: AppFunction.checkFamilyFont(context),
          ),
        ),
        SizedBox(
          height: 8.h,
        ),
        Text(
          secondText,
          style: TextStyle(
            fontSize: 16.sp,
            color: const Color(0xff2E2E2E),
            fontWeight: FontWeight.w400,
            fontFamily: AppFunction.checkFamilyFont(context),
          ),
        ),
        SizedBox(
          height: 10.h,
        ),
        // Text(
        //   secondText,
        //   style: TextStyle(
        //     fontSize: 16.sp,
        //     color: const Color(0xff2E2E2E),
        //     fontWeight: FontWeight.w400,
        //     fontFamily: AppFunction.checkFamilyFont(context),
        //   ),
        // ),
        Text(
          thirdText,
          style: TextStyle(
            fontSize: 16.sp,
            color: const Color(0xff2E2E2E),
            fontWeight: FontWeight.w400,
            fontFamily: AppFunction.checkFamilyFont(context),
          ),
        ),
        SizedBox(
          height: 33.h,
        ),
      ],
    );
  }
}
