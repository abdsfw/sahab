import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sahab_project/core/enums/type_post_enum.dart';
import 'package:sahab_project/core/theme/app_color.dart';
import 'package:sahab_project/core/theme/app_textsyle.dart';
import 'package:sahab_project/core/utils/icons/app_icons.dart';
import 'package:sahab_project/core/utils/widgets/app_button.dart';
import 'package:sahab_project/core/utils/widgets/custom_booking_details.dart';
import 'package:sahab_project/core/utils/widgets/custom_simple_app_bar_widget.dart';
import 'package:sahab_project/feature/checkout/data/model/add_booking_response_model/add_booking_response_model.dart';
import 'package:sahab_project/feature/checkout/presentation/manager/can_pay_cubit/can_pay_cubit.dart';
import 'package:sahab_project/feature/checkout/presentation/manager/checkout_cubit/checkout_cubit.dart';
// import 'package:sahab_project/feature/Bookings/presentation/views/booking_places_page.dart';
import 'package:sahab_project/feature/checkout/presentation/views/check_out_page.dart';
import 'package:sahab_project/feature/checkout/presentation/views/success_checkout_page.dart';
import 'package:sahab_project/feature/places/presentation/manager/place_details_cubit/place_details_cubit.dart';
import 'package:sahab_project/feature/places/presentation/pages/book_now.dart';
import 'package:sahab_project/generated/l10n.dart';
// import '../../../../core/utils/widgets/custom_app_sub_title.dart';
// import '../../../home/presentation/widgets/search_field.dart';

class CheckoutPageBody extends StatelessWidget {
  const CheckoutPageBody({
    super.key,
    required this.typeToggle,
    required this.bookingTitle,
    this.serviceAddress,
  });
  final TypeToggle typeToggle;
  final String bookingTitle;

  final String? serviceAddress;
  @override
  Widget build(BuildContext context) {
    CheckoutCubit checkoutCubit = CheckoutCubit.get(context);
    CanPayCubit canPayCubit = CanPayCubit.get(context);
    return Expanded(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: ListView(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20.h),
            const CheckOutContactDetails(),
            SizedBox(
              height: 30.h,
            ),
            CustomBookingDetails(
              typeToggle: typeToggle,
              subTitle: bookingTitle, //"Royal Chalet Kuwait",
              startDate: checkoutCubit.startDate!,
              endDate: checkoutCubit.endDate!,
              address: serviceAddress,
              withEditDate: () {
                Navigator.of(context).pop();
              },
            ),
            SizedBox(height: 30.h),
            const PromoCodeSection(),
            const PaymentMethodSection(),
            SizedBox(height: 48.h),
            const CheckOutPaymentDetails(),
            BlocBuilder<CanPayCubit, CanPayState>(
              builder: (context, state) {
                return AppButton(
                  width: double.infinity,
                  height: 50.h,
                  onTap: state is CanCompletePayState
                      ? () {
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //       builder: (context) =>
                          //           const SuccessCheckoutPage(),
                          //     ));
                          checkoutCubit.addBooking(typeToggle: typeToggle);
                        }
                      : null,
                  text: S.of(context).proceed_to_payment,
                  color: state is CanCompletePayState
                      ? AppColor.blueColor
                      : AppColor.stepColor,
                  radius: 5.r,
                  fontSize: 16.sp,
                  fontFamily: AppStyles.getFontFamily(context),
                  textColor: Color(0xffFFFFFF),
                  fontWeight: FontWeight.w600,
                );
              },
            ),
            SizedBox(
              height: 36.h,
            ),
          ],
        ),
      ),
    );
  }
}
