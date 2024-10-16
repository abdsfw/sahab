import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sahab_project/core/const.dart';
import 'package:sahab_project/core/theme/app_color.dart';
import 'package:shimmer/shimmer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class CustomScrollPhotoWidgetForDetails extends StatelessWidget {
  const CustomScrollPhotoWidgetForDetails({
    super.key,
    required this.pageController,
    this.imagePath = Constant.kAdImage,
    this.placeImage,
  });
  // todo : finish translate
  final PageController pageController;
  final String imagePath;
  final List<dynamic>? placeImage;
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: [
        AspectRatio(
          aspectRatio: 2,
          child: PageView.builder(
            controller:
                pageController, //BlocProvider.of<BookingCubit>(context).pageController,
            itemCount: placeImage?.length,
            itemBuilder: (context, index) => ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(5)),
              child: CachedNetworkImage(
                width: 1000.w,
                height: 140.h,
                fit: BoxFit.contain,
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
                imageUrl: "${Constant.baseUrl}${placeImage?[index].image}",
                errorWidget: (context, url, error) {
                  return Image.asset(
                    imagePath,
                    fit: BoxFit.cover,
                  );
                },
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsetsDirectional.only(bottom: 10.h),
          child: SmoothPageIndicator(
            // axisDirection: Axis.horizontal,
            controller:
                pageController, //BlocProvider.of<BookingCubit>(context).pageController,
            count: placeImage?.length ??
                4, //! How many the dot the user will show .
            effect: const WormEffect(
              dotHeight: 10,
              dotWidth: 10,
              activeDotColor: AppColor.secondPrimaryColor,
              // type: WormType.thinUnderground,
              dotColor: Colors.white,
            ),
          ),
        )
      ],
    );
  }
}
