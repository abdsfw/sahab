import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sahab_project/core/const.dart';
import 'package:sahab_project/core/theme/app_color.dart';
import 'package:sahab_project/core/utils/cache/cache_helper.dart';
import 'package:sahab_project/feature/boarding/presentation/manager/lang_cubit/lang_cubit.dart';

class AppStyles {
  static const String Poppins = 'Poppins';
  static const String Almarai = 'Almarai';
  AppStyles._();
  //this semi bold
  static String getFontFamily(BuildContext context) {
    // Retrieve the language from the LangCubit
    String language = BlocProvider.of<LangCubit>(context).lang;

    // Return the appropriate font family based on the language
    return language == 'ar' ? Almarai : Poppins;
  }

  static TextStyle getCustomTextStyle(
      BuildContext context, TextStyle textStyle) {
    String fontFamily = getFontFamily(context);
    return textStyle.copyWith(fontFamily: fontFamily);
  }

  static TextStyle style24(context) {
    return getCustomTextStyle(
      context,
      TextStyle(
        fontWeight: FontWeight.w600,
        color: AppColor.darkBlueColor,
        fontSize: 24.sp,
      ),
    );
  }

  // static TextStyle style24 = TextStyle(
  //   fontFamily: 'Poppins',
  //   fontWeight: FontWeight.w600,
  //   color: AppColor.darkBlueColor,
  //   fontSize: 24.sp,
  // );

  static TextStyle style24White(context) => TextStyle(
        fontFamily: 'Poppins',
        fontWeight: FontWeight.w600,
        color: Colors.white,
        fontSize: 24.sp,
      );
  static TextStyle style22WhiteSemiBold(context) => getCustomTextStyle(
      context,
      TextStyle(
        fontFamily: 'Poppins',
        fontWeight: FontWeight.w600,
        color: Colors.white,
        fontSize: 22.sp,
      ));
  static TextStyle style20(context) => getCustomTextStyle(
      context,
      TextStyle(
        fontFamily: 'Poppins',
        fontWeight: FontWeight.w400,
        color: AppColor.darkBlueColor,
        fontSize: 20.sp,
      ));
  static TextStyle style20semibold(context) => getCustomTextStyle(
        context,
        TextStyle(
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w600,
          color: AppColor.darkBlueColor,
          fontSize: 20.sp,
        ),
      );
  static TextStyle style18semibold(context) => getCustomTextStyle(
      context,
      TextStyle(
        fontFamily: 'Poppins',
        fontWeight: FontWeight.w600,
        color: AppColor.darkBlueColor,
        fontSize: 18.sp,
      ));
  static TextStyle style18(context) => getCustomTextStyle(
      context,
      TextStyle(
        fontFamily: 'Poppins',
        fontWeight: FontWeight.w400,
        color: AppColor.darkBlueColor,
        fontSize: 18.sp,
      ));
  static TextStyle style16(context) => getCustomTextStyle(
      context,
      TextStyle(
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w400,
          fontSize: 16.sp,
          color: AppColor.darkBlueColor));
  static TextStyle style16w500(context) => getCustomTextStyle(
      context,
      TextStyle(
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w500,
          fontSize: 16.sp,
          color: AppColor.greyColor));
  static TextStyle style15(context) => getCustomTextStyle(
      context,
      TextStyle(
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w400,
          fontSize: 15.sp,
          color: AppColor.greyColor));
  static TextStyle style15semibold(context) => getCustomTextStyle(
      context,
      TextStyle(
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w400,
          fontSize: 15.sp,
          color: AppColor.whiteColor));
  static TextStyle style14(context) => getCustomTextStyle(
      context,
      TextStyle(
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w400,
          fontSize: 14.sp,
          color: AppColor.goldColor));
  static TextStyle style14semibold(context) => getCustomTextStyle(
      context,
      TextStyle(
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w500,
          fontSize: 14.sp,
          color: AppColor.brownColor));
  static TextStyle style14Bold(context) => getCustomTextStyle(
      context,
      TextStyle(
          fontFamily: 'Poppins',
          fontWeight: FontWeight.bold,
          fontSize: 14.sp,
          color: Colors.black));
  static TextStyle style12(context) => getCustomTextStyle(
      context,
      TextStyle(
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w600,
          fontSize: 12.sp,
          color: AppColor.blueColor));
  static TextStyle textStyle12w400Red(context) => getCustomTextStyle(
      context,
      TextStyle(
        fontFamily: 'Poppins',
        fontWeight: FontWeight.w400,
        fontSize: 12.sp,
        color: AppColor.errorColor,
      ));
  static TextStyle textStyle12w400green(context) => getCustomTextStyle(
      context,
      TextStyle(
        fontFamily: 'Poppins',
        fontWeight: FontWeight.w400,
        fontSize: 12.sp,
        color: AppColor.successColor,
      ));
  static TextStyle textStyle16w400DarkBlue(context) => getCustomTextStyle(
      context,
      TextStyle(
        fontFamily: 'Poppins',
        fontWeight: FontWeight.w400,
        fontSize: 16.sp,
        color: AppColor.darkBlueColor,
      ));
  static TextStyle textStyle26w600DarkBlue(context) => getCustomTextStyle(
      context,
      TextStyle(
        fontFamily: 'Poppins',
        fontWeight: FontWeight.w600,
        fontSize: 26.sp,
        color: AppColor.darkBlueColor,
      ));
  static TextStyle textStyle14w400GreyHint(context) => getCustomTextStyle(
      context,
      TextStyle(
        fontFamily: 'Poppins',
        fontWeight: FontWeight.w400,
        fontSize: 14.sp,
        color: AppColor.greyHintColor,
      ));
  static TextStyle textStyle14w500DarkBlue(context) => getCustomTextStyle(
      context,
      TextStyle(
        fontFamily: 'Poppins',
        fontWeight: FontWeight.w500,
        fontSize: 14.sp,
        color: AppColor.darkBlueColor,
      ));
  static TextStyle textStyle18w500DarkBlue(context) => getCustomTextStyle(
      context,
      TextStyle(
        fontFamily: 'Poppins',
        fontWeight: FontWeight.w500,
        fontSize: 18.sp,
        color: AppColor.darkBlueColor,
      ));
  static TextStyle textstyle16w500DarkBlue(context) => getCustomTextStyle(
      context,
      TextStyle(
        fontFamily: 'Poppins',
        fontWeight: FontWeight.w500,
        fontSize: 16.sp,
        color: AppColor.darkBlueColor,
      ));
  static TextStyle textStyle13w600Black(context) => getCustomTextStyle(
      context,
      TextStyle(
        fontFamily: 'Poppins',
        fontWeight: FontWeight.w600,
        fontSize: 13.sp,
        color: AppColor.blackColor,
      ));
  static TextStyle textStyle20w600DarkBlue(context) => getCustomTextStyle(
      context,
      TextStyle(
        fontFamily: 'Poppins',
        fontWeight: FontWeight.w600,
        fontSize: 20.sp,
        color: AppColor.darkBlueColor,
      ));
  static TextStyle textStyle17w400DarkBlue(context) => getCustomTextStyle(
      context,
      TextStyle(
        fontFamily: 'Poppins',
        fontWeight: FontWeight.w400,
        fontSize: 17.sp,
        color: AppColor.darkBlueColor,
      ));
  static TextStyle textStyle15w400GreyLight(context) => getCustomTextStyle(
      context,
      TextStyle(
        fontFamily: 'Poppins',
        fontWeight: FontWeight.w400,
        fontSize: 15.sp,
        color: AppColor.greyLightColor,
      ));
  static TextStyle textStyle15w400Black(context) => getCustomTextStyle(
      context,
      TextStyle(
        fontFamily: 'Poppins',
        fontWeight: FontWeight.w400,
        fontSize: 15.sp,
        color: AppColor.blackColor,
      ));
  static TextStyle textStyle18w600Black(context) => getCustomTextStyle(
      context,
      TextStyle(
        fontFamily: 'Poppins',
        fontWeight: FontWeight.w600,
        fontSize: 18.sp,
        color: AppColor.blackColor,
      ));
  static TextStyle textStyle16w400Black(context) => getCustomTextStyle(
      context,
      TextStyle(
        fontFamily: 'Poppins',
        fontWeight: FontWeight.w400,
        fontSize: 16.sp,
        color: AppColor.blackColor,
      ));
  static TextStyle textStyle20w700Blue(context) => getCustomTextStyle(
      context,
      TextStyle(
        fontFamily: 'Poppins',
        fontWeight: FontWeight.w700,
        fontSize: 20.sp,
        color: AppColor.blueColor,
      ));
  static TextStyle textStyle17w700Blue(context) => getCustomTextStyle(
      context,
      TextStyle(
        fontFamily: 'Poppins',
        fontWeight: FontWeight.w700,
        fontSize: 17.sp,
        color: AppColor.blueColor,
      ));
  static TextStyle textStyle17w700Black(context) => getCustomTextStyle(
      context,
      TextStyle(
        fontFamily: 'Poppins',
        fontWeight: FontWeight.w700,
        fontSize: 17.sp,
        color: AppColor.blackColor,
      ));
  static TextStyle textstyle16w500Brown(context) => getCustomTextStyle(
      context,
      TextStyle(
        fontFamily: 'Poppins',
        fontWeight: FontWeight.w500,
        fontSize: 16.sp,
        color: AppColor.brownColor,
      ));
  static TextStyle textstyle16w400Brown(context) => getCustomTextStyle(
      context,
      TextStyle(
        fontFamily: 'Poppins',
        fontWeight: FontWeight.w400,
        fontSize: 16.sp,
        color: AppColor.brownColor,
      ));
  static TextStyle textStyle17w400Brown(context) => getCustomTextStyle(
      context,
      TextStyle(
        fontFamily: 'Poppins',
        fontWeight: FontWeight.w400,
        fontSize: 17.sp,
        color: AppColor.brownColor,
      ));
  static TextStyle textStyle12w500Blue(context) => getCustomTextStyle(
      context,
      TextStyle(
        fontFamily: 'Poppins',
        fontWeight: FontWeight.w500,
        fontSize: 14.sp,
        color: AppColor.blueColor,
      ));
  static TextStyle textStyle12w500Grey(context) => getCustomTextStyle(
      context,
      TextStyle(
        fontFamily: 'Poppins',
        fontWeight: FontWeight.w500,
        fontSize: 12.sp,
        color: AppColor.greyColor,
      ));

  static TextStyle textStyle30w500black2(context) => getCustomTextStyle(
      context,
      TextStyle(
        fontFamily: 'Poppins',
        fontWeight: FontWeight.w500,
        fontSize: 30.sp,
        color: AppColor.black2Color,
      ));

  static TextStyle style17semibold(context) => getCustomTextStyle(
      context,
      TextStyle(
        fontFamily: 'Poppins',
        fontWeight: FontWeight.w600,
        color: AppColor.darkBlueColor,
        fontSize: 17.sp,
      ));
  static TextStyle style17(context) => getCustomTextStyle(
      context,
      TextStyle(
        fontFamily: 'Poppins',
        fontWeight: FontWeight.w400,
        color: AppColor.darkBlueColor,
        fontSize: 17.sp,
      ));

  static TextStyle style15w500(context) => getCustomTextStyle(
      context,
      TextStyle(
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w500,
          fontSize: 15.sp,
          color: Colors.white));
  static TextStyle headWithShadow(context) => getCustomTextStyle(
      context,
      const TextStyle(
        fontFamily: 'Poppins',
        fontWeight: FontWeight.bold,
        fontSize: 22.0,
        shadows: [
          Shadow(
            color: Colors.grey,
            offset: Offset(2, 2),
            blurRadius: 3,
          ),
        ],
      ));
  static TextStyle subHead(context) => getCustomTextStyle(
      context,
      const TextStyle(
        fontFamily: 'Poppins',
        fontWeight: FontWeight.w600,
        fontSize: 20.0,
      ));
  static TextStyle body(context) => getCustomTextStyle(
      context, const TextStyle(fontFamily: 'Poppins', fontSize: 16));
  // ignore: constant_identifier_names
  // static const TextStyle bottom = TextStyle(
  //     fontFamily: 'Poppins', fontSize: 12, color: AppColor.whiteColor);
}
/*
class AppStylesN {
  static const String Poppins = 'Poppins';
  static const String Almarai = 'Almarai';

  AppStylesN._();

  static String getFontFamily(BuildContext context) {
    // Retrieve the language from the LangCubit
    String language = BlocProvider.of<LangCubit>(context).lang;

    // Return the appropriate font family based on the language
    return language == 'ar' ? Almarai : Poppins;
  }

  static TextStyle getCustomTextStyle(
      BuildContext context, TextStyle textStyle) {
    String fontFamily = getFontFamily(context);
    return textStyle.copyWith(fontFamily: fontFamily);
  }

  static TextStyle style24(context) {
    return getCustomTextStyle(
      context,
      TextStyle(
        fontWeight: FontWeight.w600,
        color: AppColor.darkBlueColor,
        fontSize: 24,
      ),
    );
  }
}
*/
