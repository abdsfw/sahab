import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sahab_project/core/theme/app_color.dart';
import 'package:sahab_project/feature/account/presentation/manager/static_value_cubit/static_value_cubit.dart';
import 'package:sahab_project/feature/account/presentation/view/widgets/information_widget.dart';

import '../../../../../generated/l10n.dart';

class GridViewInformationWidget extends StatelessWidget {
  const GridViewInformationWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    StaticValueCubit staticValueCubit = StaticValueCubit.get(context);
    return GridView.count(
      crossAxisCount: 2,
      mainAxisSpacing: 16.h,
      crossAxisSpacing: 19.w,
      childAspectRatio: 171.w / 120.h,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        InformationWidget(
          color: AppColor.blueColor,
          fText: staticValueCubit.staticValue.upcoming == null
              ? ""
              : staticValueCubit.staticValue.upcoming.toString(),
          sText: S.of(context).upcoming_reservations, //'upcoming reservations',
        ),
        InformationWidget(
          color: AppColor.secondPrimaryColor,
          fText: staticValueCubit.staticValue.count == null
              ? ""
              : staticValueCubit.staticValue.count.toString(),
          sText: S.of(context).total_reservations, //'Total reservations',
        ),
        InformationWidget(
          color: AppColor.lightGreenColor,
          fText: staticValueCubit.staticValue.day == null
              ? ""
              : staticValueCubit.staticValue.day.toString(),
          sText: S.of(context).daily_sales, //'Daily Sales(KD)',
        ),
        InformationWidget(
          color: AppColor.purpleColor,
          fText: staticValueCubit.staticValue.month == null
              ? ""
              : staticValueCubit.staticValue.month.toString(),
          sText: S.of(context).monthly_sales, //'Monthly Sales',
        ),
      ],
    );
  }
}

class ShimmerGridViewInformationWidget extends StatelessWidget {
  const ShimmerGridViewInformationWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      mainAxisSpacing: 16.h,
      crossAxisSpacing: 19.w,
      childAspectRatio: 171.w / 120.h,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        ShimmerInformationWidget(),
        ShimmerInformationWidget(),
        ShimmerInformationWidget(),
        ShimmerInformationWidget()
      ],
    );
  }
}
