import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sahab_project/core/theme/app_color.dart';
import 'package:sahab_project/core/theme/app_textsyle.dart';
import 'package:sahab_project/core/utils/icons/app_icons.dart';
import 'package:sahab_project/feature/account/presentation/view/pages/terminate_account.dart';

import '../../../../../generated/l10n.dart';

class TerminateButton extends StatelessWidget {
  const TerminateButton({
    super.key,
  });
// todo : finish translate
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const TerminateAccount(),
            ));
      },
      child: Container(
        width: double.infinity,
        height: 52.h,
        margin: EdgeInsets.symmetric(horizontal: 16.w),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), color: Colors.white),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsetsDirectional.only(start: 12.w),
              child: Text(
                S.of(context).terminate_account,
                style: AppStyles.style16(context)
                    .copyWith(color: AppColor.redColor),
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.only(end: 12.w),
              child: SvgPicture.asset(
                AppIcons.termiate,
                width: 26.w,
                height: 24.h,
              ),
            )
          ],
        ),
      ),
    );
  }
}
