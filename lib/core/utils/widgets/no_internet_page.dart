import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sahab_project/core/theme/app_color.dart';
import 'package:sahab_project/core/theme/app_textsyle.dart';
import 'package:sahab_project/core/utils/icons/app_icons.dart';
import 'package:sahab_project/core/utils/widgets/app_button.dart';
import 'package:sahab_project/feature/boarding/presentation/manager/internet_cubit/connectivity_cubit.dart';
import 'package:sahab_project/feature/boarding/presentation/manager/skip_cubit/skip_cubit.dart';
import 'package:sahab_project/feature/boarding/presentation/pages/skip_screen.dart';

import '../../../generated/l10n.dart';

class NoInternetView extends StatelessWidget {
  const NoInternetView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<ConnectivityCubit, ConnectivityStatus>(
        listener: (context, state) {
          // TODO: implement listener
          if (state == ConnectivityStatus.connected) {
            // Navigator.pushAndRemoveUntil(
            //   context,
            //   MaterialPageRoute(
            //     builder: (_) => SkipScreen(),
            //   ),
            //   (route) {
            //     return false;
            //   },
            // );
          }
        },
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.stretch,
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Expanded(
              flex: 2,
              child: SizedBox(
                  // height: 107.h,
                  ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 130.w),
              child: AspectRatio(
                aspectRatio: 130.w / 70.h,
                child: SvgPicture.asset(
                  AppIcons.sahabText,
                ),
              ),
            ),
            // SizedBox(
            //   height: 96.h,
            // ),
            const Expanded(flex: 2, child: SizedBox()),
            // SvgPicture.asset(AppIcons.noInternet),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 130.w),
              child: AspectRatio(
                aspectRatio: 120.w / 124.h,
                child: SvgPicture.asset(
                  AppIcons.noInternet,
                ),
              ),
            ),
            // SizedBox(
            //   height: 44.h,
            // ),
            const Expanded(child: SizedBox()),
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Text(
                  S.of(context).your_Connection_is_Lost,
                  textAlign: TextAlign.center,
                  style: AppStyles.style22WhiteSemiBold(context)
                      .copyWith(color: AppColor.darkBlueColor),
                ),
              ),
            ),
            SizedBox(
              height: 15.h,
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Text(
                  S.of(context).check_internet_message,
                  textAlign: TextAlign.center,
                  style: AppStyles.style16(context)
                      .copyWith(color: AppColor.darkBlueColor),
                ),
              ),
            ),
            // SizedBox(
            //   height: 117.h,
            // ),
            const Expanded(flex: 2, child: SizedBox()),
            Padding(
              padding: const EdgeInsetsDirectional.only(
                start: 16,
                end: 16,
                bottom: 16,
              ),
              child: AppButton(
                height: 50.h,
                width: double.infinity,
                onTap: () async {
                  if (await ConnectivityCubit.get(context)
                          .checkInternetStatus() ==
                      ConnectivityStatus.connected) {
                    BlocProvider.of<SkipCubit>(context).getSkipPhoto(context);

                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (_) => SkipScreen(),
                      ),
                      (route) {
                        return false;
                      },
                    );
                  }
                },
                text: S.of(context).try_again,
                color: AppColor.blueColor,
                radius: 5,
                fontSize: 16.sp,
                fontFamily: AppStyles.getFontFamily(context),
                textColor: AppColor.whiteColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
