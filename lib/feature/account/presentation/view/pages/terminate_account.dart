import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sahab_project/core/theme/app_color.dart';
import 'package:sahab_project/core/theme/app_textsyle.dart';
import 'package:sahab_project/core/utils/icons/app_icons.dart';
import 'package:sahab_project/core/utils/widgets/app_button.dart';
import 'package:sahab_project/core/utils/widgets/custom_simple_app_bar_widget.dart';
import 'package:sahab_project/feature/account/presentation/manager/account_cubit/account_cubit.dart';

import '../../../../../generated/l10n.dart';

class TerminateAccount extends StatelessWidget {
  const TerminateAccount({super.key});
// todo : finish translate
  @override
  Widget build(BuildContext context) {
    AccountCubit accountCubit = AccountCubit.get(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomSimpleAppBarWidget(
              // onIconTap: () {
              //   Navigator.of(context).pop();
              // },
              iconPath: AppIcons.backArrow,
              appBarTitle: S.of(context).terminate_account,
            ),
            SizedBox(
              height: 70.h,
            ),
            Padding(
              padding: EdgeInsetsDirectional.only(start: 16.w, bottom: 30.h),
              child: SvgPicture.asset(AppIcons.error),
            ),
            Padding(
              padding: EdgeInsetsDirectional.only(start: 16.w),
              child: Text(
                // -- do_you_want_to_terminate_your_account --
                S.of(context).terminate_account_message,
                style: AppStyles.style20(context)
                    .copyWith(fontWeight: FontWeight.bold, color: Colors.black),
              ),
            ),
            SizedBox(
              height: 18.h,
            ),
            Padding(
              padding: EdgeInsetsDirectional.only(start: 16.w),
              child: Text(
                /*
                   "By terminating account your personal details,
                   addresses, orders will be removed from Sahab.
                   You will not be able to recover your account.",
                  */
                S.of(context).confirm_terminate_account_message,
                style: AppStyles.style17(context).copyWith(
                  height: 2,
                ),
              ),
            ),
            SizedBox(
              height: 72.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: AppButton(
                  onTap: () {
                    accountCubit.showQuestionDialog(context);
                  },
                  height: 50.h,
                  text: S.of(context).terminate_my_account,
                  color: AppColor.redColor,
                  radius: 5,
                  fontSize: 16.sp,
                  fontFamily: AppStyles.getFontFamily(context),
                  textColor: AppColor.whiteColor,
                  fontWeight: FontWeight.w500),
            )
          ],
        ),
      ),
    );
  }
}
