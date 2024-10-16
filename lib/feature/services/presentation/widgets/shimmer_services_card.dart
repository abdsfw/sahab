import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sahab_project/feature/services/presentation/widgets/service_card_view_all.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerServicesCard extends StatelessWidget {
  const ShimmerServicesCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: Container(
          margin: EdgeInsets.only(left: 16.w, right: 16.w, bottom: 28.h),
          width: 361.w,
          height: 120.h,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(5)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(width: 30.w),
              Container(
                width: 50.w,
                height: 50.h,
                color: Colors.white,
              ),
              SizedBox(width: 30.w),
              Container(
                width: 150.w,
                height: 24.h,
                color: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
