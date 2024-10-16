import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sahab_project/core/utils/icons/app_icons.dart';
import 'package:sahab_project/core/utils/widgets/custom_simple_app_bar_widget.dart';
import 'package:sahab_project/feature/categories/presentation/manager/cubit/category_cubit.dart';
import 'package:sahab_project/feature/home/presentation/manager/filter_cubit/filter_cubit.dart';
import 'package:sahab_project/feature/places/presentation/manager/place_cubit/place_cubit.dart';
import 'package:sahab_project/feature/places/presentation/widgets/area_card.dart';
import 'package:sahab_project/feature/places/presentation/widgets/custom_slider.dart';
import 'package:sahab_project/feature/places/presentation/widgets/filter_item.dart';
import 'package:sahab_project/feature/places/presentation/widgets/filter_title.dart';

import '../../../../generated/l10n.dart';

class FlitterPage extends StatelessWidget {
  const FlitterPage({
    super.key,
    this.categoryTitle,
    this.endValue,
    this.isSearch = false,
  });
  // todo : finish
  final String? categoryTitle;
  final double? endValue;
  final bool isSearch;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FilterCubit(),
      child: WillPopScope(
        onWillPop: () async {
          // print(filterCubit.filterCloseTrigger(context));
          Navigator.of(context).pop(BlocProvider.of<FilterCubit>(context)
              .filterCloseTrigger(context));
          return false;
        },
        child: Scaffold(
          body: FilterHomePage(
              categoryTitle: categoryTitle,
              endValue: endValue,
              isSearch: isSearch),
        ),
      ),
    );
  }
}

class FilterHomePage extends StatelessWidget {
  const FilterHomePage({
    super.key,
    required this.categoryTitle,
    required this.endValue,
    required this.isSearch,
  });

  final String? categoryTitle;
  final double? endValue;
  final bool isSearch;

  @override
  Widget build(BuildContext context) {
    FilterCubit filterCubit = FilterCubit.get(context);

    return ListView(
      padding: const EdgeInsets.all(0),
      children: [
        CustomSimpleAppBarWidget(
          onIconTap: () {
            print("tab");

            // print(
            //     "query before return: ${filterCubit.filterCloseTrigger(context)}");

            String? query = filterCubit.filterCloseTrigger(context);
            print("query before $query");
            Navigator.of(context).pop(query);
          },
          iconPath: AppIcons.close,
          appBarTitle: S.of(context).filter_by,
        ),
        SizedBox(
          height: 30.h,
        ),
        FilterTitle(title: S.of(context).sort_by),
        BlocBuilder<FilterCubit, FilterState>(
          builder: (context, state) {
            return Column(
              children: [
                FilterListItem(
                  title: S.of(context).newest,
                  value: 0,
                  groupValue: filterCubit.groupValueSort,
                  onChanged: (value) {
                    filterCubit.changeRadioValueSort(value ?? -1);
                  },
                ),
                FilterListItem(
                  title: S.of(context).highest_rating,
                  value: 1,
                  groupValue: filterCubit.groupValueSort,
                  onChanged: (value) {
                    filterCubit.changeRadioValueSort(value ?? -1);
                  },
                ),
                FilterListItem(
                  title: S.of(context).high_to_low,
                  value: 2,
                  groupValue: filterCubit.groupValueSort,
                  onChanged: (value) {
                    filterCubit.changeRadioValueSort(value ?? -1);
                  },
                ),
                FilterListItem(
                  title: S.of(context).low_to_high,
                  value: 3,
                  groupValue: filterCubit.groupValueSort,
                  onChanged: (value) {
                    filterCubit.changeRadioValueSort(value ?? -1);
                  },
                ),
              ],
            );
          },
        ),
        if (isSearch)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 30.h,
              ),
              FilterTitle(title: S.of(context).category),
              BlocBuilder<FilterCubit, FilterState>(
                builder: (context, state) {
                  return Column(
                    children: [
                      FilterListItem(
                        title: S.of(context).all, //S.of(context).newest,
                        value: -1,
                        groupValue: filterCubit.groupValueCategory,
                        onChanged: (value) {
                          filterCubit.changeRadioValueCategory(
                              value ?? -1, null);
                        },
                      ),
                      ListView.builder(
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: BlocProvider.of<CategoryCubit>(context)
                            .fetchCategoryList
                            .length, //2,
                        itemBuilder: (context, index) => FilterListItem(
                          title: BlocProvider.of<CategoryCubit>(context)
                                  .fetchCategoryList[index]
                                  .title ??
                              "", //S.of(context).newest,
                          value: index,
                          groupValue: filterCubit.groupValueCategory,
                          onChanged: (value) {
                            filterCubit.changeRadioValueCategory(
                                value ?? -1,
                                BlocProvider.of<CategoryCubit>(context)
                                        .fetchCategoryList[index]
                                        .id ??
                                    -1);
                          },
                        ),
                      ),
                    ],
                  );
                },
              ),
            ],
          ),

        SizedBox(
          height: 25.h,
        ),
        FilterTitle(title: S.of(context).area),
        const AreaCard(),
        //? --------------------------------
        //! here may be we should put title
        FilterTitle(
          title: categoryTitle == null
              ? S.of(context).place_type
              : "$categoryTitle ${S.of(context).type}",
        ),
        //? --------------------------------
        SizedBox(
          height: 10.h,
        ),
        // ListView.builder(
        //   itemCount: 4,
        //   shrinkWrap: true,
        //   physics: const NeverScrollableScrollPhysics(),
        //   itemBuilder: (context, index) {
        //     return FilterListItem(
        //       title: "Girls only",
        //       value: 0,
        //       groupValue: 1,
        //       onChanged: (value) {},
        //     );
        //   },
        // ),
        // const FilterTitle(
        //   title: "All",
        // ),
        BlocBuilder<FilterCubit, FilterState>(
          builder: (context, state) {
            return Column(
              children: [
                FilterListItem(
                  title: S.of(context).all,
                  value: 0,
                  groupValue: filterCubit.groupValueType,
                  onChanged: (value) {
                    filterCubit.changeRadioValueType(value ?? -1);
                  },
                ),
                FilterListItem(
                  title: S.of(context).girls_only,
                  value: 1,
                  groupValue: filterCubit.groupValueType,
                  onChanged: (value) {
                    filterCubit.changeRadioValueType(value ?? -1);
                  },
                ),
                FilterListItem(
                  title: S.of(context).family_only,
                  value: 2,
                  groupValue: filterCubit.groupValueType,
                  onChanged: (value) {
                    filterCubit.changeRadioValueType(value ?? -1);
                  },
                ),
              ],
            );
          },
        ),

        SizedBox(
          height: 10.h,
        ),
        FilterTitle(
          title: S.of(context).price,
        ),
        CustomSlider(
          division: endValue!.toInt(),
          max: endValue!,
          min: 0,
          onChange: (values) {
            print(values.start);
            print(values.end);
            filterCubit.minPrice = values.start.round();
            filterCubit.maxPrice = values.end.round();
          },
          rangeValues: RangeValues(0, endValue!),

          // onChange: (startValue, endValue) {
          //   print(startValue);
          // },
          // endValue: 1000, //endValue ?? 0,
          // values: RangeValues(0, 1000),
        ),
        SizedBox(
          height: 40.h,
        )
      ],
    );
  }
}
