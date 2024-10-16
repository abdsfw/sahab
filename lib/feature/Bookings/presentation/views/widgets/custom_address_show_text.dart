import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sahab_project/core/theme/app_textsyle.dart';

import '../../../../../core/utils/icons/app_icons.dart';

class CustomAddressShowText extends StatelessWidget {
  const CustomAddressShowText({
    super.key,
    required this.text,
    required this.text2,
  });
  final String text;
  final String text2;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgPicture.asset(
          AppIcons.checkout_location,
        ),
        SizedBox(
          width: 10.w,
        ),
        Expanded(
          child: Text(
            '$text : $text2',
            style: AppStyles.textStyle17w400Brown(context),
          ),
        ),
      ],
    );
  }
}
