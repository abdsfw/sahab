import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sahab_project/feature/services/presentation/manager/manage_service_booking_data_cubit/manage_service_booking_data_cubit.dart';
import 'package:sahab_project/feature/services/presentation/manager/service_booking_date_cubit/service_booking_date_cubit.dart';

import '../../../../core/theme/app_textsyle.dart';
import '../../../../core/utils/widgets/custom_app_title.dart';
import '../../../../core/utils/widgets/custom_input_field.dart';
import '../../../../generated/l10n.dart';

class AddressAndAmountSection extends StatelessWidget {
  const AddressAndAmountSection({
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
        CustomAppTitle(
          title: S.of(context).enter_your_address_,
          style: AppStyles.textStyle20w600DarkBlue(context).copyWith(
            color: Colors.black,
          ),
        ),
        CustomInputField(
          controller: manageCubit.addressController, //TextEditingController(),
          hintText: S.of(context).enter_here, //"Enter Here",
          minLine: 4,
          maxLine: 4,
          onChange: (p0) {
            manageCubit.checkIfCanGoToCHeckout();
          },
          // validator: AppFunction.customFormFieldValidator,
        ),
        SizedBox(
          height: 76.h,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: CustomAppTitle(
                title: S.of(context).booking_amount, //"Booking Amount",
                style: AppStyles.textStyle20w600DarkBlue(context).copyWith(
                  fontWeight: FontWeight.w500,
                  fontSize: 18.sp,
                ),
              ),
            ),
            CustomAppTitle(
              title: "${cubit.price} KD",
              style: AppStyles.textStyle20w600DarkBlue(context).copyWith(
                fontWeight: FontWeight.w500,
                fontSize: 18.sp,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
