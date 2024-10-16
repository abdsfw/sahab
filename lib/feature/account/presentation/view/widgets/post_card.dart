import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sahab_project/core/enums/type_post_enum.dart';
import 'package:sahab_project/core/theme/app_color.dart';
import 'package:sahab_project/core/theme/app_textsyle.dart';
import 'package:sahab_project/core/utils/functions/function.dart';
import 'package:sahab_project/core/utils/icons/app_icons.dart';
import 'package:sahab_project/core/utils/widgets/app_button.dart';
import 'package:sahab_project/feature/account/presentation/manager/my_post_cubit/my_post_cubit.dart';
import 'package:sahab_project/feature/account/presentation/manager/place_post_vendor_cubit/place_post_vendor_cubit.dart';
import 'package:sahab_project/feature/account/presentation/manager/service_post_vendor_cubit/service_post_vendor_cubit.dart';
import 'package:sahab_project/feature/account/presentation/manager/switcher_cubit/switcher_cubit.dart';
import 'package:sahab_project/feature/account/presentation/view/pages/place_post_details.dart';
import 'package:sahab_project/feature/account/presentation/view/pages/service_post_details.dart';
import 'package:sahab_project/feature/account/presentation/view/widgets/post_option.dart';
import 'package:sahab_project/feature/add_edit_post/presentation/manager/next_post_place_cubit/next_post_place_cubit.dart';
import 'package:sahab_project/feature/add_edit_post/presentation/views/add_post_home_page.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../../core/const.dart';
import '../../../../../generated/l10n.dart';

class PostCard extends StatelessWidget {
  const PostCard({
    super.key,
    required this.imagePath,
    required this.urlPath,
    required this.title,
    required this.categoryTitle,
    this.bookingStatus,
    this.postStatus,
    required this.typeToggle,
    required this.postID,
  });
  final String imagePath;
  final String urlPath;
  final String title;
  final String categoryTitle;
  final bool? bookingStatus;
  final bool? postStatus;
  final int postID;
  final TypeToggle typeToggle;
  // todo : finish translate
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 14.w),
      // width: 319.w,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(5)),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Color(0x3FDADADA),
            blurRadius: 4,
            offset: Offset(0, 4),
            spreadRadius: 0,
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 9.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PhotoAndTitle(
              imagePath: imagePath,
              urlPath: urlPath,
              title: '$title', //postID.toString(),
              categoryTitle: categoryTitle,
            ),
            SizedBox(height: 10.h),
            StatusContainer(
              bookingStatus: bookingStatus ?? true,
              postStatus: postStatus ?? true,
              typeToggle: typeToggle,
            ),
            SizedBox(
              height: 30.h,
            ),
            OptionButtons(
              postID: postID,
              typeToggle: typeToggle,
              bookingStatus: bookingStatus ?? true,
              postStatus: postStatus ?? true,
            ),
            SizedBox(
              height: 38.h,
            ),
          ],
        ),
      ),
    );
  }
}

class PhotoAndTitle extends StatelessWidget {
  const PhotoAndTitle({
    super.key,
    required this.imagePath,
    required this.urlPath,
    required this.title,
    required this.categoryTitle,
  });

  final String imagePath;
  final String urlPath;
  final String title;
  final String categoryTitle;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 10.h),
          child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(5)),
            child: AspectRatio(
              aspectRatio: 319.w / 180.h,
              child: CachedNetworkImage(
                fit: BoxFit.cover,
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
                imageUrl: "${Constant.baseUrl}$urlPath",
                errorWidget: (context, url, error) {
                  return Image.asset(
                    imagePath,
                    fit: BoxFit.cover,
                  );
                },
              ),
              // Image.asset(
              //   imagePath,
              //   fit: BoxFit.cover,
              // ),
            ),
          ),
        ),
        SizedBox(height: 5.h),
        Text(
          title,
          style: AppStyles.style18semibold(context),
        ),
        SizedBox(height: 5.h),
        Text(
          categoryTitle,
          maxLines: 1,
          style: AppStyles.style16w500(context),
        ),
      ],
    );
  }
}

class OptionButtons extends StatelessWidget {
  const OptionButtons({
    super.key,
    required this.postID,
    required this.typeToggle,
    required this.postStatus,
    required this.bookingStatus,
  });
  final int postID;
  final TypeToggle typeToggle;
  final bool postStatus;
  final bool bookingStatus;
// todo : finish translate
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        PostOption(
          color: AppColor.blueColor,
          iconPath: AppIcons.details,
          text: S.of(context).details,
          onTap: () {
            if (typeToggle == TypeToggle.place) {
              Navigator.of(context)
                  .push(
                CupertinoPageRoute(
                  builder: (context) => PlacePostDetails(
                    postId: postID,
                    // typeToggle: typeToggle,
                  ),
                ),
              )
                  .then((value) {
                if (value == "success") {
                  BlocProvider.of<PlacePostVendorCubit>(context)
                      .getVendorPlacePosts(context);
                }
              });
            } else if (typeToggle == TypeToggle.service) {
              Navigator.of(context)
                  .push(
                CupertinoPageRoute(
                  builder: (context) => ServicePostDetails(
                    postId: postID,
                  ),
                ),
              )
                  .then((value) {
                if (value == "success") {
                  BlocProvider.of<ServicePostVendorCubit>(context)
                      .getVendorServicePosts(context);
                }
              });
              ;
            }
          },
        ),
        PostOption(
          color: AppColor.excellentColor,
          iconPath: AppIcons.setting,
          text: S.of(context).manage,
          onTap: () {
            buildManageBottomSheet(
              context,
              bookingStatus: bookingStatus,
              postStatus: postStatus,
              typeToggle: typeToggle,
            ).then((value) {
              if (typeToggle == TypeToggle.place) {
                BlocProvider.of<MyPostCubit>(context)
                    .manageVendorPlacePost(placeId: postID, data: value);
              } else {
                BlocProvider.of<MyPostCubit>(context)
                    .manageVendorServicePost(serviceId: postID, data: value);
              }
              // print(value);
            });
          },
        ),
        PostOption(
          color: AppColor.secondPrimaryColor,
          iconPath: AppIcons.editPost,
          text: S.of(context).edit,
          onTap: () {
            Navigator.of(context)
                .push(
              CupertinoPageRoute(
                builder: (context) => AddPostHomePage(
                  isEdit: true,
                  postID: postID,
                  typeToggle: typeToggle,
                ),
              ),
            )
                .then((value) {
              if (value != null) {
                if (value["typeToggle"] == TypeToggle.place) {
                  BlocProvider.of<PlacePostVendorCubit>(context)
                      .getVendorPlacePosts(context);
                } else if (value["typeToggle"] == TypeToggle.service) {
                  BlocProvider.of<ServicePostVendorCubit>(context)
                      .getVendorServicePosts(context);
                }
              }
            });
          },
        ),
        PostOption(
          color: AppColor.redColor,
          iconPath: AppIcons.delete,
          text: S.of(context).delete,
          onTap: () {
            AppFunction.deleteQuestionDialog(
              context,
              title: S.of(context).delete_post, // "Delete Post",
              text1: S
                  .of(context)
                  .first_delete_post_message, // "Are you sure want to Delete This Post",
              text2: S
                  .of(context)
                  .second_delete_reservation_message, //"deleting post will not effect on any previous bookings",
              onYesTap: () async {
                if (typeToggle == TypeToggle.place) {
                  BlocProvider.of<MyPostCubit>(context)
                      .deleteVendorPlacePost(placeId: postID);
                  Navigator.of(context).pop();
                  print("place");
                } else {
                  print("service");
                  print(postID);
                  BlocProvider.of<MyPostCubit>(context)
                      .deleteVendorServicePost(serviceId: postID);
                  Navigator.of(context).pop();
                }
              },
              onNoTap: () {
                Navigator.of(context).pop();
              },
              isLoading: false,
            );
          },
        ),
      ],
    );
  }

  Future<dynamic> buildManageBottomSheet(
    BuildContext context, {
    required bool bookingStatus,
    required bool postStatus,
    required TypeToggle typeToggle,
  }) {
    return showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return BlocProvider(
          create: (context) => SwitcherCubit()
            ..setPostBookingVar(
              bookingActive: bookingStatus,
              postActive: postStatus,
            ),
          child: Builder(builder: (context) {
            return Container(
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(
                  0.5,
                ), // Adjust the opacity and color as per your requirement
                borderRadius: BorderRadiusDirectional.only(
                  topStart: Radius.circular(
                    30.r,
                  ),
                  topEnd: Radius.circular(
                    30.r,
                  ),
                ),
              ),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadiusDirectional.only(
                    topStart: Radius.circular(
                      30.r,
                    ),
                    topEnd: Radius.circular(
                      30.r,
                    ),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(height: 36.h),
                      Text(
                        S.of(context).manage_post, //'Manage Post',
                        style: AppStyles.textStyle20w700Blue(context).copyWith(
                            fontWeight: FontWeight.w600, color: Colors.black),
                      ),
                      SizedBox(height: 13.h),
                      BlocBuilder<SwitcherCubit, SwitcherState>(
                        builder: (context, state) {
                          SwitcherCubit switcherCubit =
                              SwitcherCubit.get(context);
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              RowOfManageBottomSheet(
                                title: S.of(context).post_status,
                                subTitle: S.of(context).active,
                                value: switcherCubit.postActive!,
                                onChange: (value) {
                                  switcherCubit.changeBoolVariable(
                                      isPost: true, value: value);
                                },
                              ),
                              if (typeToggle != TypeToggle.service)
                                SizedBox(height: 10.h),
                              if (typeToggle != TypeToggle.service)
                                RowOfManageBottomSheet(
                                  title: S.of(context).booking_status,
                                  subTitle: S.of(context).open_for_booking,
                                  value: switcherCubit.bookingActive!,
                                  onChange: (value) {
                                    switcherCubit.changeBoolVariable(
                                        isPost: false, value: value);
                                  },
                                ),
                            ],
                          );
                        },
                      ),
                      SizedBox(height: 32.h),
                      AppButton(
                        onTap: () {
                          Map<String, String> data = {
                            "available": BlocProvider.of<SwitcherCubit>(context)
                                    .postActive!
                                ? '1'
                                : '0',
                            "bookable": BlocProvider.of<SwitcherCubit>(context)
                                    .bookingActive!
                                ? '1'
                                : '0',
                          };
                          Navigator.of(context).pop(data);
                        },
                        text: S.of(context).done, //'Done',
                        color: AppColor.blueColor,
                        radius: 5.r,
                        height: 50.h,
                        fontSize: 16.sp,
                        textColor: AppColor.whiteColor,
                        fontWeight: FontWeight.w600,
                      ),
                      SizedBox(height: 32.h),
                    ],
                  ),
                ),
              ),
            );
          }),
        );
      },
    );
  }
}

class RowOfManageBottomSheet extends StatelessWidget {
  const RowOfManageBottomSheet({
    super.key,
    required this.title,
    required this.subTitle,
    required this.value,
    required this.onChange,
  });
// todo : finish translate
  final String title;
  final String subTitle;
  final bool value;
  final void Function(bool value) onChange;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title, //S.of(context).post_status,
              style: AppStyles.style17semibold(context)
                  .copyWith(color: Colors.black),
            ),
            Text(
              subTitle, //S.of(context).active,
              style: AppStyles.style16(context).copyWith(color: Colors.black),
            ),
          ],
        ),
        SizedBox(
          width: 50,
          height: 31,
          child: CupertinoSwitch(
            value: value,
            onChanged: onChange,
          ),
        ),
      ],
    );
  }
}

class StatusContainer extends StatelessWidget {
  const StatusContainer({
    super.key,
    required this.postStatus,
    required this.bookingStatus,
    required this.typeToggle,
  });
  final bool postStatus;
  final bool bookingStatus;
  final TypeToggle typeToggle;
// todo : finish translate
  @override
  Widget build(BuildContext context) {
    //? this for change state of container status
    Color? containerColor;
    String firstTitle = "";
    String firstValue = "";
    if (typeToggle == TypeToggle.place) {
      firstTitle = S.of(context).post_status;
      firstValue = postStatus ? S.of(context).active : S.of(context).in_active;
      if (postStatus && bookingStatus) {
        containerColor = const Color(0x33368543);
      } else if (!postStatus && !bookingStatus) {
        containerColor = AppColor.redColor.withOpacity(0.2);
      } else {
        containerColor = AppColor.greyColor.withOpacity(0.2);
      }
    } else {
      firstTitle = (postStatus) ? S.of(context).active : S.of(context).inactive;
      firstValue = (postStatus)
          ? S.of(context).open_for_booking
          : S.of(context).closed_for_booking;
      if (postStatus) {
        containerColor = const Color(0x33368543);
      } else {
        containerColor = AppColor.redColor.withOpacity(0.2);
      }
    }
    //? -----------------------------------------
    return Container(
      width: double.infinity,
      decoration: ShapeDecoration(
        color: containerColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: Padding(
        padding: EdgeInsetsDirectional.only(start: 15.w, top: 10.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              firstTitle,
              style: AppStyles.style16(context).copyWith(
                color: Colors.black,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              firstValue,
              style: AppStyles.style16(context).copyWith(
                color: (postStatus) ? AppColor.greenColor : AppColor.redColor,
                fontWeight: FontWeight.w500,
              ),
            ),
            (typeToggle == TypeToggle.service)
                ? SizedBox()
                : Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 10.h),
                      Text(
                        S.of(context).booking_status,
                        style: AppStyles.style16(context).copyWith(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        (bookingStatus)
                            ? S.of(context).open_for_booking
                            : S.of(context).closed_for_booking,
                        style: AppStyles.style16(context).copyWith(
                          color: (bookingStatus)
                              ? AppColor.greenColor
                              : AppColor.redColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
            SizedBox(height: 10.h),
          ],
        ),
      ),
    );
  }
}
