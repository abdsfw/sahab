import 'package:cached_network_image/cached_network_image.dart';
import 'package:cached_network_svg_image/cached_network_svg_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sahab_project/core/const.dart';
import 'package:sahab_project/core/theme/app_color.dart';
import 'package:sahab_project/core/theme/app_textsyle.dart';
import 'package:sahab_project/core/utils/icons/app_icons.dart';
import 'package:sahab_project/core/utils/widgets/custom_cached_svg_image.dart';
import 'package:sahab_project/feature/categories/data/model/category_model.dart';
import 'package:sahab_project/feature/services/presentation/widgets/service_card_view_all.dart';

class ServicesCard extends StatelessWidget {
  const ServicesCard({
    super.key,
    required this.category,
  });
  final CategoryModel category;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // print(category.id);
        Navigator.push(
          context,
          CupertinoPageRoute(
            builder: (context) => ServiceDetails(
                title: category.title ?? "N/A", categoryID: category.id ?? -1),
          ),
        );
      },
      child: Container(
        width: 170.w,
        height: 70.h,
        // margin: EdgeInsetsDirectional.only(start: 16.w),
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(5))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 30.w,
              height: 30.h,
              child: CustomCachedSvgImage(
                imageUrl: "${Constant.baseUrl}/${category.icon ?? ""}",
              ),

              //  SvgPicture.network(
              //     "${Constant.baseUrl}${category.icon ?? ""}"),
              // CachedNetworkImage(
              //   imageUrl: "${Constant.baseUrl}${category.icon ?? ""}",
              //   errorWidget: (context, url, error) => Icon(Icons.error),
              // ),
            ),
            // SvgPicture.asset(
            //   AppIcons.music,
            //   width: 30.w,
            //   height: 30.h,
            //   fit: BoxFit.cover,
            // ),
            SizedBox(
              width: 10.w,
            ),
            Text(category.title ?? "N/A",
                style: TextStyle(
                    fontFamily: AppStyles.getFontFamily(context),
                    fontWeight: FontWeight.w400,
                    fontSize: 16.sp,
                    color: AppColor.darkBlueColor))
          ],
        ),
      ),
    );
  }
}
