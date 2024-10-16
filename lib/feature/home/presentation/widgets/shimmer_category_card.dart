import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerCategoryCard extends StatelessWidget {
  const ShimmerCategoryCard({
    Key? key,
    required this.width,
    required this.height,
    required this.margin,
  }) : super(key: key);

  final double width;
  final double height;
  final EdgeInsetsGeometry? margin;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[350]!,
      highlightColor: Colors.grey[300]!,
      child: Column(
        children: [
          Container(
            width: width,
            height: height,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(5)),
            ),
          ),
          SizedBox(height: 10.h),
          Container(
            width: width *
                0.7, // Adjust the width of shimmer effect as per your need
            height: 16.h,
            color: Colors.white,
          ),
        ],
      ),
    );
  }
}
