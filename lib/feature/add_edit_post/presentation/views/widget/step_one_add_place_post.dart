import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sahab_project/core/enums/type_post_enum.dart';
import 'package:sahab_project/core/theme/app_textsyle.dart';
import 'package:sahab_project/feature/add_edit_post/presentation/manager/next_post_place_cubit/next_post_place_cubit.dart';
import 'package:sahab_project/feature/add_edit_post/presentation/manager/page_view_cubit/page_view_cubit.dart';

import '../../../../../core/theme/app_color.dart';
import '../../../../../core/utils/widgets/app_button.dart';
import '../../../../../generated/l10n.dart';
import 'place_data_input_section.dart';
import 'place_data_input_section2.dart';
import 'upload_images_section.dart';

class StepOneAddPlacePost extends StatelessWidget {
  const StepOneAddPlacePost({
    super.key,
  });
  // todo: finish translate
  @override
  Widget build(BuildContext context) {
    NextPostPlaceCubit nextPostPlaceCubit = NextPostPlaceCubit.get(context);
    return SingleChildScrollView(
      child:
          //! there are important comment below for `Form comments`
          // Form(
          // autovalidateMode: AutovalidateMode.always,
          // key: nextPostPlaceCubit.formKey,
          // child:
          Column(
        children: [
          //? input title && category && place Type && Amenities && Area.
          const PlaceDataInputSection(),
          //? ----------------------------------------------------

          SizedBox(height: 38.h),

          //? input address && about Place.
          const PlaceDataInputSection2(),
          //? ----------------------------------------------------

          SizedBox(height: 23.h),

          //? Upload images section
          const UploadImagesSection(
            typePost: TypeToggle.place,
          ),
          //? ----------------------------------------------------

          SizedBox(height: 23.h),

          //? Next button
          BlocBuilder<NextPostPlaceCubit, NextPostPlaceState>(
            builder: (context, state) {
              return AppButton(
                width: double.infinity,
                height: 50.h,
                onTap: state is CanMovePostState
                    ? () {
                        //! important commit
                        //? here we replace checking of fields using `formKey`
                        //? to checking on controllers so we had comment all things that related to `formKey`
                        // if (nextPostPlaceCubit.formKey.currentState!.validate()) {
                        print(
                            "################## all right ##################");
                        nextPostPlaceCubit.navigateToNextPageView();

                        //? this function for change step state
                        BlocProvider.of<PageViewCubit>(context)
                            .goToSecondPageView();
                        // }
                      }
                    : null,
                text: S.of(context).next,
                color: state is CanMovePostState
                    ? AppColor.blueColor
                    : AppColor.stepColor,
                radius: 5.r,
                fontSize: 16.sp,
                fontFamily: AppStyles.getFontFamily(context),
                textColor: const Color(0xffFFFFFF),
                fontWeight: FontWeight.w600,
              );
            },
          ),
          //? ----------------------------------------------------
          SizedBox(height: 30.h),
        ],
      ),
      // ),
    );
  }
}
