import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sahab_project/core/const.dart';
import 'package:sahab_project/core/theme/app_color.dart';
import 'package:sahab_project/core/utils/icons/app_icons.dart';
import 'package:sahab_project/core/utils/widgets/circular_progress_indicator.dart';
import 'package:sahab_project/core/utils/widgets/custom_filter_widget.dart';
import 'package:sahab_project/core/utils/widgets/custom_no_internet_and_error_view.dart';
import 'package:sahab_project/core/utils/widgets/custom_simple_app_bar_widget.dart';
import 'package:sahab_project/core/utils/widgets/custom_two_button.dart';
import 'package:sahab_project/feature/home/presentation/widgets/places_card.dart';
import 'package:sahab_project/feature/home/presentation/widgets/search_field.dart';
import 'package:sahab_project/feature/places/presentation/pages/flitter_page.dart';
import 'package:sahab_project/feature/serach/data/model/serach_place_model.dart';
import 'package:sahab_project/feature/serach/presentation/manager/cubit/serach_cubit.dart';
import 'package:sahab_project/feature/serach/presentation/manager/cubit/tab_switch_cubit.dart';
import 'package:sahab_project/feature/services/data/model/service.dart';
import 'package:sahab_project/feature/services/presentation/pages/flitter_page.dart';
import 'package:sahab_project/feature/services/presentation/widgets/service_card_view.dart';
import '../../../../../generated/l10n.dart';
import '../../manager/cubit/services_search_cubit.dart';

class SearchView extends StatelessWidget {
  const SearchView({Key? key});

  @override
  Widget build(BuildContext context) {
    SearchCubit searchCubit = SearchCubit.get(context);
    TabSwitchCubit tabSwitchCubit = TabSwitchCubit.get(context);
    ServicesSearchCubit servicesSearchCubit = ServicesSearchCubit.get(context);
    return Scaffold(
      body: WillPopScope(
        onWillPop: () async {
          searchCubit.resetSearch();
          servicesSearchCubit.restServiceSearch();
          searchCubit.searchList.clear();
          servicesSearchCubit.servicesList.clear();
          return true;
        },
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: BlocBuilder<SearchCubit, SearchState>(
                builder: (context, searchState) {
                  return BlocBuilder<ServicesSearchCubit, ServicesSearchState>(
                    builder: (context, servicesState) {
                      String appBarTitle = S.of(context).search;

                      // Determine title based on search state
                      if (searchState is SearchSuccess) {
                        appBarTitle = S.of(context).search_results;
                      } else if (searchState is SearchFailure) {
                        appBarTitle = S.of(context).search_failed;
                      }

                      // Determine title based on services state
                      if (servicesState is ServicesSearchSuccess) {
                        appBarTitle = S.of(context).search_results;
                      } else if (servicesState is ServicesSearchFailure) {
                        appBarTitle = S.of(context).search_failed;
                      }

                      return CustomSimpleAppBarWidget(
                        onIconTap: () {
                          Navigator.of(context).pop();
                          searchCubit.resetSearch();
                          servicesSearchCubit.restServiceSearch();
                          searchCubit.searchList.clear();
                          servicesSearchCubit.servicesList.clear();
                        },
                        iconPath: AppIcons.backArrow,
                        appBarTitle: appBarTitle,
                      );
                    },
                  );
                },
              ),
            ),
            SliverPadding(
              padding: EdgeInsets.symmetric(vertical: 23.h, horizontal: 16.w),
              sliver: SliverToBoxAdapter(
                child: SearchField(
                  hintText: S.of(context).search_here,
                  controller:
                      searchCubit.searchController, // TextEditingController(),
                  onFieldSubmitted: (searchQuery) async {
                    searchCubit.fetchSearchPlaces(searchQuery);

                    servicesSearchCubit.fetchSearchServices(searchQuery);

                    if (kDebugMode) {
                      print(searchQuery);
                    }
                  },
                ),
              ),
            ),
            BlocBuilder<SearchCubit, SearchState>(
              builder: (context, state) {
                if (state is SearchSuccess) {
                  return BlocBuilder<TabSwitchCubit, TabSwitchState>(
                    builder: (context, state) {
                      return SliverPadding(
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        sliver: SliverToBoxAdapter(
                          child: CustomTwoButton(
                            buttonColor1: state is PlacesTab
                                ? AppColor.blueColor
                                : AppColor.stepColor,
                            buttonColor2: state is ServicesTab
                                ? AppColor.blueColor
                                : AppColor.stepColor,
                            text1: S.of(context).locations,
                            text2: S.of(context).services,
                            textColor1: AppColor.whiteColor,
                            textColor2: AppColor.whiteColor,
                            onTap1: () {
                              tabSwitchCubit.placesTab();
                            },
                            onTap2: () {
                              tabSwitchCubit.servicesTab();
                            },
                          ),
                        ),
                      );
                    },
                  );
                } else {
                  return const SliverToBoxAdapter(child: SizedBox());
                }
              },
            ),
            BlocConsumer<TabSwitchCubit, TabSwitchState>(
              listener: (context, state) {},
              builder: (context, state) {
                if (state is ServicesTab) {
                  return BlocConsumer<ServicesSearchCubit, ServicesSearchState>(
                    listener: (context, state) {},
                    builder: (context, state) {
                      if (state is ServicesSearchSuccess) {
                        return SliverPadding(
                          padding: EdgeInsetsDirectional.only(
                              start: 18.w, end: 18.w, top: 20.h, bottom: 15.h),
                          sliver: SliverToBoxAdapter(
                            child: Visibility(
                              visible: true,
                              // servicesSearchCubit.resultServicesNumber() !=
                              //     0,
                              child: CustomFilterWidget(
                                isFilter: false,
                                title:
                                    "${servicesSearchCubit.resultServicesNumber()} ${S.of(context).results_found}",
                                isVisibleAll: true,
                                onTap: () {
                                  Navigator.of(context)
                                      .push(
                                    MaterialPageRoute(
                                      builder: (context) => FlitterServicePage(
                                        endValue: servicesSearchCubit.totalPrice
                                            .toDouble(),
                                        isSearch: true,
                                      ),
                                    ),
                                  )
                                      .then((value) {
                                    servicesSearchCubit.fetchSearchServices(
                                      searchCubit.searchController.text,
                                      query: value,
                                    );
                                    print("value of query $value");
                                  });
                                },
                              ),
                            ),
                          ),
                        );
                      } else {
                        return const SliverToBoxAdapter(
                          child: SizedBox(),
                        );
                      }
                    },
                  );
                }
                //? this place
                else if (state is PlacesTab) {
                  return BlocConsumer<SearchCubit, SearchState>(
                    listener: (context, state) {},
                    builder: (context, state) {
                      if (state is SearchSuccess) {
                        return SliverPadding(
                          padding: EdgeInsetsDirectional.only(
                              start: 18.w, end: 18.w, top: 20.h, bottom: 15.h),
                          sliver: SliverToBoxAdapter(
                            child: Visibility(
                              visible: true, //searchCubit.resultNumber != 0,
                              child: CustomFilterWidget(
                                isFilter: false,
                                title:
                                    "${searchCubit.resultNumber} ${S.of(context).results_found}",
                                isVisibleAll: true,
                                onTap: () {
                                  Navigator.of(context)
                                      .push(
                                    MaterialPageRoute(
                                      builder: (context) => FlitterPage(
                                        endValue:
                                            searchCubit.maxPrice.toDouble(),
                                        isSearch: true,
                                        // categoryTitle: searchCubit.,
                                      ),
                                    ),
                                  )
                                      .then((value) {
                                    print("value of query $value");
                                    searchCubit.fetchSearchPlaces(
                                        searchCubit.searchController.text,
                                        query: value);
                                  });
                                },
                              ),
                            ),
                          ),
                        );
                      } else {
                        return const SliverToBoxAdapter(
                          child: SizedBox(),
                        );
                      }
                    },
                  );
                } else {
                  return const SliverToBoxAdapter(
                    child: SizedBox(),
                  );
                }
              },
            ),
            BlocBuilder<TabSwitchCubit, TabSwitchState>(
              builder: (context, state) {
                //! this place tab and his BlocConsumer
                if (state is PlacesTab) {
                  return BlocConsumer<SearchCubit, SearchState>(
                    listener: (context, state) {},
                    builder: (context, state) {
                      if (state is SearchLoading) {
                        return const SliverFillRemaining(
                          child:
                              Center(child: CustomCircularProgressIndicator()),
                        );
                      } else if (state is SearchFailure) {
                        return SliverFillRemaining(
                          child: CustomNoInternetAndErrorView(
                            onTryAgainButton: () {
                              searchCubit.fetchSearchPlaces(
                                  searchCubit.searchController.text);
                            },
                          ),
                        );
                      } else {
                        return SliverList.builder(
                          itemCount: searchCubit.searchList.length,
                          itemBuilder: (context, index) {
                            SearchPlaceModel place =
                                searchCubit.searchList[index];
                            return Padding(
                              padding: EdgeInsetsDirectional.only(
                                  start: 16.w, bottom: 30.h),
                              child: PlacesCard(
                                  placeId: place.id,
                                  imagePath: Constant.kPartyImage,
                                  title: place.title,
                                  dicVisibly: true,
                                  rate: place.rating.toString(),
                                  locationName: place.address,
                                  price: place.weekdayPrice,
                                  tag: place.tag),
                            );
                          },
                        );
                      }
                    },
                  );
                } else if (state is ServicesTab) {
                  return BlocConsumer<ServicesSearchCubit, ServicesSearchState>(
                    listener: (context, state) {},
                    builder: (context, state) {
                      if (state is ServicesSearchLoading) {
                        return const SliverFillRemaining(
                          child:
                              Center(child: CustomCircularProgressIndicator()),
                        );
                      } else if (state is ServicesSearchFailure) {
                        return SliverFillRemaining(
                          child: CustomNoInternetAndErrorView(
                            onTryAgainButton: () {
                              servicesSearchCubit.fetchSearchServices(
                                  searchCubit.searchController.text);
                            },
                          ),
                        );
                      } else {
                        return SliverList.builder(
                          itemCount: servicesSearchCubit.servicesList.length,
                          itemBuilder: (context, index) {
                            Services service =
                                servicesSearchCubit.servicesList[index];
                            print(service.price);
                            return Padding(
                              padding: EdgeInsets.only(
                                  left: 16.w, right: 16.w, bottom: 30.h),
                              child: ServiceCardView(service: service),
                            );
                          },
                        );
                      }
                    },
                  );
                } else {
                  return const SliverToBoxAdapter();
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
