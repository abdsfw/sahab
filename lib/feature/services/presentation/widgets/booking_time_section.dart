import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sahab_project/core/utils/widgets/custom_title_input_field.dart';
import 'package:sahab_project/feature/add_edit_post/presentation/views/widget/custom_drop_down_form_field.dart';
import 'package:sahab_project/feature/services/presentation/manager/manage_service_booking_data_cubit/manage_service_booking_data_cubit.dart';
import 'package:sahab_project/feature/services/presentation/manager/service_booking_date_cubit/service_booking_date_cubit.dart';
import '../../../../core/theme/app_color.dart';
import '../../../../core/theme/app_textsyle.dart';
import '../../../../core/utils/widgets/custom_app_title.dart';
import '../../../../generated/l10n.dart';

class BookingTimeSection extends StatelessWidget {
  const BookingTimeSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // ServiceBookingDateCubit cubit = ServiceBookingDateCubit.get(context);
    ManageServiceBookingDataCubit manageCubit =
        ManageServiceBookingDataCubit.get(context);
    return BlocBuilder<ManageServiceBookingDataCubit,
        ManageServiceBookingDataState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomAppTitle(title: S.of(context).booking_time_),
            SizedBox(height: 7.h),
            Text(
              S
                  .of(context)
                  .lorem_text, // "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
              style: AppStyles.textStyle16w400Black(context)
                  .copyWith(color: AppColor.greyColor),
            ),
            SizedBox(height: 22.h),
            //? will be visible when date isn't inputted
            Visibility(
              visible: manageCubit.selectedDate == null,
              child: Container(
                height: 117.h,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Center(
                  child: Text(
                    S
                        .of(context)
                        .please_select_date_first, //"Please Select Date First!",
                    style: AppStyles.textStyle18w500DarkBlue(context).copyWith(
                      color: AppColor.greyColor,
                    ),
                  ),
                ),
              ),
            ),
            //? will be visible when date is inputted
            Visibility(
              visible: manageCubit.selectedDate != null,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomTitleInputField(title: S.of(context).select_time_),
                  SizedBox(height: 6.h),
                  CustomDropDownFormField(
                    hintText: S.of(context).please_select, //"Please Select",
                    listItem: manageCubit.timeOfDate,
                    onChanged: (p0) {
                      manageCubit.searchInDate(p0 ?? "");
                    },
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
