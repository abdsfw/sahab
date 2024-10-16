import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sahab_project/core/theme/app_textsyle.dart';
import 'package:sahab_project/core/utils/icons/app_icons.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    super.key,
    required this.title,
  });
  final String title;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: EdgeInsets.only(left: 16.w, top: 41.h, right: 4.5.w),
          child: InkWell(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: SvgPicture.asset(
              AppIcons.left_arrow,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 35.h),
          child: Text(
            title,
            style: AppStyles.style14(context).copyWith(color: Colors.black),
          ),
        )
      ],
    );
  }
}
