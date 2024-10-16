import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sahab_project/core/theme/app_color.dart';
import 'package:sahab_project/core/theme/app_textsyle.dart';
import 'package:sahab_project/core/utils/icons/app_icons.dart';
import 'package:sahab_project/core/utils/widgets/app_bar.dart';
import 'package:sahab_project/core/utils/widgets/app_button.dart';
import 'package:sahab_project/core/utils/widgets/circular_progress_indicator.dart';
import 'package:sahab_project/core/utils/widgets/custom_no_internet_and_error_view.dart';
import 'package:sahab_project/core/utils/widgets/custom_simple_app_bar_widget.dart';
import 'package:sahab_project/feature/Bookings/presentation/views/widgets/test.dart';
import 'package:sahab_project/feature/home/presentation/widgets/shimmer_places_card.dart';
import 'package:sahab_project/feature/places/data/model/place_details_model/amenity.dart';
import 'package:sahab_project/feature/places/presentation/manager/place_details_cubit/place_details_cubit.dart';
import 'package:sahab_project/feature/places/presentation/pages/book_now.dart';
import 'package:sahab_project/feature/places/presentation/pages/place_details_for_booking.dart';
import 'package:sahab_project/feature/places/presentation/widgets/amenities_item_shimmer.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../../../../core/utils/widgets/details_title.dart';
import '../../../../generated/l10n.dart';
import '../../data/model/place_details_model.dart';
import '../widgets/amenities_item.dart';
import '../widgets/description_widget.dart';

class PlaceDetails extends StatelessWidget {
  const PlaceDetails({super.key, required this.placeId});
  final int placeId;
  // todo : finish translate
  @override
  Widget build(BuildContext context) {
    PlaceDetailsCubit placeDetailsCubit = PlaceDetailsCubit.get(context);

    return Scaffold(
      body: BlocBuilder<PlaceDetailsCubit, PlaceDetailsState>(
        builder: (context, state) {
          if (state is PlaceDetailsLoading) {
            return Center(
              child: CustomCircularProgressIndicator(),
            );
          } else if (state is PlaceDetailsLoadFailure) {
            return CustomNoInternetAndErrorView(
              onTryAgainButton: () {
                placeDetailsCubit.fetchPlaceDetails(context,
                    placeId: placeId ?? -1);
              },
            );
          } else {
            return PlaceDetailsBody(placeDetailsCubit: placeDetailsCubit);
          }
        },
      ),
    );
  }
}

class PlaceDetailsBody extends StatelessWidget {
  const PlaceDetailsBody({
    super.key,
    required this.placeDetailsCubit,
  });

  final PlaceDetailsCubit placeDetailsCubit;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(0),
      children: [
        // ? ---------------------------------------
        // ! here we may be should put dynamic title
        // ? ---------------------------------------
        CustomSimpleAppBarWidget(
          appBarTitle:
              "${placeDetailsCubit.placeDetails?.title ?? ""} ${S.of(context).details}", //"Chalet Details",
          // onIconTap: () {
          //   Navigator.of(context).pop();
          // },
        ),
        SizedBox(
          height: 20.h,
        ),
        BlocConsumer<PlaceDetailsCubit, PlaceDetailsState>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state is PlaceDetailsLoading) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 14.w),
                child: const ShimmerPlacesCard(),
              );
            } else if (state is PlaceDetailsLoadFailure) {
              return Text(state.errorMessage);
            } else if (state is PlaceDetailsLoadSuccess) {
              return Padding(
                padding: EdgeInsetsDirectional.symmetric(horizontal: 0.w),
                child: PlacesDetailsForBooKing(
                  placeDetailsModel: state.placeDetails,
                  borderRadius: BorderRadius.zero,
                  color: Colors.transparent,
                  boxShadow: [],
                ),
              );
            } else {
              return Container();
            }
          },
        ),

        const Divider(),
        placeDetailsCubit.placeDetails!.amenities!.isNotEmpty
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DetailsTitle(title: S.of(context).amenities),
                  BlocBuilder<PlaceDetailsCubit, PlaceDetailsState>(
                    builder: (context, state) {
                      if (state is PlaceDetailsLoading) {
                        return ListView.builder(
                            itemCount: 4,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return const AmenitiesShimmerItem();
                            });
                      } else if (state is PlaceDetailsLoadSuccess) {
                        return ListView.builder(
                          itemCount: placeDetailsCubit
                                  .placeDetails?.amenities?.length ??
                              0,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            Amenity? amenitie = placeDetailsCubit
                                .placeDetails!.amenities?[index];

                            return AmenitiesItem(
                              imageUrl: amenitie?.icon,
                              title: amenitie?.title,
                            );
                          },
                        );
                      } else {
                        return const SizedBox();
                      }
                    },
                  ),
                  const Divider(),
                ],
              )
            : SizedBox(),
        //? this adders
        placeDetailsCubit.placeDetails?.address != null
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DetailsTitle(title: S.of(context).address),
                  Padding(
                    padding: EdgeInsetsDirectional.only(
                        start: 16.w, top: 3.h, bottom: 36.h),
                    child: Text(
                      placeDetailsCubit.placeDetails?.address ?? "",
                      style: AppStyles.style14(context)
                          .copyWith(color: AppColor.greyColorWithOpacity),
                    ),
                  ),
                  const Divider(),
                ],
              )
            : SizedBox(),
        //? --------------------------------------
        //! here we may be put dynamic title
        //? --------------------------------------
        placeDetailsCubit.placeDetails?.description != null
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DetailsTitle(
                      title:
                          "${S.of(context).about} ${placeDetailsCubit.placeDetails?.title ?? ""}"),
                  DescriptionWidget(
                    content: placeDetailsCubit.placeDetails?.description ?? "",
                  ),
                ],
              )
            : SizedBox(),

        // const Expanded(child: SizedBox()),
        Padding(
          padding: EdgeInsets.all(16),
          child: AppButton(
            onTap: () {
              if (placeDetailsCubit.placeDetails?.bookable == 1) {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return BookNow(
                      placeId: BlocProvider.of<PlaceDetailsCubit>(context)
                              .placeDetails
                              ?.id ??
                          -1,
                      weekDayPrice: BlocProvider.of<PlaceDetailsCubit>(context)
                              .placeDetails
                              ?.weekdayPrice ??
                          0,
                      weekEndPrice: BlocProvider.of<PlaceDetailsCubit>(context)
                              .placeDetails
                              ?.weekendPrice ??
                          0,
                      specialDays: BlocProvider.of<PlaceDetailsCubit>(context)
                              .placeDetails
                              ?.specialDays ??
                          [],
                    );
                  },
                ));
              } else if (placeDetailsCubit.placeDetails?.bookable == 0) {
                showTopSnackBar(
                  Overlay.of(context),
                  snackBarPosition: SnackBarPosition.bottom,
                  dismissType: DismissType.onTap,
                  CustomSnackBar.error(
                    message: S.of(context).un_bookable_message,
                  ),
                );
              }
            },
            text: S.of(context).book_now,
            color: AppColor.blueColor,
            radius: 5,
            fontSize: 16.sp,
            textColor: Colors.white,
            fontWeight: FontWeight.w600,
            fontFamily: AppStyles.getFontFamily(context),
            height: 50.h,
          ),
        ),
      ],
    );
  }
}
