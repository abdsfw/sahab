import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sahab_project/core/theme/app_textsyle.dart';

import '../../../../../core/theme/app_color.dart';
import '../../../../../generated/l10n.dart';

class CustomNoDataPage extends StatelessWidget {
  const CustomNoDataPage({super.key, required this.message});
// todo : finish translate
  final String message;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 150.h,
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppColor.whiteColor,
          borderRadius: BorderRadius.circular(10),
        ),
        // margin: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          // mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 40.h,
              width: 40.w,
              child: Image(
                  image: AssetImage(
                      "assets/images/booking_images/no_booking.png")),
            ),
            SizedBox(
              height: 11.h,
            ),
            Text(
              message,
              // S.of(context).no_bookings,
              style: AppStyles.textStyle18w500DarkBlue(context),
            ),
          ],
        ),
      ),
    );
  }
}
