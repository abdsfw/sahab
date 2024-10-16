import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_color.dart';
import '../../../../core/utils/widgets/app_button.dart';

class ChooseLangWidget extends StatelessWidget {
  ChooseLangWidget(
      {Key? key, required this.englishOnTap, required this.arabicOnTap})
      : super(key: key);
  void Function()? englishOnTap;
  void Function()? arabicOnTap;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        AppButton(
            width: 185.w,
            height: size.height * 0.15,
            onTap: englishOnTap,
            text: 'English',
            color: AppColor.blueColor,
            radius: 10.r,
            fontSize: 18.sp,
            fontFamily: AppFont.Poppins,
            textColor: AppColor.textColor,
            fontWeight: FontWeight.w600),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.05, //38,
        ),
        AppButton(
            width: 185.w,
            height: size.height * 0.15,
            onTap: arabicOnTap,
            text: 'العربية',
            color: AppColor.secondPrimaryColor,
            radius: 10.r,
            fontSize: 18.sp,
            fontFamily: AppFont.Almarai,
            textColor: AppColor.textColor,
            fontWeight: FontWeight.w700),
      ],
    );
  }
}
