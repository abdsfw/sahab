import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sahab_project/core/utils/widgets/custom_input_field.dart';
import '../../../../../core/theme/app_textsyle.dart';
import '../../../../../core/utils/widgets/custom_title_input_field.dart';
import '../../../../../generated/l10n.dart';
import '../../manager/next_post_service_cubit/next_post_service_cubit.dart';

class NoticePeriodAndCapacitySection extends StatelessWidget {
  const NoticePeriodAndCapacitySection({
    super.key,
  });
// todo : finish translate
  @override
  Widget build(BuildContext context) {
    NextPostServiceCubit nextPostServiceCubit =
        NextPostServiceCubit.get(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //? input Notice period* section
        CustomTitleInputField(
          title: S.of(context).notice_period,
          textStyle: AppStyles.textstyle16w500DarkBlue(context)
              .copyWith(fontWeight: FontWeight.w600),
        ),
        SizedBox(height: 13.h),
        CustomInputField(
          controller: nextPostServiceCubit.noticePeriodController,
          hintText:
              "24 ${S.of(context).hour}", //S.of(context).royal_chalet_kuwait, //"Royal Chalet Kuwait",
          onChange: (p0) {
            nextPostServiceCubit.checkIfCanPost();
          },
          keyboardType: TextInputType.number,
          inputFormatters: [
            // FilteringTextInputFormatter.allow(
            //   RegExp(r'^\d+\.?\d{0,2}'),
            // ),
            FilteringTextInputFormatter.digitsOnly
          ],
        ),
        //? ----------------------------------------------------
        SizedBox(height: 25.h),
        //? input Capacity* section
        CustomTitleInputField(
          title: S.of(context).capacity,
          textStyle: AppStyles.textstyle16w500DarkBlue(context)
              .copyWith(fontWeight: FontWeight.w600),
        ),
        SizedBox(height: 13.h),
        CustomInputField(
          controller: nextPostServiceCubit.capacityController,
          hintText:
              "10", //S.of(context).royal_chalet_kuwait, //"Royal Chalet Kuwait",
          onChange: (p0) {
            nextPostServiceCubit.checkIfCanPost();
          },
          keyboardType: TextInputType.number,
          inputFormatters: [
            // FilteringTextInputFormatter.allow(
            //   RegExp(r'^\d+\.?\d{0,2}'),
            // ),
            FilteringTextInputFormatter.digitsOnly
          ],
        ),
        //? ----------------------------------------------------
      ],
    );
  }
}
