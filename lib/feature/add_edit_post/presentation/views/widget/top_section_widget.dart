import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sahab_project/core/enums/type_post_enum.dart';
import 'package:sahab_project/feature/add_edit_post/presentation/manager/next_post_place_cubit/next_post_place_cubit.dart';
import 'package:sahab_project/feature/add_edit_post/presentation/manager/next_post_service_cubit/next_post_service_cubit.dart';
import 'package:sahab_project/feature/add_edit_post/presentation/manager/page_view_cubit/page_view_cubit.dart';
import 'package:sahab_project/feature/add_edit_post/presentation/manager/select_photo_cubit/select_photo_cubit.dart';

import '../../../../../core/enums/type_adv_enum.dart';
import '../../../../../core/theme/app_color.dart';
import '../../../../../core/utils/widgets/custom_app_title.dart';
import '../../../../../core/utils/widgets/custom_two_button.dart';
import '../../../../../generated/l10n.dart';
import '../../manager/toggle_cubit/toggle_cubit.dart';
import 'step_widget.dart';

class TopSectionWidget extends StatelessWidget {
  const TopSectionWidget({
    super.key,
    required this.isEdit,
  });
  final bool isEdit;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const StepWidget(),
        if (!isEdit)
          BlocBuilder<PageViewCubit, PageViewState>(
            builder: (context, state) {
              if (state is! SecondPageViewState) {
                return FadeIn(
                  // delay: const Duration(seconds: 1),
                  // duration: Duration(seconds: 1),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 24.h),
                      CustomAppTitle(
                        //? ---- Where you want to\nadd post ad? ----
                        title: S.of(context).choose_type_of_add_post,
                      ),
                      SizedBox(height: 12.h),
                      BlocBuilder<ToggleCubit, ToggleState>(
                        builder: (context, state) {
                          return CustomTwoButton(
                            // buttonColor1: AppColor.blueColor,
                            // buttonColor2: buttonColor2,
                            buttonColor1: state is AddPlacePostState
                                ? AppColor.blueColor
                                : AppColor.grey2Color,
                            buttonColor2: state is AddServicesPostState
                                ? AppColor.blueColor
                                : AppColor.grey2Color,
                            textColor1: state is AddPlacePostState
                                ? const Color(0xffFFFFFF)
                                : AppColor.brownColor,
                            textColor2: state is AddServicesPostState
                                ? const Color(0xffFFFFFF)
                                : AppColor.brownColor,
                            text1: S.of(context).place,
                            text2: S.of(context).services,
                            onTap1: () {
                              //? this function for change state in toggle cubit
                              BlocProvider.of<ToggleCubit>(context)
                                  .changeAddPostTo(TypeToggle.place);

                              //? because both place and service depended on
                              //? data in Photo cubit so we have to clear when we toggle
                              BlocProvider.of<SelectPhotoCubit>(context)
                                  .clearCubitData();

                              //? because both place and service depended on
                              //? data in photo and the previous function will
                              //? delete image file so next button will be updated
                              BlocProvider.of<NextPostPlaceCubit>(context)
                                  .checkIfCanMove(context);

                              //? this function for step widget
                              //? to be in initial state
                              BlocProvider.of<PageViewCubit>(context)
                                  .goToFirstPageView();
                            },
                            onTap2: () {
                              //? this function for change state in toggle cubit
                              BlocProvider.of<ToggleCubit>(context)
                                  .changeAddPostTo(TypeToggle.service);

                              //? because both place and service depended on
                              //? data in Photo cubit so we have to cleat when we toggle
                              BlocProvider.of<SelectPhotoCubit>(context)
                                  .clearCubitData();

                              //? because both place and service depended on
                              //? data in photo and the previous function will
                              //? delete image file so next button will be updated
                              BlocProvider.of<NextPostServiceCubit>(context)
                                  .checkIfCanMove(context);

                              //? this function for step widget
                              //? to be in initial state
                              BlocProvider.of<PageViewCubit>(context)
                                  .goToFirstPageView();
                            },
                          );
                        },
                      ),
                    ],
                  ),
                );
              }
              return const SizedBox();
            },
          ),
      ],
    );
  }
}
