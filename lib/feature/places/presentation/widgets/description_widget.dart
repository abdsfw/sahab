import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sahab_project/core/theme/app_color.dart';
import 'package:sahab_project/core/theme/app_textsyle.dart';

class DescriptionWidget extends StatelessWidget {
  const DescriptionWidget({
    super.key,
    required this.content,
  });
  final String content;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 16.w, top: 3.h, bottom: 40.h, right: 34.w),
      child: Text(
        content,
        style: AppStyles.style14(context)
            .copyWith(color: AppColor.greyColorWithOpacity),
      ),
    );
  }
}
