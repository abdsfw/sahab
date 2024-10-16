import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sahab_project/core/enums/type_post_enum.dart';
import 'package:sahab_project/core/theme/app_textsyle.dart';
import 'package:sahab_project/core/utils/widgets/row_data_item.dart';
import 'package:sahab_project/feature/Bookings/presentation/views/booking_places_page.dart';

import '../../../../../core/theme/app_color.dart';
import '../../../../../generated/l10n.dart';

class ReservationDataContainer extends StatelessWidget {
  const ReservationDataContainer({
    super.key,
    required this.title,
    this.onTap,
    required this.id,
    required this.status,
    required this.categoryTitle,
    required this.amount,
    required this.typeToggle,
    required this.date1,
    required this.date2,
  });
  final String title;
  final void Function()? onTap;
  final int id;
  final String status;
  final String categoryTitle;
  final num amount;
  final TypeToggle typeToggle;
  final String date1;
  final String date2;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: AppColor.whiteColor,
          borderRadius: BorderRadius.circular(
            5,
          ),
          // boxShadow: const [
          //   BoxShadow(
          //     color: Color(0x3FDADADA),
          //     blurRadius: 4,
          //     offset: Offset(0, 4),
          //     spreadRadius: 0,
          //   ),
          // ],
        ),
        padding: EdgeInsetsDirectional.only(
          start: 20.w,
          end: 20.w,
          top: 15.h,
          bottom: 17.h,
        ),
        // height: 210.h,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: AppStyles.textStyle20w600DarkBlue(context),
              ),
              SizedBox(
                height: 15.h,
              ),
              RowDataItem(
                firstData: S.of(context).booking_ID, // "Booking ID",
                secondData: S.of(context).status, // "Status",
                textStyle: AppStyles.textstyle16w500Brown(context).copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 4.h),
              RowDataItem(
                firstData: id.toString(),
                secondData: status,
                textStyle: AppStyles.textStyle16w400DarkBlue(context),
              ),
              SizedBox(height: 16.h),
              RowDataItem(
                firstData: S.of(context).category, // "Category",
                secondData: S.of(context).amount, // "Amount",
                textStyle: AppStyles.textstyle16w500Brown(context).copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 4.h),
              RowDataItem(
                firstData: categoryTitle,
                secondData: "$amount KD",
                textStyle: AppStyles.textStyle16w400DarkBlue(context),
              ),
              SizedBox(height: 16.h),
              RowDataItem(
                firstData: typeToggle == TypeToggle.place
                    ? S.of(context).start_date // "Start Date"
                    : S.of(context).booking_date,
                // "Booking Date",
                secondData: typeToggle == TypeToggle.place
                    ? S.of(context).end_date // "End Date"
                    : S.of(context).booking_time, // "Booking Time",
                textStyle: AppStyles.textstyle16w500Brown(context).copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 4.h),
              RowDataItem(
                firstData: date1,
                secondData: date2,
                textStyle: AppStyles.textStyle16w400DarkBlue(context),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
