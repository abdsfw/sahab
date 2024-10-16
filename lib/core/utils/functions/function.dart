import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:sahab_project/core/theme/app_color.dart';
import 'package:sahab_project/core/theme/app_textsyle.dart';
import 'package:sahab_project/core/utils/widgets/app_button.dart';
import 'package:sahab_project/core/utils/widgets/circular_progress_indicator.dart';
import 'package:sahab_project/core/utils/widgets/custom_app_sub_title.dart';
import 'package:sahab_project/core/utils/widgets/custom_input_field.dart';
import 'package:sahab_project/core/utils/widgets/custom_table_range.dart';
import 'package:sahab_project/core/utils/widgets/custom_title_input_field.dart';
import 'package:sahab_project/core/utils/widgets/custom_two_date_selected_widget.dart';
import 'package:sahab_project/feature/add_edit_post/presentation/manager/next_post_place_cubit/next_post_place_cubit.dart';
import 'package:sahab_project/feature/add_edit_post/presentation/manager/special_date_cubit/special_date_cubit.dart';
import 'package:sahab_project/feature/boarding/presentation/manager/lang_cubit/lang_cubit.dart';

import '../../../generated/l10n.dart';

class AppFunction {
  static String? customFormFieldValidator(String? value) {
    if (value == null || value.isEmpty) {
      return "";
    }
    return null;
  }

  static String? customDropDownFormFieldValidator(String? value) {
    if (value == null || value.isEmpty) {
      return "";
    }
    return null;
  }

  static String checkFamilyFont(context) {
    String currentLang = BlocProvider.of<LangCubit>(context).lang;
    if (currentLang == 'en') return AppFont.Poppins;
    return AppFont.Almarai;
  }

  static Future<dynamic> deleteQuestionDialog(
    BuildContext context, {
    required String title,
    required String text1,
    String? text2,
    required void Function() onYesTap,
    required void Function() onNoTap,
    required bool isLoading,
  }) {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => WillPopScope(
        onWillPop: () async {
          print("will pop scope");
          return false;
        },
        child: AlertDialog(
          backgroundColor: AppColor.whiteColor,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          title: Text(
            title, //"Delete Reservation",
            style: AppStyles.textstyle16w500DarkBlue(context)
                .copyWith(fontWeight: FontWeight.w600),
          ),
          scrollable: true,
          contentTextStyle: AppStyles.textStyle14w400GreyHint(context).copyWith(
            color: AppColor.brownColor,
          ),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                text1, //"Are you sure want to Delete This Reservation?",
                // style: TextStyle(),
              ),
              SizedBox(
                height: 10.h,
              ),
              if (text2 != null)
                Text(
                  text2, //"deleting post will not effect on any previous bookings",
                ),
              if (text2 != null) SizedBox(height: 27.h),
              (isLoading)
                  ? const CustomCircularProgressIndicator()
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        AppButton(
                          onTap: onNoTap,
                          text: S.of(context).no, // "NO",
                          color: AppColor.whiteColor,
                          radius: 5.r,
                          height: 50.h,
                          width: 75.w,
                          fontSize: 16.sp,
                          textColor: AppColor.blackColor,
                          fontWeight: FontWeight.w600,
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        AppButton(
                          onTap: onYesTap,
                          text: S.of(context).yes, //"yes",
                          color: AppColor.blueColor,
                          radius: 5.r,
                          height: 50.h,
                          width: 75.w,
                          fontSize: 16.sp,
                          textColor: AppColor.whiteColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ],
                    ),
            ],
          ),
        ),
      ),
    );
  }

  static Future<dynamic> confirmDialog(
    BuildContext context, {
    required String title,
    String? text1,
    // required String text2,
    required void Function() onYesTap,
    // required void Function() onNoTap,
    // required bool isLoading,
  }) {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => WillPopScope(
        onWillPop: () async {
          print("will pop scope");
          return false;
        },
        child: AlertDialog(
          backgroundColor: AppColor.whiteColor,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          title: Text(
            title, //"Delete Reservation",
            style: AppStyles.textstyle16w500DarkBlue(context)
                .copyWith(fontWeight: FontWeight.w600),
          ),
          scrollable: true,
          contentTextStyle: AppStyles.textStyle14w400GreyHint(context).copyWith(
            color: AppColor.brownColor,
          ),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              if (text1 != null)
                Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: Text(
                    text1, //"Are you sure want to Delete This Reservation?",
                    // style: TextStyle(),
                  ),
                ),
              if (text1 != null)
                SizedBox(
                  height: 10.h,
                ),
              AppButton(
                onTap: onYesTap,
                text: S.of(context).ok, // "ok",
                color: AppColor.blueColor,
                radius: 5.r,
                height: 50.h,
                width: 75.w,
                fontSize: 16.sp,
                textColor: AppColor.whiteColor,
                fontWeight: FontWeight.w600,
              ),
            ],
          ),
        ),
      ),
    );
  }

  static Future<dynamic> questionDialog(
    BuildContext context, {
    required String title,
    required String text1,
    required void Function() onYesTap,
  }) {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColor.whiteColor,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        title: Text(
          title, //"Delete Reservation",
          style: AppStyles.textstyle16w500DarkBlue(context)
              .copyWith(fontWeight: FontWeight.w600),
        ),
        scrollable: true,
        contentTextStyle: AppStyles.textStyle14w400GreyHint(context).copyWith(
          color: AppColor.brownColor,
        ),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              text1, //"Are you sure want to Delete This Reservation?",
              // style: TextStyle(),
            ),
            SizedBox(
              height: 20.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                AppButton(
                  onTap: onYesTap,
                  text: S.of(context).yes, // "yes",
                  color: AppColor.blueColor,
                  radius: 5.r,
                  height: 50.h,
                  width: 75.w,
                  fontSize: 16.sp,
                  textColor: AppColor.whiteColor,
                  fontWeight: FontWeight.w600,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  static Future<dynamic> addSpecialDayBottomSheet(BuildContext context) {
    NextPostPlaceCubit nextPostPlaceCubit = NextPostPlaceCubit.get(context);

    return showModalBottomSheet(
      isScrollControlled: true,
      useSafeArea: true,
      context: context,
      builder: (BuildContext context) {
        return BlocProvider(
          create: (context) => SpecialDateCubit()..checkIfCanAdd(context),
          child: Builder(builder: (context) {
            return Container(
              // height: MediaQuery.of(context).size.height * 0.9,
              padding: EdgeInsetsDirectional.only(
                start: 16.w,
                bottom: 30.h,
                end: 16.w,
                // top: 56.h,
              ),
              decoration: BoxDecoration(
                  color: AppColor.pageBackGround,
                  borderRadius: BorderRadiusDirectional.only(
                    topStart: Radius.circular(
                      30,
                    ),
                    topEnd: Radius.circular(
                      30,
                    ),
                  )),
              child: Column(
                // mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(child: SizedBox()),
                  CustomTitleInputField(
                    title: S.of(context).title, // "Title",
                    textStyle: AppStyles.textstyle16w500DarkBlue(context)
                        .copyWith(fontWeight: FontWeight.w600),
                  ),
                  SizedBox(height: 13.h),
                  CustomInputField(
                    controller: nextPostPlaceCubit.titleSpecialDateController,
                    hintText: S.of(context).eid_prices, //"Eid Prices",
                    onChange: (p0) {
                      BlocProvider.of<SpecialDateCubit>(context)
                          .checkIfCanAdd(context);
                    },
                  ),
                  SizedBox(height: 25.h),
                  CustomTitleInputField(
                    title: S.of(context).price_day, // "Price/Day",
                    textStyle: AppStyles.textstyle16w500DarkBlue(context)
                        .copyWith(fontWeight: FontWeight.w600),
                  ),
                  SizedBox(height: 13.h),
                  CustomInputField(
                    controller: nextPostPlaceCubit.priceSpecialDateController,
                    hintText: "1000.000 KWD",
                    onChange: (p0) {
                      BlocProvider.of<SpecialDateCubit>(context)
                          .checkIfCanAdd(context);
                    },
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(
                        RegExp(r'^\d+\.?\d{0,2}'),
                      ),
                      // FilteringTextInputFormatter.digitsOnly
                    ],
                  ),
                  Expanded(child: SizedBox()),
                  CustomTableRange(
                    startRange: DateTime.now().subtract(Duration(days: 1)),
                    endRange: DateTime.now().add(Duration(days: 360)),
                    // ignoreDays: [
                    //   DateTime.now().add(Duration(days: 1)).truncateToDay(),
                    //   DateTime.now().add(Duration(days: 4)).truncateToDay(),
                    //   DateTime.now().add(Duration(days: 5)).truncateToDay(),
                    //   DateTime.now().add(Duration(days: 7)).truncateToDay(),
                    //   DateTime.now().add(Duration(days: 10)).truncateToDay(),
                    // ],
                    onRangeSelected: (startRange, endRange) {
                      print("****************");
                      print(startRange);
                      print(endRange);
                      print("----------------");
                      if (startRange != null && endRange != null) {
                        DateTimeRange dateRange =
                            DateTimeRange(start: startRange, end: endRange);
                        nextPostPlaceCubit.specialDateChosen = dateRange;
                        BlocProvider.of<SpecialDateCubit>(context)
                            .specialDateChosen = dateRange;
                      } else if (startRange != null) {
                        DateTimeRange dateRange =
                            DateTimeRange(start: startRange, end: startRange);
                        nextPostPlaceCubit.specialDateChosen = dateRange;
                        BlocProvider.of<SpecialDateCubit>(context)
                            .specialDateChosen = dateRange;
                      } else {
                        nextPostPlaceCubit.specialDateChosen = null;
                        BlocProvider.of<SpecialDateCubit>(context)
                            .specialDateChosen = null;
                      }
                      BlocProvider.of<SpecialDateCubit>(context)
                          .checkIfCanAdd(context);
                    },
                  ),
                  BlocBuilder<SpecialDateCubit, SpecialDateState>(
                    builder: (context, state) {
                      DateTimeRange? rangeDate =
                          BlocProvider.of<SpecialDateCubit>(context)
                              .specialDateChosen;
                      if (rangeDate == null) {
                        return SizedBox();
                      } else {
                        String startDate = DateFormat("dd/MM/yyyy", 'en')
                            .format(rangeDate.start);
                        String endDate = DateFormat("dd/MM/yyyy", 'en')
                            .format(rangeDate.end);
                        return CustomTwoDateSelectedWidget(
                          startDateTime: startDate,
                          endDateTime: endDate,
                        );
                      }
                    },
                  ),
                  // AppButton(
                  //   onTap: () async {
                  //     showDateRangePicker(
                  //       context: context,
                  //       firstDate: DateTime.now(),
                  //       lastDate: DateTime.now().add(
                  //         Duration(
                  //           days: 30,
                  //         ),
                  //       ),
                  //     ).then((value) {
                  //       if (value != null) {
                  //         nextPostPlaceCubit.specialDateChosen = value;
                  //         BlocProvider.of<SpecialDateCubit>(context)
                  //             .checkIfCanAdd(context);
                  //       }
                  //       // print(value);
                  //     });
                  //   },
                  //   text: "choose date",
                  //   color: AppColor.yellowButtonColor,
                  //   radius: 5,
                  //   height: 50.h,
                  //   fontSize: 16.sp,
                  //   fontFamily: AppFont.Poppins,
                  //   textColor: const Color(0xffFFFFFF),
                  //   fontWeight: FontWeight.w600,
                  // ),

                  Expanded(child: SizedBox()),
                  BlocBuilder<SpecialDateCubit, SpecialDateState>(
                    builder: (context, state) {
                      return AppButton(
                        onTap: state is SuccessSpecialDateState
                            ? () {
                                nextPostPlaceCubit.addToSpecialDaysList();
                                Navigator.of(context).pop();
                              }
                            : null,
                        text: S.of(context).add_dates, //"Add Dates",
                        color: state is SuccessSpecialDateState
                            ? AppColor.blueColor
                            : AppColor.stepColor,
                        radius: 5,
                        height: 50.h,
                        fontSize: 16.sp,
                        fontFamily: AppStyles.getFontFamily(context),
                        textColor: const Color(0xffFFFFFF),
                        fontWeight: FontWeight.w600,
                      );
                    },
                  ),
                  // SizedBox(height: 10.h),

                  // Calendar(),
                ],
              ),
            );
          }),
        );
      },
    );
  }

  static String typeTranslate(String type, context) {
    switch (type) {
      case "All":
        return S.of(context).all;
      // break;
      case "Girls Only":
        return S.of(context).girls_only;
      case "Family Only":
        return S.of(context).family_only;
      default:
        return type;
    }
  }

  static String typeReturnEnglish(String type) {
    switch (type) {
      case "الكل":
        return "All";
      case "للبنات فقط":
        return "Girls Only";
      case "للعائلات فقط":
        return "Family Only";
      default:
        return type;
    }
  }
}
