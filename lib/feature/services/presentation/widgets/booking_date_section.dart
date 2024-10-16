import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:sahab_project/core/utils/icons/app_icons.dart';
import 'package:sahab_project/feature/services/presentation/manager/manage_service_booking_data_cubit/manage_service_booking_data_cubit.dart';
import 'package:sahab_project/feature/services/presentation/manager/service_booking_date_cubit/service_booking_date_cubit.dart';
import 'package:sahab_project/feature/services/presentation/widgets/select_single_date_page.dart';
import 'package:sahab_project/generated/l10n.dart';

import '../../../../core/theme/app_color.dart';
import '../../../../core/theme/app_textsyle.dart';
import '../../../../core/utils/widgets/custom_app_title.dart';
import '../../../../core/utils/widgets/custom_title_input_field.dart';

class BookingDateSection extends StatelessWidget {
  const BookingDateSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    ServiceBookingDateCubit cubit = ServiceBookingDateCubit.get(context);
    ManageServiceBookingDataCubit manageCubit =
        ManageServiceBookingDataCubit.get(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomAppTitle(title: S.of(context).booking_date),
        SizedBox(height: 7.h),
        Text(
          S
              .of(context)
              .lorem_text, // "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
          style: AppStyles.textStyle16w400Black(context)
              .copyWith(color: AppColor.greyColor),
        ),
        SizedBox(height: 15.h),
        CustomTitleInputField(title: S.of(context).select_date_),
        SizedBox(height: 6.h),
        Material(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
          child: InkWell(
            borderRadius: BorderRadius.circular(5),
            onTap: () {
              Navigator.of(context)
                  .push(
                CupertinoPageRoute(
                  builder: (context) => SelectSingleDatePage(),
                ),
              )
                  .then((value) {
                String date = DateFormat("yyyy-MM-dd", "en").format(value);
                print(date);
                manageCubit.setSelectedDate(selected: value);
                manageCubit.makeRangeDateTimeToRangeOfTime(
                    BlocProvider.of<ServiceBookingDateCubit>(context)
                        .enableServiceDate[date]);
              });
            },
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 20.w),
              child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsetsDirectional.only(
                        top: 16,
                        bottom: 13,
                      ),
                      child: Text(
                        S.of(context).please_select, // 'Please Select',
                        style: AppStyles.textStyle16w400DarkBlue(context),
                      ),
                    ),
                  ),
                  SvgPicture.asset(AppIcons.date)
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
