import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:sahab_project/core/enums/type_post_enum.dart';
import 'package:sahab_project/core/theme/app_color.dart';
import 'package:sahab_project/core/theme/app_textsyle.dart';
import 'package:sahab_project/core/utils/functions/function.dart';
import 'package:sahab_project/core/utils/widgets/circular_progress_indicator.dart';
import 'package:sahab_project/core/utils/widgets/custom_no_internet_and_error_view.dart';
import 'package:sahab_project/core/utils/widgets/custom_scroll_photo_widget.dart';
import 'package:sahab_project/core/utils/widgets/custom_simple_app_bar_widget.dart';
// import 'package:sahab_project/core/utils/widgets/custom_simple_app_bar_widget.dart';
import 'package:sahab_project/core/utils/widgets/custom_two_button.dart';
import 'package:sahab_project/core/utils/widgets/details_title.dart';
import 'package:sahab_project/feature/account/data/model/place_post_details_model/amenity.dart';
import 'package:sahab_project/feature/account/data/model/place_post_details_model/place_image.dart';
import 'package:sahab_project/feature/account/data/model/place_post_details_model/place_post_details_model.dart';
import 'package:sahab_project/feature/account/presentation/manager/details_delete_cubit/details_delete_cubit.dart';
import 'package:sahab_project/feature/account/presentation/manager/details_vendor_post_cubit/details_vendor_post_cubit.dart';
import 'package:sahab_project/feature/add_edit_post/presentation/views/add_post_home_page.dart';
import 'package:sahab_project/feature/home/presentation/widgets/details_card.dart';
import 'package:sahab_project/feature/places/presentation/widgets/amenities_item.dart';
import 'package:sahab_project/feature/places/presentation/widgets/description_widget.dart';

import '../../../../../core/utils/icons/app_icons.dart';
import '../../../../../generated/l10n.dart';

class PlacePostDetails extends StatelessWidget {
  const PlacePostDetails({
    super.key,
    // required this.typeToggle,
    required this.postId,
  });
  // final TypeToggle typeToggle;
  final int postId;
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => DetailsVendorPostCubit()
            ..getDetailsPlacePost(context, placeId: postId),
        ),
        BlocProvider(
          create: (context) => DetailsDeleteCubit(),
        ),
      ],
      child: BlocConsumer<DetailsDeleteCubit, DetailsDeleteState>(
        listener: (context, state) {
          // TODO: implement listener
          if (state is SuccessDeletePostState) {
            Navigator.of(context).pop("success");
          } else if (state is FailureDeletePostState) {
            AppFunction.confirmDialog(
              context,
              title: S.of(context).an_error_occurred_while_deleting,
              onYesTap: () {
                Navigator.of(context).pop();
              },
            );
          }
        },
        builder: (context, state) {
          return ModalProgressHUD(
            inAsyncCall: state is LoadingDeletePostState,
            progressIndicator: CustomCircularProgressIndicator(),
            child: Scaffold(
              body: Column(
                children: [
                  CustomSimpleAppBarWidget(
                    appBarTitle: S.of(context).details, // "Details",
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  BlocBuilder<DetailsVendorPostCubit, DetailsVendorPostState>(
                    builder: (context, state) {
                      if (state is LoadingGetDetailsPostState) {
                        return Expanded(
                          child: Center(
                            child: CustomCircularProgressIndicator(),
                          ),
                        );
                      } else if (state is FailureGetDetailsPostState) {
                        return Expanded(
                          child: CustomNoInternetAndErrorView(
                            onTryAgainButton: () {
                              BlocProvider.of<DetailsVendorPostCubit>(context)
                                  .getDetailsPlacePost(context,
                                      placeId: postId);
                            },
                          ),
                        );
                      } else if (state is SuccessGetDetailsPostPlaceState) {
                        return Expanded(
                          child: PlacePostDetailsBody(
                            placeDetails: state.placePostDetailsModel,
                          ),
                        );
                      }
                      return SizedBox();
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class PlacePostDetailsBody extends StatelessWidget {
  const PlacePostDetailsBody({
    super.key,
    required this.placeDetails,
  });
  final PlacePostDetailsModel placeDetails;
  @override
  Widget build(BuildContext context) {
    return ListView(
      // crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        PictureAndTitleSection(
          postImageList:
              placeDetails.placeImages?.map((e) => e.image ?? "").toList() ??
                  [],
          postTitle: placeDetails.title ?? "",
          tag: AppFunction.typeTranslate(placeDetails.tag ?? "", context),
          secondTitle:
              "${S.of(context).starting_from} ${placeDetails.weekdayPrice} KD",
        ),
        Divider(),
        AmenitiesListView(
          amenityList: placeDetails.amenities!,
        ),
        Divider(),
        AddressSection(
          address: placeDetails.address ?? "",
        ),
        const Divider(),
        AboutSection(
          title: placeDetails.title ?? "",
          aboutContent: placeDetails.description ?? "",
        ),
        Padding(
          padding: EdgeInsetsDirectional.only(
            start: 16.w,
            end: 16.w,
            bottom: 30.h,
          ),
          child: CustomTwoButton(
            buttonColor1: AppColor.blueColor,
            buttonColor2: AppColor.redColor,
            onTap1: () {
              Navigator.of(context)
                  .push(
                CupertinoPageRoute(
                  builder: (context) => AddPostHomePage(
                    isEdit: true,
                    postID: placeDetails.id,
                    typeToggle: TypeToggle.place,
                  ),
                ),
              )
                  .then((value) {
                if (value != null) {
                  if (value["successMessage"] == "success")
                    BlocProvider.of<DetailsVendorPostCubit>(context)
                        .getDetailsPlacePost(context,
                            placeId: placeDetails.id ?? -1);
                }
              });
            },
            onTap2: () {
              AppFunction.deleteQuestionDialog(
                context,
                title: S.of(context).delete_post, // "Delete Post",
                text1: S
                    .of(context)
                    .first_delete_post_message, // "Are you sure want to Delete This Post",
                text2: S.of(context).second_delete_reservation_message,
                onYesTap: () async {
                  // if (typeToggle == TypeToggle.place) {
                  BlocProvider.of<DetailsDeleteCubit>(context)
                      .deleteVendorPlacePost(placeId: placeDetails.id ?? -1);
                  Navigator.of(context).pop();
                  // print("place");
                  // } else {
                  //   print("service");
                  //   print(postID);
                  //   BlocProvider.of<MyPostCubit>(context)
                  //       .deleteVendorServicePost(serviceId: postID);
                  //   Navigator.of(context).pop();
                  // }
                },
                onNoTap: () {
                  Navigator.of(context).pop();
                },
                isLoading: false,
              );
            },
            text1: S.of(context).edit, //"edit",
            text2: S.of(context).delete, //"delete",
            textColor1: AppColor.whiteColor,
            textColor2: AppColor.whiteColor,
          ),
        ),
      ],
    );
  }
}

class AboutSection extends StatelessWidget {
  const AboutSection({
    super.key,
    required this.title,
    required this.aboutContent,
  });
  final String title;
  final String aboutContent;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DetailsTitle(title: "${S.of(context).about} $title"),
        DescriptionWidget(
          content: aboutContent,
        ),
      ],
    );
  }
}

class AddressSection extends StatelessWidget {
  const AddressSection({
    super.key,
    required this.address,
  });
  final String address;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DetailsTitle(title: S.of(context).address),
        Padding(
          padding:
              EdgeInsetsDirectional.only(start: 16.w, top: 3.h, bottom: 36.h),
          child: Text(
            address,
            style: AppStyles.style14(context)
                .copyWith(color: AppColor.greyColorWithOpacity),
          ),
        ),
      ],
    );
  }
}

class AmenitiesListView extends StatelessWidget {
  const AmenitiesListView({
    super.key,
    required this.amenityList,
  });
  final List<Amenity> amenityList;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DetailsTitle(title: S.of(context).amenities),
        ListView.builder(
          padding: EdgeInsets.zero,
          itemCount: amenityList
              .length, //placeDetailsCubit.placeDetails?.amenities?.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            // Amenity? amenitie =
            //     placeDetailsCubit.placeDetails!.amenities?[index];

            return AmenitiesItem(
              imageUrl: amenityList[index].icon, //amenitie?.icon,
              title: amenityList[index].title,
            );
          },
        ),
      ],
    );
  }
}

class PictureAndTitleSection extends StatelessWidget {
  const PictureAndTitleSection({
    super.key,
    required this.postImageList,
    required this.postTitle,
    required this.secondTitle,
    this.tag,
    this.rating,
  });
  final List<String> postImageList;
  final String postTitle;
  final String secondTitle;
  final String? tag;
  final String? rating;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
      decoration: BoxDecoration(
        boxShadow: [
          // BoxShadow(
          //   color: AppColor.shadow1Color,
          //   blurRadius: 4,
          // ),
        ],
        // borderRadius: const BorderRadius.all(Radius.circular(5)),
        // color: AppColor.whiteColor,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomScrollPhotoWidget(
            pageController: PageController(),
            placeImage: postImageList,
          ),
          // Test(),
          SizedBox(
            height: 16.h,
          ),
          Text(
            postTitle,
            style: AppStyles.style22WhiteSemiBold(context)
                .copyWith(color: AppColor.darkBlueColor),
          ),
          SizedBox(
            height: 16.h,
          ),
          Text(
            secondTitle,
            style: AppStyles.style16w500(context),
          ),
          SizedBox(
            height: 16.h,
          ),
          if (tag != null)
            Row(
              children: [
                DetailsCard(
                  containerColor: AppColor.blueColorOpacity,
                  //! Tag here (Girls Only,family Only, ... )
                  child: Center(
                    child: Text(
                      tag!,
                      style: AppStyles.style12(context),
                    ),
                  ),
                ),
              ],
            ),
          if (rating != null)
            Row(
              children: [
                DetailsCard(
                  containerColor: AppColor.orangeColorOpacity,
                  //! Tag here (Girls Only,family Only, ... )
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SvgPicture.asset(AppIcons.star),
                      SizedBox(
                        width: 3.w,
                      ),
                      Text(
                        rating!.substring(0, 3),
                        style: AppStyles.style14(context)
                            .copyWith(color: AppColor.secondPrimaryColor),
                      )
                    ],
                  ),
                ),
              ],
            ),
          SizedBox(
            height: 10.h,
          ),
        ],
      ),
    );
  }
}
