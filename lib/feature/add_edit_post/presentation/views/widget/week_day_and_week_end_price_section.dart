import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/theme/app_textsyle.dart';
import '../../../../../core/utils/widgets/custom_input_field.dart';
import '../../../../../core/utils/widgets/custom_title_input_field.dart';
import '../../../../../generated/l10n.dart';
import '../../manager/next_post_place_cubit/next_post_place_cubit.dart';

class WeekDayAndWeekEndPriceSection extends StatelessWidget {
  const WeekDayAndWeekEndPriceSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    NextPostPlaceCubit nextPostPlaceCubit = NextPostPlaceCubit.get(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //? input WeekDAY price section
        CustomTitleInputField(
          title: S
              .of(context)
              .weekday_price_sun_to_wed, //"Weekday price* (Sun to Wed)",
          textStyle: AppStyles.textstyle16w500DarkBlue(context)
              .copyWith(fontWeight: FontWeight.w600),
        ),
        SizedBox(height: 13.h),
        CustomInputField(
          controller: nextPostPlaceCubit.weekdayController,
          hintText: "70.000 KWD",
          onChange: (p0) {
            nextPostPlaceCubit.checkIfCanPost();
          },
          keyboardType: TextInputType.number,
          inputFormatters: [
            FilteringTextInputFormatter.allow(
              RegExp(r'^\d+\.?\d{0,2}'),
            ),
            // FilteringTextInputFormatter.digitsOnly
          ],
          // validator: AppFunction.customFormFieldValidator,
          // (value) {
          //   if (value!.isEmpty) {
          //     return "must not be empty";
          //   }
          //   return null;
          // },
        ),
        //? ----------------------------------------------------
        SizedBox(height: 24.h),
        //? input WeekEND price section
        CustomTitleInputField(
          title: S
              .of(context)
              .weekend_price_thu_to_sat, //"Weekend price* (Thu to Sat)",
          textStyle: AppStyles.textstyle16w500DarkBlue(context)
              .copyWith(fontWeight: FontWeight.w600),
        ),
        SizedBox(height: 13.h),
        CustomInputField(
          controller: nextPostPlaceCubit.weekendController,
          hintText: "56.000 KWD",
          onChange: (p0) {
            nextPostPlaceCubit.checkIfCanPost();
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
