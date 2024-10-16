import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sahab_project/core/enums/type_post_enum.dart';
import 'package:sahab_project/core/utils/widgets/custom_app_sub_title.dart';
import 'package:sahab_project/core/utils/widgets/custom_app_title.dart';
import 'package:sahab_project/feature/Bookings/presentation/views/widgets/custom_date_show_text.dart';
import 'package:sahab_project/feature/Bookings/presentation/views/widgets/custom_time_show_text.dart';

class CustomReservationBookingDetails extends StatelessWidget {
  const CustomReservationBookingDetails({
    super.key,
    this.title = "Booking Details",
    required this.subTitle,
    required this.startDate,
    required this.endDate,
    required this.startDateText,
    required this.endDateText,
    required this.typeToggle,
  });
  final String title;
  final String subTitle;

  final String startDateText;
  final DateTime startDate;
  final String endDateText;
  final DateTime endDate;
  final TypeToggle typeToggle;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomAppTitle(
          title: title,
        ),
        SizedBox(
          height: 10.h,
        ),
        CustomAppSubTitle(
          subTitle: subTitle, //"Royal Chalet Kuwait",
        ),
        SizedBox(
          height: 10.h,
        ),
        CustomDateShowText(
          date: startDate,
          text: startDateText,
        ),
        SizedBox(
          height: 13.h,
        ),
        (typeToggle == TypeToggle.place)
            ? CustomDateShowText(
                date: endDate,
                text: endDateText,
              )
            : CustomTimeShowText(
                date1: startDate,
                date2: endDate,
                text: endDateText,
              ),
      ],
    );
  }
}
