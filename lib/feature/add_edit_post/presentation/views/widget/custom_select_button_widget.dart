import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sahab_project/feature/boarding/presentation/manager/lang_cubit/lang_cubit.dart';

import '../../../../../core/theme/app_color.dart';
import '../../../../../core/theme/app_textsyle.dart';
import '../../../../../core/utils/icons/app_icons.dart';

class CustomSelectButtonWidget extends StatelessWidget {
  const CustomSelectButtonWidget({
    super.key,
    required this.title,
    this.onTap,
  });
  final String title;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColor.whiteColor,
      borderRadius: BorderRadius.circular(
        5,
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(
          5,
        ),
        onTap: onTap,
        child: Container(
          height: 50.h,
          decoration: BoxDecoration(
            // color: AppColor.whiteColor,
            borderRadius: BorderRadius.circular(
              5,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // SizedBox(
              //   width: 16.w,
              // ),
              Expanded(
                child: Padding(
                  padding: EdgeInsetsDirectional.only(start: 20.w),
                  child: Text(
                    title,
                    maxLines: 2,
                    style: AppStyles.textStyle14w500DarkBlue(context),
                  ),
                ),
              ),
              // Expanded(child: SizedBox()),
              Padding(
                padding: EdgeInsetsDirectional.only(end: 20.w),
                child: BlocProvider.of<LangCubit>(context).lang == "en"
                    ? SvgPicture.asset(AppIcons.rightArrow2)
                    : SvgPicture.asset(
                        AppIcons.leftArrow2,
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
