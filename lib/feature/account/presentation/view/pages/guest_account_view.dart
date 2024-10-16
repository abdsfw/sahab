import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sahab_project/core/theme/app_color.dart';
import 'package:sahab_project/core/theme/app_textsyle.dart';
import 'package:sahab_project/core/utils/widgets/app_button.dart';
import 'package:sahab_project/feature/account/presentation/view/widgets/my_account_text.dart';
import 'package:sahab_project/feature/auth/presentation/pages/login/login_screen.dart';

import '../../../../../generated/l10n.dart';
import '../widgets/powered_by_widget.dart';
import '../widgets/setting_option_list.dart';
import '../widgets/support_option_list.dart';

class GuestAccountView extends StatelessWidget {
  const GuestAccountView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: GuestAccountBody(),
    );
  }
}

class GuestAccountBody extends StatelessWidget {
  const GuestAccountBody({super.key});
// todo : finish translate
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: ListView(
        clipBehavior: Clip.none,
        children: [
          Padding(
            padding: const EdgeInsetsDirectional.only(top: 12.5),
            child: const MyAccountText(),
          ),
          SizedBox(
            height: 21.h,
          ),
          Text(
            S.of(context).hello_guest,
            style: AppStyles.style18semibold(context),
          ),
          SizedBox(
            height: 19.h,
          ),
          AppButton(
            width: double.infinity,
            onTap: () {
              Navigator.pushAndRemoveUntil(
                  context,
                  CupertinoPageRoute(
                    builder: (context) => LoginScreen(),
                  ),
                  (route) => false);
            },
            //----- "Login / Sign Up" --------,
            text: S.of(context).Login_Sign_Up,
            color: AppColor.blueColor,
            radius: 5.r,
            height: 50.h,
            fontSize: 16.sp,
            fontFamily: AppStyles.getFontFamily(context),
            textColor: const Color(0xffFFFFFF),
            fontWeight: FontWeight.w600,
          ),
          SizedBox(
            height: 26.h,
          ),
          const SettingOptionList(),
          SizedBox(
            height: 12.h,
          ),
          const SupportOptionList(
            isGuest: true,
          ),
          SizedBox(
            height: 20.h,
          ),
          const PoweredByWidget()
        ],
      ),
    );
  }
}
