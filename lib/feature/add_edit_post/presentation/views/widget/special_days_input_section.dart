import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:sahab_project/core/utils/extension/date_time_extension.dart';
import 'package:sahab_project/core/utils/functions/function.dart';
import 'package:sahab_project/core/utils/widgets/app_button.dart';
import 'package:sahab_project/feature/places/presentation/widgets/calendar.dart';
import 'package:sahab_project/core/utils/widgets/custom_app_sub_title.dart';
import 'package:sahab_project/core/utils/widgets/custom_input_field.dart';
import 'package:sahab_project/core/utils/widgets/custom_table_range.dart';
import 'package:sahab_project/core/utils/widgets/custom_title_input_field.dart';
import 'package:sahab_project/feature/add_edit_post/data/model/special_days_model.dart';
import 'package:sahab_project/feature/add_edit_post/presentation/manager/next_post_place_cubit/next_post_place_cubit.dart';

import '../../../../../core/theme/app_color.dart';
import '../../../../../core/theme/app_textsyle.dart';
import '../../../../../core/utils/icons/app_icons.dart';
import '../../../../../core/utils/widgets/custom_app_title.dart';
import '../../../../../generated/l10n.dart';
import '../../manager/special_date_cubit/special_date_cubit.dart';
import '../../manager/special_days_view_cubit/special_days_view_cubit.dart';

class SpecialDaysInputSection extends StatelessWidget {
  const SpecialDaysInputSection({
    super.key,
  });
  // todo : finish translate
  @override
  Widget build(BuildContext context) {
    NextPostPlaceCubit nextPostPlaceCubit = NextPostPlaceCubit.get(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomAppTitle(
          title: S.of(context).special_days_Optional,
          style: AppStyles.textstyle16w500DarkBlue(context).copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 11.h),
        Text(
          S
              .of(context)
              .lormn_ipsum_small, //'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
          style: AppStyles.textStyle14w400GreyHint(context).copyWith(
            color: AppColor.greyColorWithOpacity,
          ),
        ),
        SizedBox(height: 7.h),
        InkWell(
          onTap: () {
            AppFunction.addSpecialDayBottomSheet(context).then((value) {
              //? here we have to  close the sheet after we open it in always
              nextPostPlaceCubit.clearSpecialDaysControllers();
              BlocProvider.of<SpecialDaysViewCubit>(context)
                  .updateListViewState(context);
            });
          },
          child: Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              border: Border.all(
                color: Colors.black,
                width: 1,
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SvgPicture.asset(
                  AppIcons.plusIcon,
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  S.of(context).add_dates,
                  style: AppStyles.textStyle13w600Black(context),
                ),
              ],
            ),
          ),
        ),
        //? here we have to put the days that been chosen in new cubit

        BlocBuilder<SpecialDaysViewCubit, SpecialDaysViewState>(
          builder: (context, state) {
            if (state is ListViewSpecialDaysViewState) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 8.h,
                  ),
                  ListView.builder(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: nextPostPlaceCubit.specialDaysList.length,
                    itemBuilder: (context, index) => SpecialDayItem(
                      data: nextPostPlaceCubit.specialDaysList[index],
                      index: index,
                    ),
                  )
                ],
              );
            }
            return SizedBox();
          },
        ),
      ],
    );
  }
}

class SpecialDayItem extends StatelessWidget {
  const SpecialDayItem({
    super.key,
    required this.data,
    required this.index,
  });
  final SpecialDaysModel data;
  final int index;
  @override
  Widget build(BuildContext context) {
    String startDate =
        DateFormat("dd/MM/yyyy", "en").format(data.rangeDate.start);
    String endDate = DateFormat("dd/MM/yyyy", "en").format(data.rangeDate.end);
    String rangeDate = startDate + " to " + endDate;
    return Column(
      children: [
        SizedBox(
          height: 34.h,
        ),
        Row(
          children: [
            Expanded(
              child: CustomAppTitle(
                title: data.title,
                style: AppStyles.textStyle16w400DarkBlue(context).copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            IconButton(
              onPressed: () {
                BlocProvider.of<NextPostPlaceCubit>(context)
                    .deleteSpecialDayByIndex(context, index: index);
              },
              icon: SvgPicture.asset(
                AppIcons.delete2,
              ),
            ),
          ],
        ),
        // SizedBox(
        //   height: 8.h,
        // ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: CustomAppTitle(
                title: rangeDate,
                style: AppStyles.textStyle16w400DarkBlue(context).copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            CustomAppTitle(
              title: "${data.price} KD",
              style: AppStyles.textStyle16w400DarkBlue(context).copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        SizedBox(
          height: 25.h,
        ),
        Divider(
          color: AppColor.grey2Color.withOpacity(0.5),
        ),
      ],
    );
  }
}
