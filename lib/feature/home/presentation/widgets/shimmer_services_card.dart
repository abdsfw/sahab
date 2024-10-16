import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerServicesCard extends StatelessWidget {
  const ShimmerServicesCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        width: 169.w,
        height: 70.h,
        margin: EdgeInsetsDirectional.only(end: 20.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(5)),
        ),
        child: Padding(
          padding: EdgeInsets.only(left: 20.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 30.w,
                height: 30.h,
                color: Colors.white, // Placeholder color
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: Container(
                  height: 16.h,
                  color: Colors.white, // Placeholder color
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
