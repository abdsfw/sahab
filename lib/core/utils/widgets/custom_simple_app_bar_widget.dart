import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sahab_project/core/utils/icons/app_icons.dart';
import 'package:sahab_project/feature/boarding/presentation/manager/lang_cubit/lang_cubit.dart';

import '../../theme/app_textsyle.dart';
import 'custom_back_button.dart';

class CustomSimpleAppBarWidget extends StatelessWidget {
  CustomSimpleAppBarWidget({
    super.key,
    this.onIconTap,
    this.iconPath = AppIcons.backArrow,
    required this.appBarTitle,
    this.trialing,
  });
  final void Function()? onIconTap;
  String? iconPath;
  final String appBarTitle;
  final Widget? trialing;
  @override
  Widget build(BuildContext context) {
    if (BlocProvider.of<LangCubit>(context).lang == "ar")
      iconPath = AppIcons.rightArrow;
    return Padding(
      padding: EdgeInsetsDirectional.only(
        top: 8.h,
        start: 16.w,
      ),
      child: SafeArea(
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(00),
              child: CustomBackButton(
                onTap: onIconTap ??
                    () {
                      Navigator.of(context).pop();
                    },
                iconPath: iconPath!,
              ),
            ),
            SizedBox(
              width: 8.w,
            ),
            Expanded(
              child: Text(
                appBarTitle,
                style: AppStyles.textStyle16w400DarkBlue(context)
                    .copyWith(color: Colors.black),
              ),
            ),
            trialing ?? const SizedBox(),
          ],
        ),
      ),
    );
  }
}
