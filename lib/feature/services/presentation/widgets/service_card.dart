import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sahab_project/core/const.dart';
import 'package:sahab_project/core/theme/app_color.dart';
import 'package:sahab_project/core/theme/app_textsyle.dart';
import 'package:sahab_project/core/utils/icons/app_icons.dart';
import 'package:sahab_project/core/utils/widgets/custom_cached_svg_image.dart';
import 'package:sahab_project/feature/categories/data/model/category_model.dart';
import 'package:sahab_project/feature/services/data/model/service_model.dart';
import 'package:shimmer/shimmer.dart';
import 'service_card_view_all.dart';

class ServicesCard extends StatelessWidget {
  const ServicesCard({
    super.key,
    required this.category,
    this.sized,
  });
  final CategoryModel category;
  final double? sized;
  @override
  Widget build(BuildContext context) {
    //! show all service
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ServiceDetails(
              title: category.title ?? "N/A",
              categoryID: category.id ?? -1,
            ),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.only(left: 16.w, right: 16.w, bottom: 28.h),
        width: 361.w,
        height: 120.h,
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(5))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              width: 30.w,
            ),
            CustomCachedSvgImage(
              height: 30,
              width: 30,
              imageUrl: "${Constant.baseUrl}/${category.icon ?? ""}",
            ),
            SizedBox(
              width: 30.w,
            ),
            Text(
              category.title ?? "N/A",
              style: AppStyles.style18(context).copyWith(
                  color: AppColor.brownColor, fontWeight: FontWeight.w500),
            )
          ],
        ),
      ),
    );
  }
}
