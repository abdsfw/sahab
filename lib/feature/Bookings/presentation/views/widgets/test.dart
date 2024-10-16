import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sahab_project/core/const.dart';
import 'package:sahab_project/feature/Bookings/presentation/manager/booking_cubit/booking_cubit.dart';
import 'package:sahab_project/feature/places/data/model/place_details_model.dart';
import 'package:sahab_project/feature/places/data/model/place_details_model/place_details_model.dart';

import '../../../../../core/theme/app_color.dart';
import '../../../../../core/theme/app_textsyle.dart';
import '../../../../../core/utils/icons/app_icons.dart';
import '../../../../../core/utils/widgets/custom_scroll_photo_widget.dart';
import '../../../../../generated/l10n.dart';
import '../../../../home/presentation/widgets/details_card.dart';

class PlacesCardTest extends StatelessWidget {
  const PlacesCardTest({
    this.boxShadow = const [
      BoxShadow(
        color: AppColor.shadow1Color,
        blurRadius: 4,
      ),
    ],
    this.borderRadius = const BorderRadius.all(Radius.circular(5)),
    this.color = AppColor.whiteColor,
    this.placeDetailsModel,
    super.key,
  });
  final List<BoxShadow> boxShadow;
  final BorderRadius borderRadius;
  final Color color;
  final PlaceDetailsModel? placeDetailsModel;
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
              placeImage: placeDetailsModel?.placeImages
                      ?.map((e) => e.image ?? "")
                      .toList() ??
                  [],
            ),
            SizedBox(
              height: 10.h,
            ),
            Text(
              S.of(context).location_name,
              style: AppStyles.style18semibold(context),
            ),
            Row(
              children: [
                SvgPicture.asset(
                  AppIcons.location,
                  color: AppColor.greyColor,
                ),
                Text(
                  placeDetailsModel?.address ?? "N/A",
                  style: AppStyles.style15(context),
                )
              ],
            ),
            SizedBox(
              height: 10.h,
            ),
            Text(
              "${S.of(context).starting_from} ${placeDetailsModel?.weekdayPrice.toString()} KD",
              style: AppStyles.style16w500(context),
            ),
            SizedBox(
              height: 10.h,
            ),
            Row(
              children: [
                DetailsCard(
                  containerColor: AppColor.blueColorOpacity,
                  child: Center(
                    child: Text(
                      placeDetailsModel?.tag ?? "N/A",
                      style: AppStyles.style12(context),
                    ),
                  ),
                ),
                SizedBox(
                  width: 15.w,
                ),
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
                        placeDetailsModel?.rating ?? "N/A",
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
