import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sahab_project/core/const.dart';
import 'package:sahab_project/core/theme/app_color.dart';
import 'package:sahab_project/core/theme/app_textsyle.dart';
import 'package:sahab_project/core/utils/icons/app_icons.dart';
import 'package:sahab_project/feature/home/presentation/widgets/details_card.dart';
import 'package:sahab_project/feature/services/data/model/service.dart';
import 'package:sahab_project/feature/services/presentation/pages/service_details_view.dart';
import 'package:sahab_project/generated/l10n.dart';
import 'package:shimmer/shimmer.dart';

class ServiceCardView extends StatelessWidget {
  ServiceCardView({
    super.key,
    this.service,
  });

  Services? service;
  @override
  Widget build(BuildContext context) {
    String imageUrl =
        (service!.serviceImages.isEmpty) ? "" : service!.serviceImages[0].image;
    return GestureDetector(
      onTap: () {
        print(service?.id ?? 2);
        //? here we should call details api
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                ServiceDetailsView(serviceId: service?.id ?? -1),
          ),
        );
      },
      child: Container(
        // margin: EdgeInsets.only(right: 14.w),
        width: 319.w,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(5)),
          color: Colors.white,
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 9.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //! service Image .
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
                            // width: 1000.w,
                            // height: 140.h,
                            decoration: const BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5))),
                            // child: Image.asset(
                            //   Constant.kAdImage,
                            // ),
                          ),
                        );
                      },
                      imageUrl: "${Constant.baseUrl}$imageUrl",
                      errorWidget: (context, url, error) {
                        return Icon(Icons.error);
                        // Image.asset(
                        //   imagePathOnError,
                        //   fit: BoxFit.cover,
                        // );
                      },
                    ),
                    // Image.asset(
                    //   Constant.kPartyImage,
                    //   fit: BoxFit.cover,
                    // ),
                  ),
                ),
              ),
              // ? -----------------------------------------------
              SizedBox(
                height: 10.h,
              ),
              //! Service Tittle
              Text(
                service?.title ?? "", //"Service Tittle",
                style: AppStyles.style18semibold(context),
              ),
              // ? -------------------------------------------
              SizedBox(
                height: 10.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    service?.price.toString() ?? "",
                    style: AppStyles.style16w500(context),
                  ),
                  Text(
                    "${S.of(context).duration}: ${service?.duration ?? 0} ${S.of(context).hour}",
                    style: AppStyles.style15(context),
                  )
                ],
              ),
              // ? -------------------------------------------------------------
              SizedBox(
                height: 10.h,
              ),
              //? --------------------------------------------------------
              //! Rate here ...
              Row(
                children: [
                  if (service?.rating.substring(0, 3) != "0.0")
                    DetailsCard(
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
                          Text(
                            service?.rating.substring(0, 3) ?? "",
                            style: AppStyles.style14(context)
                                .copyWith(color: AppColor.secondPrimaryColor),
                          )
                        ],
                      ),
                    ),
                ],
              ),
              SizedBox(
                height: 10.h,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
