import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sahab_project/core/enums/type_post_enum.dart';
import 'package:sahab_project/core/utils/cache/cache_helper.dart';
import 'package:sahab_project/core/utils/widgets/circular_progress_indicator.dart';
import 'package:sahab_project/core/utils/widgets/custom_no_internet_and_error_view.dart';
import 'package:sahab_project/core/utils/widgets/custom_two_button.dart';
import 'package:sahab_project/feature/Bookings/presentation/views/widgets/no_booking_page.dart';
import 'package:sahab_project/feature/account/presentation/manager/place_post_vendor_cubit/place_post_vendor_cubit.dart';
import 'package:sahab_project/feature/account/presentation/manager/service_post_vendor_cubit/service_post_vendor_cubit.dart';
import 'package:sahab_project/feature/account/presentation/manager/toggle_place_service_cubit/toggle_place_service_cubit.dart';

import '../../../../../core/const.dart';
import '../../../../../core/theme/app_color.dart';
import '../../../../../core/theme/app_textsyle.dart';
import '../../../../../core/utils/icons/app_icons.dart';
import '../../../../../core/utils/widgets/app_button.dart';
import '../../../../../core/utils/widgets/custom_simple_app_bar_widget.dart';
import '../../../../../generated/l10n.dart';
import '../../../../add_edit_post/presentation/views/add_post_home_page.dart';
import 'post_card.dart';

class MyPostBody extends StatelessWidget {
  const MyPostBody({super.key});
// todo : finish translate
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomSimpleAppBarWidget(
          appBarTitle: S.of(context).my_post,
          trialing: AddPostIcon(),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 22.h),
          child: BlocBuilder<TogglePlaceServiceCubit, TogglePlaceServiceState>(
            builder: (context, state) {
              return CustomTwoButton(
                // buttonColor1: AppColor.blueColor,
                // buttonColor2: buttonColor2,
                buttonColor1: state is MyPostPlaceState
                    ? AppColor.blueColor
                    : AppColor.grey2Color,
                buttonColor2: state is MyPostServiceState
                    ? AppColor.blueColor
                    : AppColor.grey2Color,
                textColor1: state is MyPostPlaceState
                    ? const Color(0xffFFFFFF)
                    : AppColor.brownColor,
                textColor2: state is MyPostServiceState
                    ? const Color(0xffFFFFFF)
                    : AppColor.brownColor,
                text1: S.of(context).place,
                text2: S.of(context).services,
                onTap1: () {
                  print(CacheHelper.getData(key: Constant.kToken));
                  BlocProvider.of<TogglePlaceServiceCubit>(context)
                      .changeMyPostListView(TypeToggle.place);
                },
                onTap2: () {
                  BlocProvider.of<TogglePlaceServiceCubit>(context)
                      .changeMyPostListView(TypeToggle.service);
                },
              );
            },
          ),
        ),
        SizedBox(
          height: 1.h,
        ),
        BlocBuilder<TogglePlaceServiceCubit, TogglePlaceServiceState>(
          builder: (context, state) {
            if (state is MyPostPlaceState) {
              return PlaceVendorPostListView();
            } else if (state is MyPostServiceState) {
              return ServiceVendorPostListView();
            }
            return const SizedBox();
          },
        )
      ],
    );
  }
}

class PlaceVendorPostListView extends StatelessWidget {
  const PlaceVendorPostListView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: BlocBuilder<PlacePostVendorCubit, PlacePostVendorState>(
        builder: (context, state) {
          if (state is LoadingPlacePostVendorState) {
            return const Center(
              child: CustomCircularProgressIndicator(),
            );
          } else if (state is FailurePlacePostVendorState) {
            return CustomNoInternetAndErrorView(
              onTryAgainButton: () {
                BlocProvider.of<PlacePostVendorCubit>(context)
                    .getVendorPlacePosts(context);
              },
            );
          } else if (state is SuccessPlacePostVendorState) {
            if (state.placeVendorList.isEmpty) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: CustomNoDataPage(
                  message: S.of(context).no_post_added, // "No Post added",
                ),
              );
            }
            return ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: state.placeVendorList.length,
              itemBuilder: (context, index) {
                debugPrint("place post id :${state.placeVendorList[index].id}");
                return Padding(
                  padding: EdgeInsets.only(bottom: 21.h),
                  child: PostCard(
                    postID: state.placeVendorList[index].id ?? -1,
                    bookingStatus: state.placeVendorList[index].bookable,
                    categoryTitle: state.placeVendorList[index].title ?? "null",
                    postStatus: state.placeVendorList[index].available,
                    title: state.placeVendorList[index].title ?? "null",
                    typeToggle: TypeToggle.place,
                    imagePath: Constant.kPlaceImage,
                    urlPath: state
                            .placeVendorList[index].placeImages!.isNotEmpty
                        ? state.placeVendorList[index].placeImages![0].image ??
                            ""
                        : "",
                  ),
                );
              },
            );
          }
          return SizedBox();
        },
      ),
    );
  }
}

class ServiceVendorPostListView extends StatelessWidget {
  const ServiceVendorPostListView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: BlocBuilder<ServicePostVendorCubit, ServicePostVendorState>(
        builder: (context, state) {
          if (state is LoadingServicePostVendorState) {
            return const Center(
              child: CustomCircularProgressIndicator(),
            );
          } else if (state is FailureServicePostVendorState) {
            return CustomNoInternetAndErrorView(
              onTryAgainButton: () {
                BlocProvider.of<ServicePostVendorCubit>(context)
                    .getVendorServicePosts(context);
              },
            );
          } else if (state is SuccessServicePostVendorState) {
            if (state.serviceVendorList.isEmpty) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: CustomNoDataPage(
                  message: S.of(context).no_post_added, // "No Post added",
                ),
              );
            }
            return ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: state.serviceVendorList.length,
              itemBuilder: (context, index) {
                debugPrint("service id ${state.serviceVendorList[index].id}");
                return Padding(
                  padding: EdgeInsets.only(bottom: 21.h),
                  child: PostCard(
                    postID: state.serviceVendorList[index].id ?? -1,
                    // bookingStatus: state.serviceVendorList[index].bookable,
                    categoryTitle: state.serviceVendorList[index].title ?? "",
                    postStatus: state.serviceVendorList[index].available,
                    title: state.serviceVendorList[index].title ?? "",
                    typeToggle: TypeToggle.service,
                    imagePath: Constant.kPlaceImage,
                    urlPath:
                        state.serviceVendorList[index].serviceImages!.isNotEmpty
                            ? state.serviceVendorList[index].serviceImages![0]
                                    .image ??
                                ""
                            : "",
                  ),
                );
              },
            );
          }
          return SizedBox();
        },
      ),
    );
  }
}

class AddPostIcon extends StatelessWidget {
  const AddPostIcon({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(5),
      onTap: () {
        Navigator.of(context)
            .push(
          MaterialPageRoute(
            builder: (context) => const AddPostHomePage(
              isEdit: false,
            ),
          ),
        )
            .then((value) {
          if (value != null) {
            if (value["successMessage"] == "success") {
              print("okkk");
              BlocProvider.of<ServicePostVendorCubit>(context)
                  .getVendorServicePosts(context);
              BlocProvider.of<PlacePostVendorCubit>(context)
                  .getVendorPlacePosts(context);
            }
          }
        });
      },
      child: Padding(
        padding: EdgeInsetsDirectional.only(end: 16.w),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              S.of(context).add,
              style: AppStyles.style18(context),
            ),
            SvgPicture.asset(AppIcons.paperPlus)
          ],
        ),
      ),
    );
  }
}
