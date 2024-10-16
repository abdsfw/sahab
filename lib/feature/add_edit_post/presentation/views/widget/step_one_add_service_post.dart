import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sahab_project/core/enums/type_post_enum.dart';
import 'package:sahab_project/core/theme/app_color.dart';
import 'package:sahab_project/core/theme/app_textsyle.dart';
import 'package:sahab_project/core/utils/widgets/app_button.dart';
import 'package:sahab_project/feature/add_edit_post/presentation/views/widget/service_data_input_section.dart';
import 'package:sahab_project/feature/add_edit_post/presentation/views/widget/upload_images_section.dart';
import '../../../../../generated/l10n.dart';
import '../../manager/next_post_service_cubit/next_post_service_cubit.dart';
import '../../manager/page_view_cubit/page_view_cubit.dart';

class StepOneAddServicePost extends StatelessWidget {
  const StepOneAddServicePost({
    super.key,
  });
// todo : finish translate
  @override
  Widget build(BuildContext context) {
    NextPostServiceCubit nextPostServiceCubit =
        NextPostServiceCubit.get(context);
    return SingleChildScrollView(
      child: Column(
        children: [
          //? input title && service && about service.
          const ServiceDataInputSection(),
          //? ---------------------------------------

          SizedBox(height: 23.h),

          //? Upload images section
          const UploadImagesSection(typePost: TypeToggle.service),
          //? ----------------------------------------------------

          SizedBox(height: 23.h),

          //? Next button
          BlocBuilder<NextPostServiceCubit, NextPostServiceState>(
            builder: (context, state) {
              return AppButton(
                width: double.infinity,
                height: 50.h,
                onTap: state is ServiceCanMovePostState
                    ? () {
                        print(
                            "################## all right ##################");
                        nextPostServiceCubit.navigateToNextPageView();
                        //? this function for change step state
                        BlocProvider.of<PageViewCubit>(context)
                            .goToSecondPageView();
                      }
                    : null,
                text: S.of(context).next,
                color: state is ServiceCanMovePostState
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
    );
  }
}
