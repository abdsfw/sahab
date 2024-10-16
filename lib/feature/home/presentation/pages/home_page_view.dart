import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sahab_project/core/const.dart';
import 'package:sahab_project/core/theme/app_textsyle.dart';
import 'package:sahab_project/core/utils/functions/function.dart';
import 'package:sahab_project/core/utils/icons/app_icons.dart';
import 'package:sahab_project/feature/account/presentation/manager/static_value_cubit/static_value_cubit.dart';
import 'package:sahab_project/feature/categories/presentation/manager/cubit/category_cubit.dart';
import 'package:sahab_project/feature/categories/presentation/pages/categories_view.dart';
import 'package:sahab_project/feature/home/presentation/manager/bottomNavBar_cubit/bottom_nav_bar_cubit.dart';
import 'package:sahab_project/feature/home/presentation/manager/image_home_cubit/image_home_cubit.dart';
import 'package:sahab_project/feature/home/presentation/widgets/Category_card.dart';
import 'package:sahab_project/feature/home/presentation/widgets/bottom_nav_bar.dart';
import 'package:sahab_project/feature/home/presentation/widgets/build_title_row.dart';
import 'package:sahab_project/feature/home/presentation/widgets/header_home_page.dart';
import 'package:sahab_project/feature/home/presentation/widgets/places_card.dart';
import 'package:sahab_project/feature/home/presentation/widgets/services_card.dart';
import 'package:sahab_project/feature/home/presentation/widgets/shimmer_services_card.dart';
import 'package:sahab_project/feature/places/presentation/manager/place_cubit/place_cubit.dart';
import 'package:sahab_project/feature/places/presentation/pages/places_view.dart';
import 'package:sahab_project/feature/places/presentation/pages/places_view_old.dart';
import 'package:sahab_project/feature/serach/presentation/view/pages/serach_view.dart';
import 'package:sahab_project/feature/services/presentation/manager/service_cubit/service_cubit.dart';
import 'package:sahab_project/feature/services/presentation/pages/services_view.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../core/theme/app_color.dart';
import '../../../../core/utils/widgets/custom_app_title.dart';
import '../../../../core/utils/widgets/custom_scroll_photo_widget.dart';
import '../../../../generated/l10n.dart';
import '../manager/home_cubit/home_cubit.dart';
import '../widgets/shimmer_category_card.dart';
import '../widgets/shimmer_places_card.dart';

class HomePageView extends StatelessWidget {
  const HomePageView({super.key});

  @override
  Widget build(BuildContext context) {
    BottomNavBarCubit bottomNavBarCubit = BottomNavBarCubit.get(context);
    return BlocConsumer<BottomNavBarCubit, BottomNavBarState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          body: bottomNavBarCubit.pages[bottomNavBarCubit.currentIndex],
          bottomNavigationBar: const BottomNavBar(),
        );
      },
    );
  }
}

class HomePageBody extends StatefulWidget {
  const HomePageBody({super.key});

  @override
  State<HomePageBody> createState() => _HomePageBodyState();
}

class _HomePageBodyState extends State<HomePageBody> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // todo : finish translate

    HomeCubit homeCubit = HomeCubit.get(context);
    CategoryCubit categoryCubit = CategoryCubit.get(context);
    PlaceCubit placeCubit = PlaceCubit.get(context);
    ServiceCubit serviceCubit = ServiceCubit.get(context);
    ImageHomeCubit imageHomeCubit = ImageHomeCubit.get(context);
    // SendTokenCubit sendTokenCubit = SendTokenCubit.get(context);
    imageHomeCubit.getHomePic();
    categoryCubit.fetchCategory(context);
    // placeCubit.fetchPlace();
    serviceCubit.fetchServices(context);
    placeCubit.fetchAllFuturePlaces(context, query: "limit=7");
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: RefreshIndicator(
        color: AppColor.blueColor,
        onRefresh: () async {
          imageHomeCubit.getHomePic();
          categoryCubit.fetchCategory(context);
          // placeCubit.fetchPlace();
          serviceCubit.fetchServices(context);
          // homeCubit.fetchUserData(context);
          placeCubit.fetchAllFuturePlaces(context, query: "limit=7");
        },
        child: SafeArea(
          child: ListView(
            padding: const EdgeInsets.all(0),
            children: [
              SizedBox(height: 15.h),
              //? this heder .
              const HeaderHomePage(),

              SizedBox(height: 20.h),
              //? this Navigator To search Page
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SearchView(),
                      ));
                },
                child: Container(
                  width: double.infinity,
                  height: 55.h,
                  decoration: BoxDecoration(
                      color: AppColor.backGroundSearchColor,
                      borderRadius: BorderRadius.circular(
                        5,
                      ),
                      border: Border.all(
                          color: AppColor.borderSearchColor, width: 1)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.only(start: 20.w),
                        child: Text(
                          S.of(context).find_here,
                          style: AppStyles.style14(context)
                              .copyWith(color: AppColor.greyHintColor),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.only(end: 20.w),
                        child: SvgPicture.asset(
                          AppIcons.search,
                          height: 20.w,
                          width: 20.w,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 22.h),
              //! here the Ad View ..
              BlocBuilder<ImageHomeCubit, ImageHomeState>(
                builder: (context, state) {
                  if (state is ImageHomeSuccess) {
                    return CustomScrollPhotoWidget(
                      pageController: homeCubit.controller,
                      placeImage: imageHomeCubit.listHomeImage
                          .map((e) => "/${e.image}" ?? "")
                          .toList(),
                    );
                  } else if (state is ImageHomeLoading) {
                    return Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[100]!,
                        child: Container(
                            width: 1000.w,
                            height: 140.h,
                            decoration: const BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5))),
                            child: Image.asset(
                              Constant.kAdImage,
                            )));
                  } else if (state is ImageHomeFailure) {
                    return AspectRatio(
                      aspectRatio: 2,
                      child: CustomNetworkHomeErrorWidget(
                        // imageHomeCubit: imageHomeCubit,
                        errMessage: state.errMessage,
                        onTap: () {
                          BlocProvider.of<StaticValueCubit>(context)
                              .fetchStaticValue();

                          imageHomeCubit.getHomePic();
                        },
                      ),
                    );
                  } else {
                    return SizedBox();
                  }
                },
              ),
              SizedBox(height: 20.h),
              //! Here Category place
              buildTitleRow(
                S.of(context).popular,
                TextStyle(
                  fontFamily: AppStyles.getFontFamily(context),
                  fontWeight: FontWeight.w600,
                  color: AppColor.darkBlueColor,
                  fontSize: 20.sp,
                ),
                S.of(context).categories,
                TextStyle(
                  fontFamily: AppStyles.getFontFamily(context),
                  fontWeight: FontWeight.w400,
                  color: AppColor.darkBlueColor,
                  fontSize: 20.sp,
                ),
                () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const CategoriesView(),
                      ));
                },
                context,
              ),
              SizedBox(
                height: 10.h,
              ),
              //! List of category ..
              BlocConsumer<CategoryCubit, CategoryState>(
                listener: (context, state) {},
                builder: (context, state) {
                  if (state is CategoryLoading) {
                    return AspectRatio(
                      aspectRatio: 380.w / 180.h,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 3,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsetsDirectional.only(start: 15.w),
                            child: ShimmerCategoryCard(
                              height: 110.h,
                              width: 110.w,
                              margin: EdgeInsetsDirectional.only(start: 15.w),
                            ),
                          );
                        },
                      ),
                    );
                  } else if (state is CategoryFailure) {
                    return CustomNetworkHomeErrorWidget(
                      // imageHomeCubit: imageHomeCubit,
                      errMessage: state.error,
                      onTap: () {
                        BlocProvider.of<StaticValueCubit>(context)
                            .fetchStaticValue();

                        categoryCubit.fetchCategory(context);
                      },
                    );
                  } else {
                    return AspectRatio(
                      aspectRatio: 380.w / 180.h,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount:
                            min(categoryCubit.fetchCategoryList.length, 7),
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsetsDirectional.only(end: 15.w),
                            child: CategoryCard(
                              height: 110.h,
                              width: 110.w,
                              iconHeight: 48.h,
                              iconWidth: 48.w,
                              // margin: EdgeInsets.only(right: 15.w),
                              category: categoryCubit.fetchCategoryList[index],
                              fontSized: 16,
                              fontWeight: FontWeight.w400,
                              categoryId:
                                  categoryCubit.fetchCategoryList[index].id ??
                                      -1,
                            ),
                          );
                        },
                      ),
                    );
                  }
                },
              ),
              // ),
              // SizedBox(
              //   height: 12.h,
              // ),
              //! here is Service View
              buildTitleRow(
                S.of(context).services,
                TextStyle(
                  fontFamily: AppStyles.getFontFamily(context),
                  fontWeight: FontWeight.w600,
                  color: AppColor.darkBlueColor,
                  fontSize: 20.sp,
                ),
                S.of(context).we_provide,
                TextStyle(
                  fontFamily: AppStyles.getFontFamily(context),
                  fontWeight: FontWeight.w400,
                  color: AppColor.darkBlueColor,
                  fontSize: 20.sp,
                ),
                () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ServicesView(),
                    ),
                  );
                },
                context,
              ),
              SizedBox(
                height: 9.h,
              ),
              BlocConsumer<ServiceCubit, ServiceState>(
                listener: (context, state) {},
                builder: (context, state) {
                  if (state is ServiceLoading) {
                    return SizedBox(
                      height: 80.h,
                      child: ListView.builder(
                        padding: EdgeInsetsDirectional.zero,
                        scrollDirection: Axis.horizontal,
                        itemCount: 3,
                        itemBuilder: (context, index) {
                          return const ShimmerServicesCard();
                        },
                      ),
                    );
                  } else if (state is ServiceLoadFailure) {
                    return CustomNetworkHomeErrorWidget(
                      // imageHomeCubit: imageHomeCubit,
                      errMessage: state.errorMessage,
                      onTap: () {
                        BlocProvider.of<StaticValueCubit>(context)
                            .fetchStaticValue();

                        serviceCubit.fetchServices(context);
                      },
                    );
                  } else if (state is ServiceLoadSuccess) {
                    return SizedBox(
                      height: 80.h,
                      child: ListView.builder(
                        padding: EdgeInsets.zero,
                        scrollDirection: Axis.horizontal,
                        itemCount: min(serviceCubit.fetchServiceList.length, 7),
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsetsDirectional.only(end: 21.0.w),
                            child: ServicesCard(
                              category: serviceCubit.fetchServiceList[index],
                            ),
                          );
                        },
                      ),
                    );
                  } else {
                    return const SizedBox();
                  }
                },
              ),
              
              SizedBox(
                height: 22.h,
              ),
              if (placeCubit.homeFeaturedPlaces.length != 0)
                buildTitleRow(
                  S.of(context).featured,
                  AppStyles.style20semibold(context),
                  S.of(context).places,
                  AppStyles.style20(context),
                  () {
                    BlocProvider.of<PlaceCubit>(context)
                        .fetchAllFuturePlaces(context);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const PlacesView(),
                        ));
                  },
                  context,
                ),
              if (placeCubit.homeFeaturedPlaces.length != 0)
                SizedBox(
                  height: 10.h,
                ),
              if (placeCubit.homeFeaturedPlaces.length != 0)
                BlocConsumer<PlaceCubit, PlaceState>(
                  listener: (context, state) {},
                  builder: (context, state) {
                    if (state is PlaceLoading) {
                      return SizedBox(
                        height: 380.h,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: 4,
                          itemBuilder: (context, index) {
                            return const ShimmerPlacesCard();
                          },
                        ),
                      );
                    } else if (state is PlaceLoadFailure) {
                      return CustomNetworkHomeErrorWidget(
                        // imageHomeCubit: imageHomeCubit,
                        errMessage: state.errorMessage,
                        onTap: () {
                          BlocProvider.of<StaticValueCubit>(context)
                              .fetchStaticValue();

                          placeCubit.fetchAllFuturePlaces(context,
                              query: "limit=7");
                        },
                      );
                    } else {
                      return SizedBox(
                        height: 390.h,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: placeCubit.homeFeaturedPlaces
                              .length, //min(placeCubit.fetchedPlaced.length, 7),
                          itemBuilder: (context, index) {
                            String imagePath = '';
                            print(placeCubit
                                .homeFeaturedPlaces[index].placeImages?.length);
                            if (placeCubit.homeFeaturedPlaces[index].placeImages
                                    ?.isNotEmpty ??
                                false) {
                              imagePath = placeCubit.homeFeaturedPlaces[index]
                                      .placeImages?[0].image ??
                                  "";
                            }
                            return PlacesCard(
                              placeId: placeCubit.homeFeaturedPlaces[index].id,
                              imagePath: imagePath, // Constant.kPlaceImage,
                              title:
                                  placeCubit.homeFeaturedPlaces[index].title ??
                                      "",
                              dicVisibly: true,
                              rate: placeCubit.homeFeaturedPlaces[index].rating
                                  .toString(),
                              locationName: placeCubit
                                      .homeFeaturedPlaces[index].address ??
                                  "unknown place",
                              price: min(
                                  placeCubit.homeFeaturedPlaces[index]
                                          .weekdayPrice ??
                                      0,
                                  placeCubit.homeFeaturedPlaces[index]
                                          .weekdayPrice ??
                                      0),
                              tag: AppFunction.typeTranslate(
                                  placeCubit.homeFeaturedPlaces[index].tag ??
                                      "unknown tag",
                                  context),
                            );
                          },
                        ),
                      );
                    }
                  },
                ),

              SizedBox(
                height: 26.h,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomNetworkHomeErrorWidget extends StatelessWidget {
  const CustomNetworkHomeErrorWidget({
    super.key,
    required this.errMessage,
    this.onTap,
  });

  final String errMessage;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CustomAppTitle(
          title: errMessage, //state.errMessage,
        ),
        IconButton(
          onPressed: onTap,
          icon: Icon(
            Icons.replay_outlined,
          ),
        ),
      ],
    );
  }
}
