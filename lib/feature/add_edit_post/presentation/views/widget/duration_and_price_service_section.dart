import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sahab_project/core/utils/widgets/custom_input_field.dart';
import '../../../../../core/theme/app_textsyle.dart';
import '../../../../../core/utils/widgets/custom_title_input_field.dart';
import '../../../../../generated/l10n.dart';
import '../../manager/next_post_service_cubit/next_post_service_cubit.dart';

class DurationAndPriceServiceSection extends StatelessWidget {
  const DurationAndPriceServiceSection({
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
        //? input Service Duration section
        CustomTitleInputField(
          title: S.of(context).service_duration_,
          textStyle: AppStyles.textstyle16w500DarkBlue(context)
              .copyWith(fontWeight: FontWeight.w600),
        ),
        SizedBox(height: 13.h),
        CustomInputField(
          controller: nextPostServiceCubit.durationController,
          hintText: "24 ${S.of(context).hour}",
          onChange: (p0) {
            nextPostServiceCubit.checkIfCanPost();
          },
          keyboardType: TextInputType.number,
          inputFormatters: [
            FilteringTextInputFormatter.allow(
                RegExp(r'^([1-9]|1[0-9]|2[0-4])$')),
            // FilteringTextInputFormatter.allow(
            //   // RegExp(r'^\d+\.?\d{0,2}'),
            // ),
            // FilteringTextInputFormatter.digitsOnly
          ],
        ),
        //? ----------------------------------------------------
        SizedBox(height: 36.h),
        //? input Service price* section
        CustomTitleInputField(
          title: S.of(context).service_price,
          textStyle: AppStyles.textstyle16w500DarkBlue(context)
              .copyWith(fontWeight: FontWeight.w600),
        ),
        SizedBox(height: 13.h),
        CustomInputField(
          controller: nextPostServiceCubit.priceController,
          hintText: "70.000 KWD",
          onChange: (p0) {
            nextPostServiceCubit.checkIfCanPost();
          },
          keyboardType: TextInputType.number,
          inputFormatters: [
            FilteringTextInputFormatter.allow(
              RegExp(r'^\d+\.?\d{0,2}'),
            ),
            // FilteringTextInputFormatter.digitsOnly
          ],
        ),
        //? ----------------------------------------------------
      ],
    );
  }
}
