import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sahab_project/core/const.dart';
import 'package:sahab_project/core/notifiction/notification_cubit/notification_cubit.dart';
import 'package:sahab_project/core/theme/app_textsyle.dart';
import 'package:sahab_project/core/utils/cache/cache_helper.dart';
import 'package:sahab_project/core/utils/widgets/circular_progress_indicator.dart';
import 'package:sahab_project/core/utils/widgets/custom_no_internet_and_error_view.dart';
import 'package:sahab_project/feature/account/presentation/manager/account_cubit/account_cubit.dart';
import 'package:sahab_project/feature/auth/presentation/pages/login/login_screen.dart';
import 'package:sahab_project/feature/auth/presentation/pages/register/register_screen.dart';
import 'package:sahab_project/feature/boarding/presentation/manager/boarding_cubit/boarding_cubit.dart';
import 'package:sahab_project/feature/boarding/presentation/manager/skip_cubit/skip_cubit.dart';
import 'package:sahab_project/feature/boarding/presentation/pages/lang_screen.dart';
import 'package:sahab_project/feature/home/presentation/pages/home_page_view.dart';
import 'package:sahab_project/generated/l10n.dart';
import '../../../../core/utils/images/app_images_path.dart';
import '../../../../core/theme/app_color.dart';
import '../../../../core/utils/widgets/app_button.dart';
import '../../../../core/utils/widgets/background_app.dart';

// @RoutePage()
class SkipScreen extends StatelessWidget {
  const SkipScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return BlocProvider(
      create: (context) => BoardingCubit(),
      child: BlocConsumer<BoardingCubit, BoardingState>(
        listener: (context, state) async {
          if (state is ChangeSkipScreenState) {
            if (CacheHelper.getData(key: Constant.kIsFirstTime) == null ||
                CacheHelper.getData(key: Constant.kIsFirstTime) == true) {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) => const LangScreen()),
              // );
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => LangScreen()),
                (route) => false,
              );
            } else {
              String role = await CacheHelper.getData(key: Constant.kUserRole);

              if (CacheHelper.getData(key: Constant.kIsRegister) == true ||
                  role == "guest") {
                //? this call for set user info into cubit
                BlocProvider.of<AccountCubit>(context).setUserInfo();
                if (role != "guest") {
                  BlocProvider.of<NotificationCubit>(context)
                      .sendNotificationToken();
                }
                //? --------------------------------------
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => HomePageView()),
                  (route) => false,
                );
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => const HomePageView(),
                //   ),
                // );
              }
              //!endIf isRegister
              else {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => LoginScreen(),
                //   ),
                // );
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                  (route) => false,
                );
              }
              //!endElse isRegister
            }
          }
          BlocProvider.of<BoardingCubit>(context).close();
        },
        builder: (context, state) {
          return Scaffold(
            body: BlocBuilder<SkipCubit, SkipState>(
              builder: (context, state) {
                if (state is LoadingGetPhotoState) {
                  return Center(
                    child: CustomCircularProgressIndicator(),
                  );
                } else if (state is FailureGetPhotoState) {
                  return CustomNoInternetAndErrorView(
                    onTryAgainButton: () {
                      BlocProvider.of<SkipCubit>(context).getSkipPhoto(context);
                    },
                  );
                } else if (state is SuccessGetPhotoState) {
                  return Stack(
                    children: [
                      BackgroundApp(
                        widget: CachedNetworkImage(
                          imageUrl:
                              "${Constant.baseUrl}/${state.skipData.image}",
                          errorWidget: (context, url, error) => Image.asset(
                            AppImagesPath.skip,
                            width: w,
                            height: h,
                            fit: BoxFit.fill,
                          ),
                          height: h,
                          width: w,
                          fit: BoxFit.fill,
                        ),
                      ),
                      Positioned(
                        bottom: 15.h,
                        right: 22.86.w,
                        left: 21.w,
                        child: AppButton(
                            width: w,
                            height: 50.h,
                            onTap: () {
                              BlocProvider.of<BoardingCubit>(context)
                                  .changeSkipScreen();
                            },
                            text: S.of(context).skip,
                            color: AppColor.blueColor,
                            radius: 10.r,
                            fontSize: 16.sp,
                            fontFamily: AppStyles.getFontFamily(context),
                            textColor: AppColor.textColor,
                            fontWeight: FontWeight.w600),
                      )
                    ],
                  );
                } else {
                  return SizedBox();
                }
              },
            ),
          );
        },
      ),
    );
  }
}

// GestureDetector(
// onTap: () {},
// child: Container(
// width: w,
// height: 50.h,
// decoration: BoxDecoration(
// color: AppColor.blueColor,
// borderRadius:
// BorderRadius.all(Radius.circular(10.r))),
// child: Center(
// child: Text(
// 'Skip',
// style: TextStyle(
// fontSize: 16.sp,
// color: AppColor.textColor,
// fontWeight: FontWeight.w600),
// )),
// ),
// )
