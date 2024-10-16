import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sahab_project/feature/Bookings/presentation/manager/booking_cubit/booking_cubit.dart';
import 'package:sahab_project/feature/home/presentation/widgets/details_card.dart';
import 'package:sahab_project/feature/services/data/model/service.dart';

import '../../../../../core/theme/app_color.dart';
import '../../../../../core/theme/app_textsyle.dart';
import '../../../../../core/utils/icons/app_icons.dart';
import '../../../../../core/utils/widgets/custom_scroll_photo_widget.dart';

class ServiceDetailsCardScroll extends StatelessWidget {
  const ServiceDetailsCardScroll({
    this.boxShadow = const [
      BoxShadow(
        color: AppColor.shadow1Color,
        blurRadius: 4,
      ),
    ],
    this.borderRadius = const BorderRadius.all(Radius.circular(5)),
    this.color = AppColor.whiteColor,
    super.key,
    required this.serviceImages,
    required this.title,
    required this.price,
    required this.rating,
  });
  final List<BoxShadow> boxShadow;
  final BorderRadius borderRadius;
  final Color color;
  final String title;
  final String rating;
  final num price;
  final List<String> serviceImages;
  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: EdgeInsets.only(right: 14.w),
      // width: 319.w,

      decoration: BoxDecoration(
        boxShadow: boxShadow,
        borderRadius: borderRadius,
        color: color,
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //! this scroll and don't clickAble
            CustomScrollPhotoWidget(
              pageController: PageController(),
              // imagePathOnError: 'assets/images/service_images/djparty.png',
              placeImage: serviceImages,
            ),
            SizedBox(
              height: 15.h,
            ),
            Text(
              title, // "Service Title",
              style: AppStyles.style22WhiteSemiBold(context)
                  .copyWith(color: AppColor.darkBlueColor),
            ),
            SizedBox(
              height: 10.h,
            ),
            Text(
              "${price.toStringAsFixed(3)} KD", // "30.000 KD",
              style: AppStyles.style16w500(context),
            ),
            SizedBox(
              height: 15.h,
            ),
            Row(
              children: [
                if (rating.substring(0, 3) != "0.0")
                  DetailsCard(
                    containerColor: AppColor.orangeColorOpacity,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SvgPicture.asset(AppIcons.star),
                        SizedBox(
                          width: 3.w,
                        ),
                        Text(
                          rating.substring(0, 3), //"4.5",
                          style: AppStyles.style14(context)
                              .copyWith(color: AppColor.secondPrimaryColor),
                        )
                      ],
                    ),
                  ),
              ],
            ),
            // const Divider(),
          ],
        ),
      ),
    );
  }
}
