import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sahab_project/core/theme/app_textsyle.dart';
import 'package:sahab_project/core/utils/extension/date_time_extension.dart';

import '../../../../../core/utils/icons/app_icons.dart';

class CustomTimeShowText extends StatelessWidget {
  const CustomTimeShowText({
    super.key,
    required this.text,
    required this.date1,
    required this.date2,
  });
  final String text;
  final DateTime date1;
  final DateTime date2;
  @override
  Widget build(BuildContext context) {
    // int hour1 = date1.hour;
    // int hour2 = date2.hour;
    // final String minute1 = date1.minute.toString();
    // final String minute2 = date2.minute.toString();
    // String late1 = 'AM';
    // String late2 = 'AM';
    // if (hour1 > 12) {
    //   hour1 -= 12;
    //   late1 = 'PM';
    // }
    // if (hour2 > 12) {
    //   hour2 -= 12;
    //   late2 = 'PM';
    // }
    final String time1 = date1.timeOfDate();
    //= "$hour1:$minute1$late1";
    final String time2 = date2.timeOfDate(); //"$hour2:$minute2$late2";
    return Row(
      children: [
        SvgPicture.asset(
          AppIcons.timeIcon,
        ),
        SizedBox(
          width: 10.w,
        ),
        Expanded(
          child: Text(
            '$text : $time1 - $time2',
            style: AppStyles.textStyle17w400Brown(context),
          ),
        ),
      ],
    );
  }
}
