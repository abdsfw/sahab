import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sahab_project/core/const.dart';
import 'package:sahab_project/core/utils/icons/app_icons.dart';
import 'package:sahab_project/core/utils/widgets/circular_progress_indicator.dart';
import 'package:sahab_project/core/utils/widgets/custom_filter_widget.dart';
import 'package:sahab_project/core/utils/widgets/custom_no_internet_and_error_view.dart';
import 'package:sahab_project/core/utils/widgets/custom_simple_app_bar_widget.dart';
import 'package:sahab_project/core/utils/widgets/no_result.dart';
import 'package:sahab_project/feature/home/presentation/widgets/places_card.dart';
import 'package:sahab_project/feature/places/data/model/featured_place/feature_place_model/feature_place_model.dart';
import 'package:sahab_project/feature/places/data/model/featured_place/featured_place.dart';
import 'package:sahab_project/feature/places/presentation/manager/place_cubit/place_cubit.dart';
import 'package:sahab_project/feature/places/presentation/pages/flitter_page.dart';
import 'package:sahab_project/generated/l10n.dart';

class PlacesView extends StatelessWidget {
  const PlacesView({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        PlaceCubit placeCubit = PlaceCubit.get(context);

        placeCubit.query = null;

        return true;
      },
      child: const Scaffold(
        body: SafeArea(
          child: PlacesViewBody(),
        ),
      ),
    );
  }
}

class PlacesViewBody extends StatelessWidget {
  const PlacesViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    PlaceCubit placeCubit = PlaceCubit.get(context);
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: CustomSimpleAppBarWidget(
            onIconTap: () {
              placeCubit.query = null;

              Navigator.of(context).pop();
            },
            iconPath: AppIcons.backArrow,
            appBarTitle: S.of(context).featured_locations,
          ),
        ),
        SliverToBoxAdapter(
          child: SizedBox(
            height: 28.h,
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.only(left: 20.w, right: 16.w, bottom: 15.h),
            //! here we may be put dynamic title
            child: BlocBuilder<PlaceCubit, PlaceState>(
              builder: (context, state) {
                if (placeCubit.query == null &&
                    placeCubit.fetchedPlaced.isEmpty) {
                  return SizedBox();
                } else {
                  return CustomFilterWidget(
                    isFilter: placeCubit.query != null,
                    title: state is PlaceLoading
                        ? ""
                        : placeCubit.fetchedPlaced.length.toString(),
                    isVisibleAll: true,
                    onTap: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(
                        builder: (context) => FlitterPage(
                          categoryTitle: S.of(context).featured_locations,
                          endValue: placeCubit.maxPrice.toDouble(),
                          // endValue: ,
                        ),
                      ))
                          .then(
                        (value) {
                          // if (value != null) {
                          placeCubit.query = value;
                          print("query after return: $value");
                          placeCubit.fetchAllFuturePlaces(
                            context,
                            query: placeCubit.query,
                          );
                          // }
                        },
                      );
                    },
                  );
                }
              },
            ),
          ),
        ),
        BlocBuilder<PlaceCubit, PlaceState>(
          builder: (context, state) {
            if (state is PlaceLoading) {
              return const SliverFillRemaining(
                  child: Center(child: CustomCircularProgressIndicator()));
            } else if (state is PlaceLoadSuccess) {
              if (placeCubit.fetchedPlaced.isEmpty) {
                return SliverFillRemaining(
                  child: Center(
                      child: NoResult(
                    title: S.of(context).no_results_found,
                  )),
                );
              } else {
                return SliverFillRemaining(
                  child: ListView.builder(
                    itemCount: placeCubit.fetchedPlaced.length,
                    itemBuilder: (context, index) {
                      FeaturePlaceModel placeItem =
                          placeCubit.fetchedPlaced[index];
                      return Padding(
                        padding: EdgeInsets.only(left: 16.w, bottom: 20.h),
                        child: PlacesCard(
                          imagePath: Constant.kPlaceImage,
                          placeId: placeItem.id,
                          dicVisibly: true,
                          title: placeItem.title ?? "",
                          rate: placeItem.rating.toString(),
                          locationName: placeItem.address ?? "",
                          price: placeItem.weekdayPrice ?? 0,
                          tag: placeItem.tag ?? "",
                        ),
                      );
                    },
                  ),
                );
              }
            } else if (state is PlaceLoadFailure) {
              // if (state.statusCode == 606) {
              return SliverFillRemaining(
                child: CustomNoInternetAndErrorView(
                  onTryAgainButton: () {
                    placeCubit.fetchAllFuturePlaces(
                      context,
                      query: placeCubit.query,
                    );
                  },
                ),
              );
              // } else {
              //   return SliverFillRemaining(
              //     child: CustomNoInternetAndErrorView(
              //       errorMessage: state.errorMessage,
              //       onTryAgainButton: () {
              //         placeCubit.fetchAllFuturePlaces(
              //           context,
              //           query: placeCubit.query,
              //         );
              //       },
              //     ),
              //   );
              // }
            } else {
              return const SliverFillRemaining(child: SizedBox());
            }
          },
        )
      ],
    );
  }
}
