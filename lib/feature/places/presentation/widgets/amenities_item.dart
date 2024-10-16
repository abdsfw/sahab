import 'package:cached_network_image/cached_network_image.dart';
import 'package:cached_network_svg_image/cached_network_svg_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sahab_project/core/const.dart';
import 'package:sahab_project/core/theme/app_textsyle.dart';
import 'package:sahab_project/core/utils/icons/app_icons.dart';
import 'package:sahab_project/core/utils/widgets/custom_cached_svg_image.dart';
import 'package:shimmer/shimmer.dart';

class AmenitiesItem extends StatelessWidget {
  const AmenitiesItem({
    super.key,
    this.title,
    this.imageUrl,
  });
  final String? title;
  final String? imageUrl;
  @override
  Widget build(BuildContext context) {
    // print("${Constant.baseUrl}$imageUrl");
    return Padding(
      padding: EdgeInsetsDirectional.only(start: 16.w, bottom: 20.h),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 50.w,
            height: 50.h,
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5), color: Colors.white),
            child:
                CustomCachedSvgImage(imageUrl: "${Constant.baseUrl}/$imageUrl"),
            // CachedNetworkImage(
            //   imageUrl: "${Constant.baseUrl}$imageUrl" ?? "",
            //   errorWidget: (context, url, error) {
            //     return Icon(Icons.error);
            //   },
            //   placeholder: (context, url) {
            //     return Shimmer.fromColors(
            //       baseColor: Colors.grey[300]!,
            //       highlightColor: Colors.grey[100]!,
            //       child: Container(
            //         // width: 1000.w,
            //         // height: 140.h,
            //         decoration: const BoxDecoration(
            //             borderRadius: BorderRadius.all(Radius.circular(5))),
            //       ),
            //     );
            //   },
            // ),
          ),
          const SizedBox(
            width: 15,
          ),
          Text(
            title ?? " null ",
            style: AppStyles.style16(context),
          )
        ],
      ),
    );
  }
}
