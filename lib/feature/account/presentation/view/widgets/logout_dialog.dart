import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sahab_project/core/const.dart';
import 'package:sahab_project/core/theme/app_color.dart';
import 'package:sahab_project/core/theme/app_textsyle.dart';
import 'package:sahab_project/core/utils/cache/cache_helper.dart';
import 'package:sahab_project/feature/auth/presentation/pages/login/login_screen.dart';
import 'package:sahab_project/generated/l10n.dart';

class LogoutDialog extends StatelessWidget {
  const LogoutDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColor.whiteColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      title: Text(
        S.of(context).log_out, //'Log out',
        style: AppStyles.style16w500(context)
            .copyWith(color: AppColor.darkBlueColor),
      ),
      content: Text(
        S.of(context).do_you_want_to_log_out, // "Do you want to log out?",
        style: AppStyles.style14(context).copyWith(color: AppColor.brownColor),
      ),
      actions: [
        Row(
          children: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                S.of(context).no,
                style: AppStyles.style16(context).copyWith(
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
            ),
            TextButton(
              onPressed: () async {
                await CacheHelper.setData(
                    key: Constant.kIsRegister, value: false);
                await CacheHelper.clearUserData();

                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                  (route) => false,
                );
              },
              child: Container(
                width: 73.w,
                height: 40.h,
                decoration: ShapeDecoration(
                  color: const Color(0xFF567AB8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                child: Center(
                  child: Text(
                    S.of(context).yes,
                    style: AppStyles.style16(context).copyWith(
                      fontWeight: FontWeight.w600,
                      color: AppColor.whiteColor,
                    ),
                  ),
                ),
              ),
            )
          ],
        )
      ],
    );
  }
}
