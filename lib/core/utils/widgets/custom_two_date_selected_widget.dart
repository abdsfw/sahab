import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sahab_project/core/theme/app_textsyle.dart';
import 'package:sahab_project/generated/l10n.dart';

class CustomTwoDateSelectedWidget extends StatelessWidget {
  const CustomTwoDateSelectedWidget({
    super.key,
    required this.startDateTime,
    required this.endDateTime,
  });
  final String startDateTime;
  final String endDateTime;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsetsDirectional.only(start: 27.w, bottom: 19.h),
          child: Text(
            "${S.of(context).start_date} : $startDateTime",
            style: AppStyles.style16(context)
                .copyWith(fontWeight: FontWeight.w600),
          ),
        ),
        Padding(
          padding: EdgeInsetsDirectional.only(start: 27.w),
          child: Text(
            "${S.of(context).end_date} : $endDateTime",
            style: AppStyles.style16(context)
                .copyWith(fontWeight: FontWeight.w600),
          ),
        ),
      ],
    );
  }
}
