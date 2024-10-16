import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sahab_project/core/const.dart';
import 'package:sahab_project/core/enums/type_post_enum.dart';
import 'package:sahab_project/feature/Bookings/presentation/manager/booking_cubit/booking_cubit.dart';
import 'package:sahab_project/feature/places/data/model/place_details_model.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../../core/theme/app_color.dart';
import '../../../../../core/theme/app_textsyle.dart';
import '../../../../../core/utils/icons/app_icons.dart';
import '../../../../../core/utils/widgets/custom_scroll_photo_widget.dart';
import '../../../../../generated/l10n.dart';
import '../../../../home/presentation/widgets/details_card.dart';

class ReservationCardImage extends StatelessWidget {
  const ReservationCardImage({
    this.boxShadow = const [
      BoxShadow(
        color: AppColor.shadow1Color,
        blurRadius: 4,
      ),
    ],
    this.borderRadius = const BorderRadius.all(Radius.circular(5)),
    this.color = AppColor.whiteColor,
    super.key,
    required this.title,
    required this.secondTitle,
    this.tag,
    required this.typeToggle,
    required this.imagePath,
  });
  final List<BoxShadow> boxShadow;
  final BorderRadius borderRadius;
  final Color color;
  final String title;
  final String secondTitle;
  final String? tag;
  final TypeToggle typeToggle;
  final String imagePath;
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
            CustomPhotoWidget(
              imagePath: imagePath,
            ),
            SizedBox(
              height: 10.h,
            ),
            Text(
              title,
              style: AppStyles.style18semibold(context),
            ),
            SizedBox(
              height: 15.h,
            ),
            Text(
              secondTitle,
              style: AppStyles.textstyle16w500Brown(context).copyWith(
                color: AppColor.greyColor,
              ),
            ),
            if (typeToggle == TypeToggle.place)
              SizedBox(
                height: 16.h,
              ),
            if (typeToggle == TypeToggle.place)
              Row(
                children: [
                  DetailsCard(
                    containerColor: AppColor.blueColorOpacity,
                    child: Center(
                      child: Text(
                        tag!,
                        style: AppStyles.style12(context),
                      ),
                    ),
                  ),
                ],
              ),
            SizedBox(height: 22.h),
          ],
        ),
      ),
    );
  }
}

class CustomPhotoWidget extends StatelessWidget {
  const CustomPhotoWidget({
    super.key,
    required this.imagePath,
  });
  final String imagePath;
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.all(
        Radius.circular(
          5,
        ),
      ),
      child: AspectRatio(
        aspectRatio: 2,
        child: CachedNetworkImage(
          fit: BoxFit.cover,
          placeholder: (context, url) {
            return Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: Container(
                width: 1000.w,
                height: 140.h,
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(5))),
                child: Image.asset(
                  Constant.kAdImage,
                ),
              ),
            );
          },
          imageUrl: "${Constant.baseUrl}$imagePath",
          errorWidget: (context, url, error) {
            return Image.asset(
              Constant.kPartyImage,
              fit: BoxFit.cover,
            );
          },
        ),
      ),
    );
  }
}
