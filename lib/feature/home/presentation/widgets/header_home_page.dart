import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sahab_project/core/const.dart';
import 'package:sahab_project/core/theme/app_textsyle.dart';

import '../../../../generated/l10n.dart';

class HeaderHomePage extends StatelessWidget {
  const HeaderHomePage({
    super.key,
  });
// todo : finish translate
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              S.of(context).find_the_best,
              style: AppStyles.style24(context),
            ),
            SizedBox(
              height: 0.5.h,
            ),
            Text(
              S.of(context).location,
              style: AppStyles.style20(context),
            )
          ],
        ),
        Container(
          height: 66.h,
          width: 66.w,
          child: Image.asset(Constant.knoLogoImage),
        )
      ],
    );
  }
}
