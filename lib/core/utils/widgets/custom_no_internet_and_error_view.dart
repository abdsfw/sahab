import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sahab_project/core/theme/app_color.dart';
import 'package:sahab_project/core/theme/app_textsyle.dart';
import 'package:sahab_project/core/utils/icons/app_icons.dart';
import 'package:sahab_project/core/utils/widgets/app_button.dart';
import 'package:sahab_project/core/utils/widgets/custom_simple_app_bar_widget.dart';

import '../../../generated/l10n.dart';

class CustomNoInternetAndErrorView extends StatelessWidget {
  const CustomNoInternetAndErrorView({
    super.key,
    this.onTryAgainButton,
    this.withReturn = false,
    this.errorMessage,
  });
  final String? errorMessage;
  final void Function()? onTryAgainButton;
  final bool withReturn;
  // todo : finish translate
  @override
  Widget build(BuildContext context) {
    return Column(
      // mainAxisAlignment: MainAxisAlignment.center,
      // crossAxisAlignment: CrossAxisAlignment.stretch,
      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        if (withReturn)
          CustomSimpleAppBarWidget(
            appBarTitle: "",
          ),
        const Expanded(
          flex: 2,
          child: SizedBox(
              // height: 107.h,
              ),
        ),
        // Padding(
        //   padding: EdgeInsets.symmetric(horizontal: 130.w),
        //   child: AspectRatio(
        //     aspectRatio: 130.w / 70.h,
        //     child: SvgPicture.asset(
        //       AppIcons.sahabText,
        //     ),
        //   ),
        // ),

        // SizedBox(
        //   height: 96.h,
        // ),
        const Expanded(flex: 2, child: SizedBox()),
        // SvgPicture.asset(AppIcons.noInternet),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 130.w),
          child: AspectRatio(
            aspectRatio: 120.w / 124.h,
            child: SvgPicture.asset(
              AppIcons.noInternet,
            ),
          ),
        ),
        // SizedBox(
        //   height: 44.h,
        // ),
        const Expanded(child: SizedBox()),
        Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Text(
              errorMessage != null
                  ? S.of(context).general_error
                  : S.of(context).your_Connection_is_Lost,
              textAlign: TextAlign.center,
              style: AppStyles.style22WhiteSemiBold(context)
                  .copyWith(color: AppColor.darkBlueColor),
            ),
          ),
        ),
        SizedBox(
          height: 15.h,
        ),
        Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Text(
              errorMessage != null
                  ? errorMessage!
                  : S.of(context).check_internet_message,
              textAlign: TextAlign.center,
              style: AppStyles.style16(context)
                  .copyWith(color: AppColor.darkBlueColor),
            ),
          ),
        ),
        // SizedBox(
        //   height: 117.h,
        // ),
        const Expanded(flex: 2, child: SizedBox()),
        Padding(
          padding: const EdgeInsetsDirectional.only(
            start: 16,
            end: 16,
            bottom: 16,
          ),
          child: AppButton(
              height: 50.h,
              width: double.infinity,
              onTap: onTryAgainButton,
              text: S.of(context).try_again,
              color: AppColor.blueColor,
              radius: 5,
              fontSize: 16.sp,
              fontFamily: AppStyles.getFontFamily(context),
              textColor: AppColor.whiteColor,
              fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}
