import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sahab_project/core/utils/functions/function.dart';
import 'package:sahab_project/feature/add_edit_post/presentation/manager/main_post_page_cubit/main_post_page_cubit.dart';
import 'package:sahab_project/feature/add_edit_post/presentation/manager/next_post_place_cubit/next_post_place_cubit.dart';

import '../../../../../core/theme/app_textsyle.dart';
import '../../../../../core/utils/widgets/custom_input_field.dart';
import '../../../../../core/utils/widgets/custom_title_input_field.dart';
import '../../../../../generated/l10n.dart';
import 'custom_drop_down_form_field.dart';
import 'custom_select_button_widget.dart';
import 'select_amenities_page.dart';

class PlaceDataInputSection extends StatelessWidget {
  const PlaceDataInputSection({
    super.key,
  });
  // todo : finish translate

  @override
  Widget build(BuildContext context) {
    NextPostPlaceCubit nextPostPlaceCubit = NextPostPlaceCubit.get(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //? input title section
        CustomTitleInputField(
          title: S.of(context).tittle_here,
          textStyle: AppStyles.textstyle16w500DarkBlue(context)
              .copyWith(fontWeight: FontWeight.w600),
        ),
        SizedBox(height: 6.h),
        CustomInputField(
          controller: nextPostPlaceCubit.titleController,
          hintText: S.of(context).royal_chalet_kuwait, //"Royal Chalet Kuwait",
          onChange: (p0) {
            nextPostPlaceCubit.checkIfCanMove(context);
          },
        ),
        //? ----------------------------------------------------

        SizedBox(height: 25.h),

        //? select category section
        CustomTitleInputField(
          title: S.of(context).select_category,
          textStyle: AppStyles.textstyle16w500DarkBlue(context)
              .copyWith(fontWeight: FontWeight.w600),
        ),
        SizedBox(height: 10.h),
        CustomDropDownFormField(
          value: nextPostPlaceCubit.selectCategoryDropDown,
          hintText: S.of(context).please_select,
          listItem: BlocProvider.of<MainPostPageCubit>(context)
              .categoryList
              .map((e) => e.title)
              .toList(),
          onChanged: (p0) {
            nextPostPlaceCubit.selectCategoryDropDown = p0;
            nextPostPlaceCubit.checkIfCanMove(context);
          },
          // validator: AppFunction.customDropDownFormFieldValidator,
          // (value) {
          //   if (value == null || value.isEmpty) {
          //     return "must not be empty";
          //   }
          //   return null;
          // },
        ),
        //? ----------------------------------------------------

        SizedBox(height: 25.h),

        //? select place type section
        CustomTitleInputField(
          title: S.of(context).place_type_,
          textStyle: AppStyles.textstyle16w500DarkBlue(context)
              .copyWith(fontWeight: FontWeight.w600),
        ),
        SizedBox(height: 10.h),
        CustomDropDownFormField(
          value: nextPostPlaceCubit.selectPlaceTypeDropDown,
          hintText: S.of(context).please_select,
          listItem: BlocProvider.of<MainPostPageCubit>(context)
              .placeTypeReturn(context),
          onChanged: (p0) {
            nextPostPlaceCubit.selectPlaceTypeDropDown =
                AppFunction.typeReturnEnglish(p0 ?? "");
            // print("kkk ${AppFunction.typeReturnEnglish(p0 ?? "")}");
            // print(nextPostPlaceCubit.selectPlaceTypeDropDown);
            nextPostPlaceCubit.checkIfCanMove(context);
          },
          // validator: AppFunction.customDropDownFormFieldValidator,
        ),
        //? ----------------------------------------------------

        SizedBox(height: 25.h),

        //? select amenities section
        CustomTitleInputField(
          title: S.of(context).amenities_,
          textStyle: AppStyles.textstyle16w500DarkBlue(context)
              .copyWith(fontWeight: FontWeight.w600),
        ),
        SizedBox(height: 10.h),
        CustomSelectButtonWidget(
          title: S.of(context).please_select,
          onTap: () {
            if (nextPostPlaceCubit.amenityList.isEmpty) {
              nextPostPlaceCubit.getAllAmenity(context);
            }
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const SelectAmenitiesPage(),
              ),
            );
          },
        ),
        //? ----------------------------------------------------

        SizedBox(height: 25.h),

        //? select Area type section
        CustomTitleInputField(
          title: S.of(context).area,
          textStyle: AppStyles.textstyle16w500DarkBlue(context)
              .copyWith(fontWeight: FontWeight.w600),
        ),
        SizedBox(height: 10.h),
        CustomDropDownFormField(
          value: nextPostPlaceCubit.selectAreaDropDown,
          hintText: S.of(context).please_select,
          listItem: BlocProvider.of<MainPostPageCubit>(context)
              .areaList
              .map((e) => e.area)
              .toList(),
          onChanged: (p0) {
            nextPostPlaceCubit.selectAreaDropDown = p0;
            nextPostPlaceCubit.checkIfCanMove(context);
          },
          // validator: AppFunction.customDropDownFormFieldValidator,
        ),
        //? ----------------------------------------------------
      ],
    );
  }
}
