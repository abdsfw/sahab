import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sahab_project/feature/add_edit_post/presentation/manager/next_post_place_cubit/next_post_place_cubit.dart';

import '../../../../../core/theme/app_textsyle.dart';
import '../../../../../core/utils/widgets/custom_input_field.dart';
import '../../../../../core/utils/widgets/custom_title_input_field.dart';
import '../../../../../generated/l10n.dart';

class PlaceDataInputSection2 extends StatelessWidget {
  const PlaceDataInputSection2({
    super.key,
  });
// todo : finish translate

  @override
  Widget build(BuildContext context) {
    NextPostPlaceCubit nextPostPlaceCubit = NextPostPlaceCubit.get(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //? input address section
        CustomTitleInputField(
          title: S.of(context).address_,
          textStyle: AppStyles.textStyle17w400Brown(context).copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 6.h),
        CustomInputField(
          controller: nextPostPlaceCubit.addressController,
          hintText: S.of(context).enter_here,
          minLine: 4,
          maxLine: 4,
          onChange: (p0) {
            nextPostPlaceCubit.checkIfCanMove(context);
          },
          // validator: AppFunction.customFormFieldValidator,
        ),
        //? ----------------------------------------------------

        SizedBox(height: 25.h),

        //? input About Place section
        CustomTitleInputField(
          title: S.of(context).about_place,
          textStyle: AppStyles.textStyle17w400Brown(context).copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 6.h),
        CustomInputField(
          controller: nextPostPlaceCubit.aboutPlaceController,
          hintText: S.of(context).enter_here,
          minLine: 4,
          maxLine: 4,
          onChange: (p0) {
            nextPostPlaceCubit.checkIfCanMove(context);
          },
          // validator: AppFunction.customFormFieldValidator,
        ),
        //? ----------------------------------------------------
      ],
    );
  }
}
