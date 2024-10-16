import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:sahab_project/core/theme/app_textsyle.dart';

import '../../../../../core/utils/icons/app_icons.dart';

class CustomDateShowText extends StatelessWidget {
  const CustomDateShowText({
    super.key,
    required this.text,
    required this.date,
  });
  final String text;
  final DateTime date;
  @override
  Widget build(BuildContext context) {
    final String showDate = DateFormat('yyyy/MM/dd', 'en').format(date);
    return Row(
      children: [
        SvgPicture.asset(
          AppIcons.date,
        ),
        SizedBox(
          width: 10.w,
        ),
        Expanded(
          child: Text(
            '$text : $showDate',
            style: AppStyles.textStyle17w400Brown(context),
          ),
        ),
      ],
    );
  }
}
