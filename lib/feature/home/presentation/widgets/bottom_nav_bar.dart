import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sahab_project/core/const.dart';
import 'package:sahab_project/core/theme/app_textsyle.dart';
import 'package:sahab_project/core/utils/cache/cache_helper.dart';
import 'package:sahab_project/core/utils/icons/app_icons.dart';
import 'package:sahab_project/feature/account/presentation/manager/account_cubit/account_cubit.dart';
import 'package:sahab_project/feature/account/presentation/manager/static_value_cubit/static_value_cubit.dart';
import 'package:sahab_project/feature/auth/data/models/new_login_model/message.dart';
import 'package:sahab_project/feature/auth/data/models/new_login_model/new_login_model.dart';
import 'package:sahab_project/feature/auth/presentation/manager/cubit/login_cubit/cubit/login_cubit.dart';
import 'package:sahab_project/feature/home/presentation/manager/bottomNavBar_cubit/bottom_nav_bar_cubit.dart';
import 'package:sahab_project/feature/home/presentation/manager/home_cubit/home_cubit.dart';

import '../../../../core/theme/app_color.dart';
import '../../../../generated/l10n.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    Size size = MediaQuery.of(context).size;

    return BlocBuilder<BottomNavBarCubit, BottomNavBarState>(
      builder: (context, state) {
        return Container(
            // margin: EdgeInsets.all(20),
            height: size.width * .21,
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(.15),
                  blurRadius: 30,
                  offset: const Offset(0, 10),
                ),
              ],
              // borderRadius: BorderRadius.circular(50),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CustomBottomNavBarWidget(
                  currentIndex:
                      BlocProvider.of<BottomNavBarCubit>(context).currentIndex,
                  size: size,
                  title: S.of(context).Home,
                  index: 0, //index,
                  onTap: () {
                    BlocProvider.of<BottomNavBarCubit>(context)
                        .changeCurrentIndex(index: 0);
                    print(BlocProvider.of<BottomNavBarCubit>(context)
                        .currentIndex);
                  },
                ),
                CustomBottomNavBarWidget(
                  currentIndex:
                      BlocProvider.of<BottomNavBarCubit>(context).currentIndex,

                  size: size,
                  title: S.of(context).Bookings,
                  index: 1, //index,
                  onTap: () {
                    // CacheHelper.setData(
                    //     key: Constant.kToken,
                    //     value:
                    //         "24|EmiFBeKcZOsPzU0cxwilDsoC3bRRfyfelYPeHXyj4e872c59");
                    BlocProvider.of<BottomNavBarCubit>(context)
                        .changeCurrentIndex(index: 1);
                    print(BlocProvider.of<BottomNavBarCubit>(context)
                        .currentIndex);
                  },
                ),
                CustomBottomNavBarWidget(
                  currentIndex:
                      BlocProvider.of<BottomNavBarCubit>(context).currentIndex,

                  size: size,
                  title: S.of(context).Account,
                  index: 2, //index,
                  onTap: () {
                    BlocProvider.of<HomeCubit>(context).fetchUserData(context);

                    BlocProvider.of<AccountCubit>(context).setUserInfo();

                    if (BlocProvider.of<AccountCubit>(context).userRole ==
                        "vendor")
                      BlocProvider.of<StaticValueCubit>(context)
                          .fetchStaticValue();

                    BlocProvider.of<BottomNavBarCubit>(context)
                        .changeCurrentIndex(index: 2);
                    print(BlocProvider.of<BottomNavBarCubit>(context)
                        .currentIndex);
                  },
                ),
              ],
            )
            // ListView.builder(
            //   itemCount: 3,
            //   scrollDirection: Axis.horizontal,
            //   padding: EdgeInsets.symmetric(horizontal: size.width * .024),
            //   itemBuilder: (context, index) =>

            // ),
            );
      },
    );
  }

  // List<IconData> listOfIcons = [
}

class CustomBottomNavBarWidget extends StatelessWidget {
  const CustomBottomNavBarWidget({
    super.key,
    required this.currentIndex,
    required this.size,
    required this.index,
    this.onTap,
    required this.title,
  });

  final int currentIndex;
  final int index;
  final Size size;
  final void Function()? onTap;
  final String title;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 2000),
            curve: Curves.fastLinearToSlowEaseIn,
            margin: EdgeInsets.only(
              bottom: index == currentIndex ? 0 : size.width * .029,
              right: size.width * .0422,
              left: size.width * .0422,
            ),
            width: size.width * .128,
            height: index == currentIndex ? size.width * .016 : 0,
            decoration: const BoxDecoration(
              color: AppColor.blueColor,
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(10),
              ),
            ),
          ),
          SvgPicture.asset(
            listOfIcons[index],
            color: index == currentIndex ? AppColor.blueColor : Colors.black38,
          ),
          Text(
            title,
            style: AppStyles.textStyle12w500Blue(context).copyWith(
              color:
                  index == currentIndex ? AppColor.blueColor : Colors.black38,
            ),
          ),
          const SizedBox(),
        ],
      ),
    );
  }
}

List listOfIcons = [
  AppIcons.home,
  AppIcons.bookings,
  AppIcons.account,
];
