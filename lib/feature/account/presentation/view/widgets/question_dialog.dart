import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sahab_project/core/const.dart';
import 'package:sahab_project/core/theme/app_color.dart';
import 'package:sahab_project/core/theme/app_textsyle.dart';
import 'package:sahab_project/core/utils/cache/cache_helper.dart';
import 'package:sahab_project/core/utils/widgets/circular_progress_indicator.dart';
import 'package:sahab_project/feature/account/presentation/manager/terminate_account_cubit/terminal_account_cubit.dart';
import 'package:sahab_project/feature/auth/presentation/pages/login/login_screen.dart';

import '../../../../../generated/l10n.dart';

class QuestionDialog extends StatelessWidget {
  const QuestionDialog({
    Key? key,
    required this.title,
    required this.content,
  }) : super(key: key);

  final String title, content;
// todo : finish translate
  @override
  Widget build(BuildContext context) {
    final terminalAccountCubit = BlocProvider.of<TerminalAccountCubit>(context);

    return AlertDialog(
      backgroundColor: AppColor.whiteColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      title: Text(
        title,
        style: AppStyles.style16w500(context)
            .copyWith(color: AppColor.darkBlueColor),
      ),
      content: Text(
        content,
        style: AppStyles.style14(context).copyWith(color: AppColor.brownColor),
      ),
      actions: [
        BlocConsumer<TerminalAccountCubit, TerminalAccountState>(
          listener: (context, state) {
            if (state is TerminalAccountSuccess) {
              CacheHelper.setData(key: Constant.kIsRegister, value: false);
              CacheHelper.clearUserData();
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => LoginScreen()),
                (route) => false,
              );
            } else if (state is TerminalAccountFailure) {
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: AppColor.redColor,
                  elevation: 6.0,
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  content: Text(
                    "Your Account not terminated",
                    style: AppStyles.style17semibold(context).copyWith(
                      color: Colors.white,
                    ),
                  ),
                  duration:
                      Duration(seconds: 3), // Adjust the duration as needed
                ),
              );
            }
          },
          builder: (context, state) {
            if (state is TerminalAccountLoading) {
              return Center(child: const CustomCircularProgressIndicator());
            } else {
              return Row(
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
                      await terminalAccountCubit.terminateAccount();
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
              );
            }
          },
        )
      ],
    );
  }
}
