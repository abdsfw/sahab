import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sahab_project/core/theme/app_color.dart';
import 'package:sahab_project/core/utils/widgets/custom_two_button.dart';
import 'package:sahab_project/feature/add_edit_post/presentation/views/widget/duration_and_price_service_section.dart';
import 'package:sahab_project/feature/add_edit_post/presentation/views/widget/notice_period_and_capacity_section.dart';
import '../../../../../generated/l10n.dart';
import '../../manager/add_post_cubit/add_post_cubit.dart';
import '../../manager/next_post_service_cubit/next_post_service_cubit.dart';
import '../../manager/page_view_cubit/page_view_cubit.dart';
import 'note_and_agree_text.dart';

class StepTwoAddServicePost extends StatelessWidget {
  const StepTwoAddServicePost({
    super.key,
    required this.isEdit,
    required this.postId,
  });
  final bool isEdit;
  final int? postId;
// todo : finish translate
  @override
  Widget build(BuildContext context) {
    NextPostServiceCubit nextPostServiceCubit =
        NextPostServiceCubit.get(context);
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //? duration and price service inputs.
          const DurationAndPriceServiceSection(),
          //? ----------------------------------
          SizedBox(height: 25.h),

          //? notice period and capacity service inputs.
          const NoticePeriodAndCapacitySection(),
          //? ----------------------------------

          SizedBox(height: 30.h),

          //? Note and term & conditions
          const NoteAndAgreeText(),
          //? ---------------------------
          SizedBox(height: 24.h),

          BlocBuilder<NextPostServiceCubit, NextPostServiceState>(
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
                  nextPostServiceCubit.navigateToPreviousPageView();

                  //? this function for change step state
                  BlocProvider.of<PageViewCubit>(context).goToFirstPageView();
                  //? ---------------------------------------------------
                },
                onTap2: state is CanPostState
                    ? () {
                        // todo/ here we should call function that post
                        // todo/ data to server from `AddPostCubit`
                        //! demo mode

                        if (isEdit) {
                          BlocProvider.of<AddPostCubit>(context)
                              .editPostService(context,
                                  servicePostId: postId ?? -1);
                        } else {
                          BlocProvider.of<AddPostCubit>(context)
                              .sendAddPostService(context);
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
