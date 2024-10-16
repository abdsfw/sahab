import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sahab_project/core/utils/widgets/custom_input_field.dart';
import 'package:sahab_project/feature/add_edit_post/presentation/manager/main_post_page_cubit/main_post_page_cubit.dart';
import 'package:sahab_project/feature/add_edit_post/presentation/views/widget/custom_drop_down_form_field.dart';
import '../../../../../core/theme/app_textsyle.dart';
import '../../../../../core/utils/widgets/custom_title_input_field.dart';
import '../../../../../generated/l10n.dart';
import '../../manager/next_post_service_cubit/next_post_service_cubit.dart';

class ServiceDataInputSection extends StatelessWidget {
  const ServiceDataInputSection({
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
        //? input title section
        CustomTitleInputField(
          title: S.of(context).tittle_here,
          textStyle: AppStyles.textstyle16w500DarkBlue(context)
              .copyWith(fontWeight: FontWeight.w600),
        ),
        SizedBox(height: 6.h),
        CustomInputField(
          controller: nextPostServiceCubit.titleController,
          hintText: S.of(context).royal_chalet_kuwait, //"Royal Chalet Kuwait",
          onChange: (p0) {
            nextPostServiceCubit.checkIfCanMove(context);
          },
        ),
        //? ----------------------------------------------------

        SizedBox(height: 25.h),

        //? select Service section
        CustomTitleInputField(
          title: S.of(context).select_service,
          textStyle: AppStyles.textstyle16w500DarkBlue(context)
              .copyWith(fontWeight: FontWeight.w600),
        ),
        SizedBox(height: 10.h),
        CustomDropDownFormField(
          value: nextPostServiceCubit.selectServiceDropDown,
          hintText: S.of(context).please_select,
          listItem: BlocProvider.of<MainPostPageCubit>(context)
              .serviceList
              .map((e) => e.title)
              .toList(),
          onChanged: (p0) {
            nextPostServiceCubit.selectServiceDropDown = p0;
            nextPostServiceCubit.checkIfCanMove(context);
          },
        ),
        //? ----------------------------------------------------

        SizedBox(height: 25.h),
        //? input About Service section

        CustomTitleInputField(
          title: S.of(context).about_service,
          textStyle: AppStyles.textStyle17w400Brown(context).copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 6.h),
        CustomInputField(
          controller: nextPostServiceCubit.aboutServiceController,
          hintText: S.of(context).enter_here,
          minLine: 4,
          maxLine: 4,
          onChange: (p0) {
            nextPostServiceCubit.checkIfCanMove(context);
          },
          // validator: AppFunction.customFormFieldValidator,
        ),
        //? ----------------------------------------------------
      ],
    );
  }
}
