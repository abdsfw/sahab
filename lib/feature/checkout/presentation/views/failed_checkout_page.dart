import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sahab_project/core/theme/app_color.dart';
import 'package:sahab_project/core/utils/icons/app_icons.dart';
import 'package:sahab_project/core/utils/widgets/app_button.dart';

import '../../../../core/theme/app_textsyle.dart';
import '../../../../generated/l10n.dart';

class FailedCheckoutPage extends StatelessWidget {
  const FailedCheckoutPage(
      {super.key, this.onTap, this.isBeforeMyFatorah = false});
// todo : finish translate
  final void Function()? onTap;
  final bool isBeforeMyFatorah;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      width: double.infinity,
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.12),
                    Center(child: SvgPicture.asset(AppIcons.errorPhoto)),
                    SizedBox(
                      height: 35.h,
                    ),
                    Text(
                      S.of(context).sorry,
                      style: AppStyles.textStyle30w500black2(context),
                    ),
                    Text(
                      S.of(context).your_booking_could_not_been_placed,
                      style: AppStyles.textStyle30w500black2(context).copyWith(
                        fontSize: 16.sp,
                      ),
                    ),
                    SizedBox(height: 12.h),
                    Text(
                      /*
                      "Sorry! An error occurred while we were 
                      Processing your payment, 
                      please try again! The order was not placed!",
                      */
                      S.of(context).error_occurred_while_Processing_payment,
                      style: AppStyles.textStyle14w400GreyHint(context),
                    ),
                    SizedBox(height: 12.h),
                    Text(
                      "Error code: 01",
                      style: AppStyles.textStyle14w500DarkBlue(context)
                          .copyWith(color: AppColor.black2Color),
                    ),
                  ],
                ),
              ),
            ),
            AppButton(
              onTap: isBeforeMyFatorah
                  ? () {
                      Navigator.of(context).pop();
                      Navigator.of(context).pop();
                    }
                  : onTap,
              text: S.of(context).try_again,
              color: AppColor.blueColor,
              radius: 5.r,
              height: 50.h,
              fontSize: 16.sp,
              fontFamily: AppStyles.getFontFamily(context),
              textColor: AppColor.whiteColor,
              fontWeight: FontWeight.w600,
            )
          ],
        ),
      ),
    );
  }
}
