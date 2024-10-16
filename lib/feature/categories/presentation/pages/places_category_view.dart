import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sahab_project/core/const.dart';
import 'package:sahab_project/core/utils/functions/function.dart';
import 'package:sahab_project/core/utils/icons/app_icons.dart';
import 'package:sahab_project/core/utils/widgets/circular_progress_indicator.dart';
import 'package:sahab_project/core/utils/widgets/custom_filter_widget.dart';
import 'package:sahab_project/core/utils/widgets/custom_no_internet_and_error_view.dart';
import 'package:sahab_project/core/utils/widgets/custom_simple_app_bar_widget.dart';
import 'package:sahab_project/core/utils/widgets/no_result.dart';
import 'package:sahab_project/feature/categories/presentation/manager/cubit/category_cubit.dart';
import 'package:sahab_project/feature/home/presentation/manager/area_cubit/area_cubit.dart';
import 'package:sahab_project/feature/places/data/model/place_model.dart';
import 'package:sahab_project/feature/places/presentation/manager/place_cubit/place_cubit.dart';
import 'package:sahab_project/feature/places/presentation/pages/flitter_page.dart';

import '../../../../generated/l10n.dart';
import '../../../home/presentation/widgets/places_card.dart';

class PlacesCategoryView extends StatefulWidget {
  const PlacesCategoryView({super.key, required this.id, required this.title});
  final int id;
  final String title;
  @override
  State<PlacesCategoryView> createState() => _PlacesCategoryViewState();
}

class _PlacesCategoryViewState extends State<PlacesCategoryView> {
  late final ScrollController _scrollController;
  // late final ScrollController _listScrollController;
  var nextPage = 2;
  List<PlaceModel> places = [];
  var isLoading = false;
  String? query;
  // todo : finish translate
  @override
  void initState() {
    super.initState();
    BlocProvider.of<CategoryCubit>(context)
        .fetchPlaceForOneCategory(categoryId: widget.id, query: query);
    _scrollController = ScrollController();
    // _listScrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
    if (kDebugMode) {
      print(nextPage);
      print(places.length);
    }
  }

  void _scrollListener() async {
    var currentPositions = _scrollController.position.pixels;
    var maxScrollLength = _scrollController.position.maxScrollExtent;
    // print('Current position: $currentPositions');
    // print('Max scroll length: $maxScrollLength');
    // print(currentPositions);
    if (currentPositions >= 0.5 * maxScrollLength) {
      debugPrint('');
      if (!isLoading) {
        isLoading = true;
        await BlocProvider.of<CategoryCubit>(context).fetchPlaceForOneCategory(
            pageNumber: nextPage++, categoryId: widget.id, query: query);

        isLoading = false;
        debugPrint('nextPage: ${nextPage}');
      }
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    CategoryCubit categoryCubit = CategoryCubit.get(context);
    return Scaffold(
        body: WillPopScope(
      onWillPop: () async {
        categoryCubit.total = 0;
        categoryCubit.query = null;
        return true;
      },
      child: CustomScrollView(
        // controller: _listScrollController,
        slivers: [
          SliverToBoxAdapter(
            child: CustomSimpleAppBarWidget(
              onIconTap: () {
                Navigator.of(context).pop();
                categoryCubit.total = 0;
                categoryCubit.query = null;
              },
              iconPath: AppIcons.backArrow,
              appBarTitle: widget.title,
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 30.h,
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding:
                  EdgeInsetsDirectional.only(start: 20.w, end: 16.w, bottom: 0),
              child: BlocBuilder<CategoryCubit, CategoryState>(
                builder: (context, state) {
                  if (categoryCubit.query == null && places.isEmpty) {
                    return SizedBox();
                  } else {
                    return CustomFilterWidget(
                      isFilter: categoryCubit.query != null,
                      title: "${categoryCubit.total} ${widget.title}",
                      isVisibleAll: true,
                      onTap: () {
                        // BlocProvider.of<PlaceCubit>(context).groupValueSort = -1;
                        // BlocProvider.of<PlaceCubit>(context).groupValueType = -1;
                        Navigator.of(context)
                            .push(
                          MaterialPageRoute(
                            builder: (context) => FlitterPage(
                              categoryTitle: widget.title,
                              endValue: BlocProvider.of<CategoryCubit>(context)
                                  .maxPrice
                                  .toDouble(),
                            ),
                          ),
                        )
                            .then(
                          (value) {
                            // if (value != null) {
                            places = [];
                            nextPage = 2;
                            categoryCubit.query = value;
                            query = value;
                            print(query);

                            categoryCubit.fetchPlaceForOneCategory(
                                categoryId: widget.id, query: query);
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
          BlocConsumer<CategoryCubit, CategoryState>(
            listener: (context, state) {
              if (state is PlaceCategoryLoadMore) {
                places.addAll(categoryCubit.fetchPlaceList);
              }
            },
            builder: (context, state) {
              if (state is PlaceCategoryLoadSuccess ||
                  state is PlaceCategoryLoadMore) {
                if (places.isEmpty) {
                  return SliverFillRemaining(
                    child: Center(
                        child: NoResult(
                      title: S.of(context).no_result,
                    )),
                  );
                } else {
                  print("lllllllllllllllllllllll ${places.length}");
                  return SliverFillRemaining(
                    child: Column(
                      children: [
                        // ! List for view all places For one category .
                        Expanded(
                          child: ListView.builder(
                            controller: _scrollController,
                            scrollDirection: Axis.vertical,
                            itemCount: state is PlaceCategoryLoadMore
                                ? places.length + 1
                                : places.length,
                            itemBuilder: (context, index) {
                              if (index < places.length) {
                                debugPrint('index ll : ${index}');
                                return Padding(
                                  padding: EdgeInsetsDirectional.only(
                                    start: 16.w,
                                    bottom: 20.h,
                                  ),
                                  child: SizedBox(
                                    height: 420.h,
                                    //! this place Card is ClickAble ..
                                    child: PlacesCard(
                                      title: places[index].title ?? "",
                                      imagePath: places[index].image ??
                                          "", //Constant.kPlaceImage,
                                      dicVisibly: true,
                                      rate: places[index].rate ?? "0",
                                      locationName: places[index].address ??
                                          S.of(context).unknown_location,
                                      price: places[index].weekdayPrice ?? 0,
                                      tag: AppFunction.typeTranslate(
                                          places[index].tag ?? "Unknown Tag",
                                          context),
                                      placeId: places[index].id ?? -1,
                                    ),
                                  ),
                                );
                              } else {
                                debugPrint('index loding : ${index}');
                                return const Center(
                                    child: CustomCircularProgressIndicator());
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  );
                }
              } else if (state is PlaceCategoryPaginationFailure) {
                // if (state.statusCode == 606) {
                return SliverFillRemaining(
                  child: CustomNoInternetAndErrorView(
                    onTryAgainButton: () {
                      BlocProvider.of<CategoryCubit>(context)
                          .fetchPlaceForOneCategory(
                              categoryId: widget.id, query: query);
                    },
                  ),
                );
                // } else {
                //   return SliverFillRemaining(
                //     child: CustomNoInternetAndErrorView(
                //       errorMessage: state.errorMessage,
                //       onTryAgainButton: () {
                //         BlocProvider.of<CategoryCubit>(context)
                //             .fetchPlaceForOneCategory(
                //                 categoryId: widget.id, query: query);
                //       },
                //     ),
                //   );
                // }
              }
              if (state is PlaceCategoryLoading) {
                return const SliverFillRemaining(
                    child: Center(child: CustomCircularProgressIndicator()));
              } else {
                return const SliverFillRemaining(child: SizedBox());
              }
            },
          ),
        ],
      ),
    ));
  }
}
