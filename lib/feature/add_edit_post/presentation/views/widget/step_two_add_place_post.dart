import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sahab_project/feature/add_edit_post/presentation/manager/add_post_cubit/add_post_cubit.dart';
import 'package:sahab_project/feature/add_edit_post/presentation/views/widget/note_and_agree_text.dart';
import 'package:sahab_project/feature/add_edit_post/presentation/views/widget/special_days_input_section.dart';
import 'package:sahab_project/feature/add_edit_post/presentation/views/widget/week_day_and_week_end_price_section.dart';
import '../../../../../core/theme/app_color.dart';
import '../../../../../core/utils/widgets/custom_two_button.dart';
import '../../../../../generated/l10n.dart';
import '../../manager/next_post_place_cubit/next_post_place_cubit.dart';
import '../../manager/page_view_cubit/page_view_cubit.dart';

class StepTwoAddPlacePost extends StatelessWidget {
  const StepTwoAddPlacePost({
    super.key,
    required this.isEdit,
    this.postID,
  });
  final bool isEdit;
  final int? postID;
  // todo : finish translate
  @override
  Widget build(BuildContext context) {
    NextPostPlaceCubit nextPostPlaceCubit = NextPostPlaceCubit.get(context);
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //? weekEnd and weekDay inputs
          const WeekDayAndWeekEndPriceSection(),
          //? ---------------------------------
          SizedBox(height: 40.h),
          //? Special days input
          const SpecialDaysInputSection(),
          //? ----------------------------
          SizedBox(height: 24.h),

          //? Note and term & conditions
          const NoteAndAgreeText(),
          //? ---------------------------
          SizedBox(height: 24.h),

          BlocBuilder<NextPostPlaceCubit, NextPostPlaceState>(
            builder: (context, state) {
              return CustomTwoButton(
                buttonColor1: AppColor.yellowButtonColor,
                buttonColor2: state is CanPostState
                    ? AppColor.blueColor
                    : AppColor.stepColor,
                text1: S.of(context).back,
                text2:
                    isEdit ? S.of(context).edit_post : S.of(context).add_post,
                textColor1: AppColor.whiteColor,
                textColor2: AppColor.whiteColor,
                onTap1: () {
                  nextPostPlaceCubit.navigateToPreviousPageView();
                  //? this function for change step state
                  BlocProvider.of<PageViewCubit>(context).goToFirstPageView();
                  //? -----------------------------------------------------
                },
                onTap2: state is CanPostState
                    ? () {
                        if (isEdit) {
                          BlocProvider.of<AddPostCubit>(context).editPostPlace(
                              context,
                              placePostId: postID ?? -1);
                        } else {
                          BlocProvider.of<AddPostCubit>(context)
                              .sendAddPostPlace(context);
                        }
                      }
                    : null,
              );
            },
          ),
          SizedBox(height: 30.h),
        ],
      ),
    );
  }
}
