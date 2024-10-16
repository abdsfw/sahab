import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/theme/app_color.dart';
import '../../../../../core/theme/app_textsyle.dart';
import '../../../../../generated/l10n.dart';

class NoteAndAgreeText extends StatelessWidget {
  const NoteAndAgreeText({
    super.key,
  });
// todo : finish translate

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            children: <TextSpan>[
              TextSpan(
                text: S.of(context).note,
                style: AppStyles.textStyle14w400GreyHint(context).copyWith(
                  color: AppColor.greyColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
              TextSpan(
                //? --  Commission rate 10% will be detected from price amount.
                text: S.of(context).commission,
                style: AppStyles.textStyle14w400GreyHint(context).copyWith(
                  color: AppColor.greyColor,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 18.h,
        ),
        RichText(
          text: TextSpan(
            children: <TextSpan>[
              TextSpan(
                text: S.of(context).by_posting_ad_you_agree_to_our,
                style: AppStyles.textStyle14w400GreyHint(context).copyWith(
                  color: AppColor.greyColor,
                  fontWeight: FontWeight.w400,
                ),
              ),
              TextSpan(
                text: S.of(context).term_Conditions,
                style: AppStyles.textStyle14w400GreyHint(context).copyWith(
                  color: AppColor.greyColor,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
