import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/theme/app_color.dart';
import '../../../../../core/theme/app_textsyle.dart';
import '../../../../../generated/l10n.dart';
import '../../manager/page_view_cubit/page_view_cubit.dart';
import 'custom_step_circle.dart';

class StepWidget extends StatelessWidget {
  const StepWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 70.w),
          child: BlocBuilder<PageViewCubit, PageViewState>(
            builder: (context, state) {
              return Row(
                // mainAxisAlignment: MainAxisAlignment.center,
                // crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const CustomStepCircle(),
                  Expanded(
                    child: Container(
                      height: 2,
                      color: state is SecondPageViewState
                          ? AppColor.blueColor
                          : AppColor.stepColor,
                    ),
                  ),
                  CustomStepCircle(
                    color: state is SecondPageViewState
                        ? AppColor.blueColor
                        : AppColor.stepColor,
                  ),
                ],
              );
            },
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 65.w),
          child: Row(
            // mainAxisAlignment: MainAxisAlignment.center,
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                '${S.of(context).step} 1',
                style: AppStyles.textStyle17w400Brown(context).copyWith(
                  color: AppColor.blueColor,
                ),
              ),
              const Expanded(
                child: SizedBox(),
              ),
              BlocBuilder<PageViewCubit, PageViewState>(
                builder: (context, state) {
                  return Text(
                    '${S.of(context).step} 2',
                    style: AppStyles.textStyle17w400Brown(context).copyWith(
                      color: state is SecondPageViewState
                          ? AppColor.blueColor
                          : AppColor.stepColor,
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
