import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_color.dart';
import '../../../../core/theme/app_textsyle.dart';
import '../../../../core/utils/widgets/app_button.dart';
import '../../../../generated/l10n.dart';

class BookingLoginPage extends StatelessWidget {
  const BookingLoginPage({super.key});
// todo : finish translates
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                S.of(context).my_bookings,
                style: AppStyles.textStyle16w400DarkBlue(context),
              ),
              SizedBox(
                height: 60.h,
              ),
              SizedBox(
                height: 106.h,
                width: 98.w,
                child: const Image(
                  image: AssetImage(
                    "assets/logos/group.png",
                  ),
                ),
              ),
              SizedBox(
                height: 44.h,
              ),
              Text(
                "${S.of(context).welcome_back}\n${S.of(context).glad_message}",
                style: AppStyles.textStyle26w600DarkBlue(context),
              ),
              SizedBox(
                height: 63.h,
              ),
              Text(
                S.of(context).mobile_number_,
                style: AppStyles.textStyle14w500DarkBlue(context),
              ),
              SizedBox(
                height: 7.h,
              ),
              Container(
                height: 46.h,
                color: Colors.white,
              ),
              SizedBox(
                height: 39.h,
              ),
              AppButton(
                width: double.infinity,
                height: 50.h,
                onTap: () {},
                text: S.of(context).login,
                color: AppColor.blueColor,
                radius: 5.r,
                fontSize: 16.sp,
                fontFamily: AppStyles.getFontFamily(context),
                textColor: Color(0xffFFFFFF),
                fontWeight: FontWeight.w600,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
