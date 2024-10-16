import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sahab_project/core/enums/type_post_enum.dart';
import 'package:sahab_project/core/utils/widgets/custom_app_sub_title.dart';
import 'package:sahab_project/core/utils/widgets/custom_app_title.dart';
import 'package:sahab_project/feature/Bookings/presentation/views/widgets/custom_address_show_text.dart';
import 'package:sahab_project/feature/Bookings/presentation/views/widgets/custom_date_show_text.dart';
import 'package:sahab_project/feature/Bookings/presentation/views/widgets/custom_time_show_text.dart';
import 'package:sahab_project/generated/l10n.dart';

import '../icons/app_icons.dart';

class CustomBookingDetails extends StatelessWidget {
  const CustomBookingDetails({
    super.key,
    required this.subTitle,
    required this.startDate,
    required this.endDate,
    this.withEditDate,
    required this.typeToggle,
    this.address,
  });
  // final String title;
  final String subTitle;
  final DateTime startDate;
  final DateTime endDate;
  final TypeToggle typeToggle;
  final String? address;
  final void Function()? withEditDate;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: CustomAppTitle(
                title: S.of(context).booking_details, //title,
              ),
            ),
            if (withEditDate != null)
              InkWell(
                borderRadius: BorderRadius.circular(5),
                onTap: withEditDate,
                child: Container(
                  padding: EdgeInsets.all(5),
                  child: SvgPicture.asset(
                    AppIcons.editSquare,
                  ),
                ),
              ),
          ],
        ),
        SizedBox(height: 10.h),
        CustomAppSubTitle(subTitle: subTitle),
        SizedBox(height: 10.h),
        CustomDateShowText(
          date: startDate,
          text: typeToggle == TypeToggle.place
              ? S.of(context).start_date
              : S.of(context).booking_date,
        ),
        SizedBox(height: 13.h),
        if (typeToggle == TypeToggle.place)
          CustomDateShowText(
            date: endDate,
            text: S.of(context).end_date, //"end Date",
          ),
        if (typeToggle == TypeToggle.service)
          CustomTimeShowText(
            date1: startDate,
            date2: endDate,
            text: S.of(context).booking_durations, //"Booking Durations",
          ),
        if (typeToggle == TypeToggle.service) SizedBox(height: 13.h),
        if (typeToggle == TypeToggle.service)
          CustomAddressShowText(
            text: S.of(context).address,
            text2: address ?? "",
          ),
      ],
    );
  }
}
