import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sahab_project/feature/places/data/model/place_details_model.dart';
import 'package:shimmer/shimmer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../const.dart';
import '../../theme/app_color.dart';
import 'package:carousel_slider/carousel_slider.dart';

class CustomScrollPhotoWidget extends StatelessWidget {
  const CustomScrollPhotoWidget({
    super.key,
    required this.pageController,
    this.imagePathOnError = Constant.kAdImage,
    this.placeImage,
  });
  final PageController pageController;
  final String imagePathOnError;
  final List<String>? placeImage;
  @override
  Widget build(BuildContext context) {
    if (placeImage!.isEmpty) {
      return Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: [
          AspectRatio(
            aspectRatio: 2,
            child: PageView.builder(
              controller:
                  pageController, //BlocProvider.of<BookingCubit>(context).pageController,
              itemCount: 1, // placeImage?.length,
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsetsDirectional.symmetric(horizontal: 0),
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(5)),
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
                    imageUrl: "",
                    errorWidget: (context, url, error) {
                      return //Icon(Icons.error);
                          Image.asset(
                        Constant.kLogoImage,
                        // fit: BoxFit.cover,
                      );
                    },
                  ),
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
              count: 1 //,placeImage?.length ??
              , //! How many the dot the user will show .
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
    } else {
      return Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: [
          AspectRatio(
            aspectRatio: 2,
            child: PageView.builder(
                controller:
                    pageController, //BlocProvider.of<BookingCubit>(context).pageController,
                itemCount: placeImage?.length,
                itemBuilder: (context, index) {
                  print("${Constant.baseUrl}${placeImage?[index]}");

                  return Padding(
                    padding:
                        const EdgeInsetsDirectional.symmetric(horizontal: 0),
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(5)),
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
                              child: Image.asset(
                                Constant.kAdImage,
                              ),
                            ),
                          );
                        },
                        imageUrl: "${Constant.baseUrl}${placeImage?[index]}",
                        errorWidget: (context, url, error) {
                          return //Icon(Icons.error);
                              Image.asset(
                            Constant.kLogoImage,
                            // fit: BoxFit.cover,
                          );
                        },
                      ),
                    ),
                  );
                }),
          ),
          Padding(
            padding: EdgeInsetsDirectional.only(bottom: 10.h),
            child: SmoothPageIndicator(
              // axisDirection: Axis.horizontal,
              controller:
                  pageController, //BlocProvider.of<BookingCubit>(context).pageController,
              count: placeImage?.length ??
                  1, //! How many the dot the user will show .
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
}
