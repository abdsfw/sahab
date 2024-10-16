import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sahab_project/core/const.dart';
import 'package:sahab_project/core/enums/type_post_enum.dart';
import 'package:sahab_project/feature/Bookings/presentation/manager/booking_cubit/booking_cubit.dart';
import 'package:sahab_project/feature/places/data/model/place_details_model.dart';
import 'package:sahab_project/feature/places/data/model/place_details_model/place_details_model.dart';

import '../../../../../core/theme/app_color.dart';
import '../../../../../core/theme/app_textsyle.dart';
import '../../../../../core/utils/icons/app_icons.dart';
import '../../../../../core/utils/widgets/custom_scroll_photo_widget.dart';
import '../../../../../generated/l10n.dart';
import '../../../../home/presentation/widgets/details_card.dart';

class FirstCardBookingDetails extends StatelessWidget {
  const FirstCardBookingDetails({
    this.boxShadow = const [
      BoxShadow(
        color: AppColor.shadow1Color,
        blurRadius: 4,
      ),
    ],
    this.borderRadius = const BorderRadius.all(Radius.circular(5)),
    this.color = AppColor.whiteColor,
    super.key,
    required this.images,
    this.address,
    required this.weekdayPrice,
    this.tag,
    required this.rating,
    required this.title,
    // required this.typeToggle,
  });
  final String title;
  final List<BoxShadow> boxShadow;
  final BorderRadius borderRadius;
  final Color color;
  final List<String> images;
  final String? address;
  final num weekdayPrice;
  final String? tag;
  final String rating;
  // final TypeToggle typeToggle;
// todo : finish translate

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
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomScrollPhotoWidget(
              pageController: PageController(),
              imagePathOnError: Constant.kPartyImage,
              placeImage: images,
            ),
            SizedBox(
              height: 10.h,
            ),
            Text(
              title, //S.of(context).location_name,
              style: AppStyles.style18semibold(context),
            ),
            if (address != null)
              Row(
                children: [
                  SvgPicture.asset(
                    AppIcons.location,
                    color: AppColor.greyColor,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Expanded(
                    child: Text(
                      address!,
                      maxLines: 2,
                      style: AppStyles.style15(context),
                    ),
                  )
                ],
              ),
            SizedBox(
              height: 10.h,
            ),
            if (address != null)
              Text(
                "${S.of(context).starting_from} ${weekdayPrice.toString()} KD",
                style: AppStyles.style16w500(context),
              ),
            if (address == null)
              Text(
                "${weekdayPrice.toString()} KD",
                style: AppStyles.style16w500(context),
              ),
            SizedBox(
              height: 10.h,
            ),
            Row(
              children: [
                if (tag != null)
                  DetailsCard(
                    containerColor: AppColor.blueColorOpacity,
                    child: Center(
                      child: Text(
                        tag!,
                        style: AppStyles.style12(context),
                      ),
                    ),
                  ),
                if (tag != null)
                  SizedBox(
                    width: 15.w,
                  ),
                if (rating != "0.0")
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
                          rating,
                          style: AppStyles.style14(context)
                              .copyWith(color: AppColor.secondPrimaryColor),
                        )
                      ],
                    ),
                  ),
              ],
            ),
            SizedBox(
              height: 8.h,
            ),
          ],
        ),
      ),
    );
  }
}
