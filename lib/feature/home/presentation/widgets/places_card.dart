import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sahab_project/core/const.dart';
import 'package:sahab_project/core/theme/app_color.dart';
import 'package:sahab_project/core/theme/app_textsyle.dart';
import 'package:sahab_project/core/utils/icons/app_icons.dart';
import 'package:sahab_project/feature/home/presentation/widgets/details_card.dart';
import 'package:sahab_project/feature/places/presentation/manager/place_cubit/place_cubit.dart';
import 'package:sahab_project/feature/places/presentation/manager/place_details_cubit/place_details_cubit.dart';
import 'package:sahab_project/feature/places/presentation/pages/place_details.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../generated/l10n.dart';

class PlacesCard extends StatelessWidget {
  const PlacesCard({
    super.key,
    required this.imagePath,
    required this.dicVisibly,
    required this.rate,
    required this.locationName,
    required this.price,
    required this.tag,
    this.placeId,
    required this.title,
  });

  // todo : finish translate
  final String imagePath;
  final bool dicVisibly;
  final String rate;
  final String locationName;
  final num price;
  final String tag;
  final int? placeId;
  final String title;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      //! this for display place details
      onTap: () async {
        PlaceDetailsCubit placeDetailsCubit = PlaceDetailsCubit.get(context);

        print(placeId);
        placeDetailsCubit.fetchPlaceDetails(context, placeId: placeId ?? -1);

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PlaceDetails(placeId: placeId ?? -1),
          ),
        );
      },
      child: Container(
        margin: EdgeInsetsDirectional.only(end: 16.w),
        width: 319.w,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(5)),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Color(0x3FDADADA),
              blurRadius: 4,
              offset: Offset(0, 4),
              spreadRadius: 0,
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 9.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //! place Image .
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10.h),
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(5)),
                  child: AspectRatio(
                    // aspectRatio: 2,
                    /// here aspectRatio will depend on
                    /// height and weight
                    aspectRatio: 319.w / 180.h,
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
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5))),
                            child: Image.asset(
                              Constant.kAdImage,
                            ),
                          ),
                        );
                      },
                      imageUrl: "${Constant.baseUrl}$imagePath",
                      errorWidget: (context, url, error) {
                        return Image.asset(
                          Constant.kLogoImage,
                        );
                      },
                    ),
                    // Image.asset(
                    //   imagePath,
                    //   fit: BoxFit.cover,
                    // ),
                  ),
                ),
              ),
              // ? -----------------------------------------------
              SizedBox(
                height: 10.h,
              ),
              //! Location Name
              Text(
                title,
                maxLines: 1,
                style: AppStyles.style18semibold(context),
              ),
              // ! Location Name with Icon ...
              SizedBox(
                height: 10.h,
              ),
              Row(
                children: [
                  SvgPicture.asset(
                    AppIcons.location,
                    // ignore: deprecated_member_use
                    color: AppColor.greyColor,

                    fit: BoxFit.cover,
                  ),
                  SizedBox(
                    width: 3.44.w,
                  ),
                  Expanded(
                    child: Text(
                      locationName,
                      maxLines: 1,
                      style: AppStyles.style15(context),
                    ),
                  )
                ],
              ),
              //? ---------------------------------------------------------
              SizedBox(
                height: 10.h,
              ),
              // ! price
              Text(
                "${S.of(context).starting_from} $price KD",
                maxLines: 1,
                style: AppStyles.style16w500(context).copyWith(
                  letterSpacing: -0.16,
                ),
              ),
              // ? -------------------------------------------------------------
              SizedBox(
                height: 10.h,
              ),

              Row(
                children: [
                  Visibility(
                    visible: dicVisibly,
                    child: DetailsCard(
                      containerColor: AppColor.blueColorOpacity,
                      //! Tag here (Girls Only,family Only, ... )
                      child: Center(
                        child: Text(
                          tag,
                          style: AppStyles.style12(context),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 15.w,
                  ),
                  (rate.substring(0, 1) == '0')
                      ? SizedBox()
                      : DetailsCard(
                          containerColor: AppColor.orangeColorOpacity,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                AppIcons.star,
                                height: 20.h,
                                width: 20.w,
                              ),
                              SizedBox(
                                width: 3.w,
                              ),
                              //! Rate here ...
                              Text(
                                rate.substring(0, 1),
                                style: AppStyles.style14(context).copyWith(
                                    color: AppColor.secondPrimaryColor),
                              )
                            ],
                          ),
                        ),
                ],
              ),
              SizedBox(
                height: 15.h,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
