import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:sahab_project/core/theme/app_color.dart';
import 'package:sahab_project/core/theme/app_textsyle.dart';
import 'package:sahab_project/core/utils/functions/function.dart';
import 'package:sahab_project/core/utils/icons/app_icons.dart';
import 'package:sahab_project/core/utils/widgets/app_button.dart';
import 'package:sahab_project/core/utils/widgets/circular_progress_indicator.dart';
import 'package:sahab_project/core/utils/widgets/custom_simple_app_bar_widget.dart';
import 'package:sahab_project/feature/Bookings/presentation/manager/add_rating_cubit/add_rating_cubit.dart';
import 'package:sahab_project/feature/Bookings/presentation/manager/rating_cubit/rating_cubit.dart';
import 'package:sahab_project/feature/Bookings/presentation/views/widgets/rating_smile_buttons.dart';

import '../../../../core/enums/rating_enum.dart';
import '../../../../generated/l10n.dart';

class RateBookingPage extends StatelessWidget {
  const RateBookingPage({super.key, required this.id});
  final int id;
// todo : finish translate
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => RatingCubit(),
        ),
        BlocProvider(
          create: (context) => AddRatingCubit(),
        ),
      ],
      child: BlocConsumer<AddRatingCubit, AddRatingState>(
        listener: (context, state) {
          // TODO: implement listener
          if (state is SuccessAddRatingState) {
            AppFunction.confirmDialog(
              context,
              title: S.of(context).success,
              text1: S.of(context).rate_successfully,
              onYesTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop("success");
              },
            );
          } else if (state is FailureAddRatingState) {
            AppFunction.confirmDialog(
              context,
              title: S.of(context).general_error,
              onYesTap: () {
                Navigator.of(context).pop();
              },
            );
          }
        },
        builder: (context, state) {
          return ModalProgressHUD(
            inAsyncCall: state is LoadingAddRatingState,
            progressIndicator: CustomCircularProgressIndicator(),
            child: Scaffold(
              body: Column(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomSimpleAppBarWidget(
                    // onIconTap: () {
                    //   Navigator.of(context).pop();
                    // },
                    iconPath: AppIcons.close,
                    appBarTitle: S.of(context).rate_booking,
                  ),
                  SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 25.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 35.h),
                          Padding(
                            padding: const EdgeInsetsDirectional.only(start: 4),
                            child: Text(
                              //? Thank you in advance for you feedback.
                              S.of(context).feedback_message,
                              //? --------------------------------------
                              style: AppStyles.textStyle17w400DarkBlue(context),
                            ),
                          ),
                          Text(
                            S
                                .of(context)
                                .lorem_text, // 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.',
                            style: AppStyles.textStyle15w400GreyLight(context),
                          ),
                          SizedBox(height: 16.h),
                          Text(
                            S.of(context).overall_satisfaction,
                            style: AppStyles.textStyle17w700Black(context),
                          ),
                          SizedBox(height: 24.h),
                          const RatingSmileButtons(),
                        ],
                      ),
                    ),
                  ),
                  const Expanded(child: SizedBox()),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Builder(
                      builder: (context) {
                        return BlocBuilder<RatingCubit, RatingState>(
                          builder: (context, state) {
                            return AppButton(
                              width: double.infinity,
                              height: 50.h,
                              onTap: (BlocProvider.of<RatingCubit>(context)
                                          .rate ==
                                      Rating.none)
                                  ? null
                                  : () {
                                      BlocProvider.of<AddRatingCubit>(context)
                                          .ratingBooking(
                                        rating: BlocProvider.of<RatingCubit>(
                                                context)
                                            .rate,
                                        postId: id,
                                      );
                                    },
                              text: S.of(context).submit,
                              color:
                                  (BlocProvider.of<RatingCubit>(context).rate ==
                                          Rating.none)
                                      ? AppColor.greySubmitColor
                                      : AppColor.blueColor,
                              radius: 5.r,
                              fontSize: 16.sp,
                              fontFamily: AppStyles.getFontFamily(context),
                              textColor: const Color(0xffFFFFFF),
                              fontWeight: FontWeight.w600,
                            );
                          },
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
