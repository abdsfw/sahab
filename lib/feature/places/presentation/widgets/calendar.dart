import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sahab_project/core/theme/app_color.dart';
import 'package:sahab_project/core/theme/app_textsyle.dart';
import 'package:sahab_project/core/utils/extension/date_time_extension.dart';
import 'package:sahab_project/core/utils/icons/app_icons.dart';
import 'package:sahab_project/core/utils/widgets/custom_table_range.dart';
import 'package:sahab_project/feature/places/presentation/manager/place_booking_date_cubit/place_booking_date_cubit.dart';

// class Calendar extends StatefulWidget {
//   const Calendar({super.key});

//   @override
//   CalendarState createState() => CalendarState();
// }

class Calendar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    PlaceBookingDateCubit cubit = PlaceBookingDateCubit.get(context);
    return SafeArea(
      child: Container(
        // width: 1000.w,
        // height: 340,
        margin: EdgeInsetsDirectional.only(
          start: 24.5.w,
          end: 25.5.w,
          // top: 52.h,
        ),
        decoration: BoxDecoration(
          color: AppColor.whiteColor,
          borderRadius: BorderRadius.circular(15.sp),
        ),
        child: CustomTableRange(
          startRange: DateTime.now(),
          endRange: DateTime.now().add(
            Duration(
              days: 30,
            ),
          ),
          onRangeSelected: (startDate, endDate) {
            cubit.selectStartEndDate(
              startDate: startDate!.truncateToDay(),
              endDate: endDate?.truncateToDay() ?? startDate.truncateToDay(),
            );
          },
          ignoreDays:
              BlocProvider.of<PlaceBookingDateCubit>(context).ignoreDates,
        ),
      ),
    );
  }
}

// Widget _buildDefaultRangeDatePickerWithValue(BuildContext context) {
//   List<DateTime?> _rangeDatePickerValueWithDefaultValue = [
//     DateTime.now(),
//     DateTime.now(),
//   ];
//   final config = CalendarDatePicker2Config(
//     yearBorderRadius: BorderRadius.circular(20),
//     centerAlignModePicker: true,
//     disableModePicker: true,
//     calendarType: CalendarDatePicker2Type.range,
//     selectedDayHighlightColor: AppColor.blueColor,
//     selectedRangeHighlightColor: AppColor.blueColor,
//     selectedRangeDayTextStyle: AppStyles.style15semibold(context)
//         .copyWith(color: AppColor.whiteColor, fontSize: 15.sp),
//     selectedYearTextStyle: AppStyles.style18(context)
//         .copyWith(color: AppColor.yearColor, fontSize: 18.sp),
//     selectedDayTextStyle:
//         AppStyles.style15semibold(context).copyWith(fontSize: 15.sp),
//     yearTextStyle: AppStyles.style18(context)
//         .copyWith(color: AppColor.yearColor, fontSize: 18.sp),
//     weekdayLabelTextStyle: AppStyles.style15(context)
//         .copyWith(color: AppColor.weekDayColor, fontSize: 15.sp),
//     controlsTextStyle: AppStyles.style18(context).copyWith(
//         fontWeight: FontWeight.bold,
//         color: AppColor.yearColor,
//         fontSize: 18.sp),
//     dayTextStyle: AppStyles.style15(
//       context,
//     ).copyWith(
//         color: Colors.black, fontWeight: FontWeight.w500, fontSize: 15.sp),
//     lastMonthIcon: SvgPicture.asset(AppIcons.backArrowCalenderIcon),
//     nextMonthIcon: SvgPicture.asset(AppIcons.forArrowCalenderIcon),
//   );
//   return Column(
//     mainAxisSize: MainAxisSize.min,
//     children: [
//       // const SizedBox(height: 10),
//       CalendarDatePicker2(
//           config: config,
//           value: _rangeDatePickerValueWithDefaultValue,
//           onValueChanged: (dates) {}),
//       // const SizedBox(height: 10),
//       // const SizedBox(height: 25),
//     ],
//   );
// }
