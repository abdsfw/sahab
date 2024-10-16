import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahab_project/core/theme/app_color.dart';
import 'package:sahab_project/feature/places/presentation/manager/slider_cubit/slider_cubit.dart';
import 'package:sahab_project/feature/places/presentation/widgets/custom_range_shape.dart';

class CustomSlider extends StatelessWidget {
  CustomSlider({
    super.key,
    required this.max,
    required this.min,
    required this.rangeValues,
    required this.division,
    required this.onChange,
  });
  // RangeValues _values = RangeValues(0, widget.endValue);
  final double max;
  final double min;
  final int division;
  final RangeValues rangeValues;
  final void Function(RangeValues values) onChange;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SliderCubit()
        ..setImportantAttribute(
          max: max,
          min: min,
          rangeValues: rangeValues,
          division: division,
        ),
      child: BlocBuilder<SliderCubit, SliderState>(
        builder: (context, state) {
          return SubCustomSlider(
            onChange: onChange,
          );
        },
      ),
    );
  }
}

class SubCustomSlider extends StatelessWidget {
  const SubCustomSlider({
    super.key,
    required this.onChange,
  });
  final void Function(RangeValues values) onChange;

  @override
  Widget build(BuildContext context) {
    SliderCubit cubit = SliderCubit.get(context);
    return SliderTheme(
      data: SliderThemeData(
        rangeThumbShape: CustomRangeThumbShape(),
      ),
      child: RangeSlider(
        labels: RangeLabels(
          "${cubit.rangeValue.start.round()}",
          "${cubit.rangeValue.end.round()}",
        ),
        values: cubit.rangeValue, //RangeValues(0, 1),
        min: cubit.min, //minRange, // 0, // Set min value here
        max: cubit.max, // Set max value here

        activeColor: AppColor.secondPrimaryColor,
        inactiveColor: Colors.grey.withOpacity(0.4),
        divisions: cubit.division == 0
            ? 1
            : cubit
                .division, // 1000, //widget.endValue.toInt(), //widget.values!.end.toInt(),
        onChanged: (RangeValues values) {
          cubit.changeRange(values);
          onChange(values);
        },
      ),
    );
  }
}
