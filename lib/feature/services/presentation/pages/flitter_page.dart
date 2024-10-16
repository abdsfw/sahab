import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sahab_project/core/utils/widgets/app_bar.dart';
import 'package:sahab_project/core/utils/widgets/custom_simple_app_bar_widget.dart';
import 'package:sahab_project/feature/home/presentation/manager/filter_cubit/filter_cubit.dart';
import 'package:sahab_project/feature/places/presentation/widgets/custom_slider.dart';
import 'package:sahab_project/feature/places/presentation/widgets/filter_item.dart';
import 'package:sahab_project/feature/places/presentation/widgets/filter_title.dart';
import 'package:sahab_project/feature/services/presentation/manager/service_cubit/service_cubit.dart';

import '../../../../generated/l10n.dart';

class FlitterServicePage extends StatelessWidget {
  const FlitterServicePage({
    super.key,
    this.endValue,
    this.isSearch = false,
  });
// todo : finish translate
  final double? endValue;
  final bool isSearch;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FilterCubit(),
      child: WillPopScope(
        onWillPop: () async {
          FilterCubit filterCubit = FilterCubit.get(context);

          Navigator.of(context).pop(filterCubit.filterCloseTrigger(context));

          return false;
        },
        child: Scaffold(
          body: FilterServiceHomePage(
            endValue: endValue,
            isSearch: isSearch,
          ),
        ),
      ),
    );
  }
}

class FilterServiceHomePage extends StatelessWidget {
  const FilterServiceHomePage({
    super.key,
    this.endValue,
    required this.isSearch,
  });
  final double? endValue;
  final bool isSearch;
  @override
  Widget build(BuildContext context) {
    FilterCubit filterCubit = FilterCubit.get(context);

    return ListView(
      children: [
        CustomSimpleAppBarWidget(
          appBarTitle: S.of(context).filter_by,
          onIconTap: () {
            // print("before return: ${filterCubit.filterCloseTrigger(context)}");
            Navigator.of(context).pop(filterCubit.filterCloseTrigger(context));
          },
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
              FilterTitle(title: S.of(context).services),
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
                        itemCount: BlocProvider.of<ServiceCubit>(context)
                            .fetchServiceList
                            .length, //2,
                        itemBuilder: (context, index) => FilterListItem(
                          title: BlocProvider.of<ServiceCubit>(context)
                                  .fetchServiceList[index]
                                  .title ??
                              "", //S.of(context).newest,
                          value: index,
                          groupValue: filterCubit.groupValueCategory,
                          onChanged: (value) {
                            filterCubit.changeRadioValueCategory(
                                value ?? -1,
                                BlocProvider.of<ServiceCubit>(context)
                                        .fetchServiceList[index]
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
          height: 30.h,
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
      ],
    );
  }
}
