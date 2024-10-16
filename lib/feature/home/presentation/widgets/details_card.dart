import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DetailsCard extends StatelessWidget {
  const DetailsCard({
    super.key,
    required this.child,
    required this.containerColor,
  });
  final Widget child;
  final Color containerColor;
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Container(
      height: 40.h,
      // width: 72.w,
      padding: EdgeInsetsDirectional.only(
// bottom: ,
          start: 11.w,
          end: 11.w,
          top: 0,
          bottom: 0),
      decoration: BoxDecoration(
          color: containerColor,
          borderRadius: const BorderRadius.all(Radius.circular(5))),
      child: child,
    );
  }
}
