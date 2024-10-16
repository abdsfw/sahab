import 'package:cached_network_svg_image/cached_network_svg_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sahab_project/core/const.dart';
import 'package:sahab_project/core/theme/app_textsyle.dart';
import 'package:sahab_project/core/utils/icons/app_icons.dart';
import 'package:sahab_project/core/utils/widgets/custom_cached_svg_image.dart';
import 'package:sahab_project/feature/categories/presentation/pages/places_category_view.dart';
import 'package:sahab_project/feature/home/presentation/widgets/shimmer_category_card.dart';
import 'package:shimmer/shimmer.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../../core/theme/app_color.dart';
import '../../../categories/data/model/category_model.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard({
    super.key,
    required this.width,
    required this.height,
    required this.category,
    this.margin,
    required this.iconHeight,
    required this.iconWidth,
    required this.fontSized,
    required this.fontWeight,
    required this.categoryId,
  });
  final double width;
  final double height;
  final double iconHeight;
  final double iconWidth;
  final int fontSized;
  final FontWeight fontWeight;
  final EdgeInsetsGeometry? margin;
  final CategoryModel category;
  final int categoryId;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print("category id: $categoryId");
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PlacesCategoryView(
                  id: categoryId, title: category.title ?? ""),
            ));
      },
      child: Column(
        children: [
          Container(
            width: width,
            height: height,
            margin: margin,
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(5))),
            child: Center(
              child: CustomCachedSvgImage(
                imageUrl: "${Constant.baseUrl}/${category.icon}",
                width: 48.w,
                height: 46.h,
              ),
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          Text(
            category.title ?? "",
            style: TextStyle(
                fontFamily: AppStyles.getFontFamily(context),
                fontWeight: fontWeight,
                fontSize: fontSized.sp,
                color: AppColor.brownColor), //AppStyles.style16(context),
          ),
        ],
      ),
    );
  }
}
