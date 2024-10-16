import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sahab_project/core/theme/app_color.dart';
import 'package:sahab_project/core/theme/app_textsyle.dart';
import 'package:sahab_project/core/utils/icons/app_icons.dart';
import 'package:sahab_project/core/utils/widgets/app_bar.dart';
import 'package:sahab_project/core/utils/widgets/circular_progress_indicator.dart';
import 'package:sahab_project/core/utils/widgets/custom_no_internet_and_error_view.dart';
import 'package:sahab_project/core/utils/widgets/custom_simple_app_bar_widget.dart';
import 'package:sahab_project/feature/home/presentation/manager/area_cubit/area_cubit.dart';

import '../../../../generated/l10n.dart';

class AreaPage extends StatelessWidget {
  const AreaPage({super.key});
// todo : finish translate
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          CustomSimpleAppBarWidget(
            // onIconTap: () {
            //   Navigator.of(context).pop();
            // },
            // iconPath: AppIcons.backArrow,
            appBarTitle: S.of(context).area,
          ),
          BlocBuilder<AreaCubit, AreaState>(
            builder: (context, state) {
              if (state is GetAllAreaLoadingState) {
                return Expanded(
                  child: Center(
                    child: CustomCircularProgressIndicator(),
                  ),
                );
              } else if (state is GetAllAreaFailureState) {
                return CustomNoInternetAndErrorView();
              } else {
                return AreaHomePage();
              }
            },
          ),
        ],
      ),
    );
  }
}

class AreaHomePage extends StatelessWidget {
  const AreaHomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    AreaCubit areaCubit = AreaCubit.get(context);
    return Expanded(
      child: ListView(
        padding: const EdgeInsets.all(0),
        children: [
          const SizedBox(
            height: 20,
          ),
          //! ----------------------------------------
          CheckboxListTile(
            title: Text(
              S.of(context).all,
              style: AppStyles.style16(context).copyWith(
                  color: AppColor.blueColor, fontWeight: FontWeight.w700),
            ),
            value: areaCubit.selectAll,
            activeColor: AppColor.blueColor,
            onChanged: (bool? value) {
              areaCubit.selectAllArea(value ?? false);
            },
          ),
          //! ----------------------  -----------------------------
          //? this list view the area to flitter
          ListView.builder(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            physics:
                const NeverScrollableScrollPhysics(), //! To make the ListView wrap its contents
            itemCount: areaCubit.areaList.length,
            itemBuilder: (BuildContext context, int index) {
              return CheckboxListTile(
                title: Text(
                  areaCubit.areaList[index].area ??
                      "", //S.of(context).area_name,
                  style: AppStyles.style16(context)
                      .copyWith(color: AppColor.areaNameColor),
                ),
                value: areaCubit.areaList[index].selected,
                activeColor: AppColor.blueColor,
                onChanged: (bool? value) {
                  areaCubit.selectedArea(index, value ?? false);
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
