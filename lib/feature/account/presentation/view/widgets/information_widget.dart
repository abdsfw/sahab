import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sahab_project/core/theme/app_textsyle.dart';
import 'package:shimmer/shimmer.dart';

class InformationWidget extends StatelessWidget {
  const InformationWidget({
    super.key,
    required this.color,
    required this.fText,
    required this.sText,
  });
  final Color color;
  final String fText;
  final String sText;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 171.w,
      height: 120.h,
      decoration: ShapeDecoration(
        color: color,
        shape: RoundedRectangleBorder(
          side: BorderSide(width: 1.w, color: color),
          borderRadius: BorderRadius.circular(10 * ScreenUtil().scaleWidth),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // SizedBox(
          //   height: 22.h,
          // ),
          Text(
            fText,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: AppStyles.getFontFamily(context),
              fontWeight: FontWeight.w700,
              color: Colors.white,
              fontSize: 24.sp,
            ),
          ),
          Text(
            sText,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: AppStyles.getFontFamily(context),
              fontWeight: FontWeight.w400,
              color: Colors.white,
              fontSize: 16.sp,
            ),
          ),
        ],
      ),
    );
  }
}

class ShimmerInformationWidget extends StatelessWidget {
  const ShimmerInformationWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!, // Specify base color
      highlightColor: Colors.grey[100]!, // Specify highlight color
      period: Duration(milliseconds: 800), // Specify shimmer duration
      child: Container(
        width: 171.w,
        height: 120.h,
        decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(
            side: BorderSide(
              width: 1.w,
            ),
            borderRadius: BorderRadius.circular(10 * ScreenUtil().scaleWidth),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "xxxx",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: AppStyles.getFontFamily(context),
                fontWeight: FontWeight.w600,
                color: Colors.white,
                fontSize: 24.sp,
              ),
            ),
            Text(
              "xxxx",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: AppStyles.getFontFamily(context),
                fontWeight: FontWeight.w400,
                color: Colors.white,
                fontSize: 18.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
