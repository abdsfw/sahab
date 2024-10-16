import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sahab_project/core/theme/app_textsyle.dart';

class OptionWidget extends StatelessWidget {
  const OptionWidget({
    super.key,
    required this.trailing,
    required this.title,
    required this.leadingIcon,
    required this.onTap,
  });
  final Widget trailing;
  final String title;
  final String leadingIcon;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 5.h),
      child: ListTile(
        onTap: onTap,
        contentPadding: EdgeInsetsDirectional.zero,
        leading: Container(
          width: 50.w,
          height: 50.h,
          decoration: ShapeDecoration(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              side: const BorderSide(width: 1, color: Color(0xFFD9A757)),
              borderRadius: BorderRadius.circular(10),
            ),
            shadows: const [
              BoxShadow(
                color: Color(0x33959DA5),
                blurRadius: 24,
                offset: Offset(0, 8),
                spreadRadius: 0,
              )
            ],
          ),
          child: Center(
            child: SvgPicture.asset(
              leadingIcon,
              width: 20.w,
              height: 20.w,
            ),
          ),
        ),
        title: Text(
          title,
          style: AppStyles.style17(context).copyWith(color: Colors.black),
        ),
        trailing: trailing,
      ),
    );
  }
}
