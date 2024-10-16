import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerPlacesCard extends StatelessWidget {
  const ShimmerPlacesCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        margin: EdgeInsetsDirectional.only(end: 15.w),
        width: 319.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(5)),
          color: Colors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              height: 180.h,
              color: Colors.white,
            ),
            SizedBox(height: 10.h),
            Container(
              width: 200.w,
              height: 16.h,
              color: Colors.white,
            ),
            SizedBox(height: 5.h),
            Container(
              width: 150.w,
              height: 16.h,
              color: Colors.white,
            ),
            SizedBox(height: 5.h),
            Row(
              children: [
                Container(
                  width: 20.w,
                  height: 20.h,
                  color: Colors.white,
                ),
                SizedBox(width: 5.w),
                Container(
                  width: 120.w,
                  height: 16.h,
                  color: Colors.white,
                ),
              ],
            ),
            SizedBox(height: 5.h),
            Row(
              children: [
                Container(
                  width: 20.w,
                  height: 20.h,
                  color: Colors.white,
                ),
                SizedBox(width: 5.w),
                Container(
                  width: 100.w,
                  height: 16.h,
                  color: Colors.white,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
