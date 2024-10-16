import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sahab_project/core/const.dart';
import 'package:sahab_project/core/theme/app_color.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../manager/home_cubit/home_cubit.dart';

class AdCard extends StatelessWidget {
  const AdCard({
    super.key,
    required this.homeCubit,
  });

  final HomeCubit homeCubit;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: 1000.w,
          height: 140.h,
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(5))),
          child: Image.asset(
            Constant.kAdImage,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 5),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: SmoothPageIndicator(
              axisDirection: Axis.horizontal,
              controller: homeCubit.controller,
              count: 3, //! How many the dot the user will show .
              effect: const WormEffect(
                dotHeight: 10,
                dotWidth: 10,
                activeDotColor: AppColor.secondPrimaryColor,
                type: WormType.thinUnderground,
                dotColor: Colors.white,
              ),
            ),
          ),
        )
      ],
    );
  }
}
