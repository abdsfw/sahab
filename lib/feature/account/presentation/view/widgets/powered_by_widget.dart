import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sahab_project/core/theme/app_color.dart';
import 'package:sahab_project/core/theme/app_textsyle.dart';

class PoweredByWidget extends StatelessWidget {
  const PoweredByWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      children: [
        Text(
          "Version 1.0.0",
          style: AppStyles.style14Bold(context),
        ),
        SizedBox(
          height: 5.h,
        ),
        Text(
          "Powered By Line  ",
          style: AppStyles.style14(context).copyWith(color: AppColor.poweredBy),
        ),
        SizedBox(
          height: 19.h,
        ),
      ],
    );
  }
}
