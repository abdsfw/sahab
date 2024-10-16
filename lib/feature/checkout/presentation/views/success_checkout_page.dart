import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sahab_project/core/enums/type_post_enum.dart';
import 'package:sahab_project/core/theme/app_textsyle.dart';
import 'package:sahab_project/core/utils/icons/app_icons.dart';
import 'package:sahab_project/feature/Bookings/presentation/views/booking_places_page.dart';
import 'package:sahab_project/core/utils/widgets/custom_data_container.dart';
import 'package:sahab_project/feature/Bookings/presentation/views/widgets/payment_details.dart';
import 'package:sahab_project/feature/home/presentation/manager/bottomNavBar_cubit/bottom_nav_bar_cubit.dart';
import 'package:sahab_project/feature/home/presentation/pages/home_page_view.dart';
import '../../../../core/theme/app_color.dart';
import '../../../../core/utils/widgets/custom_booking_details.dart';
import '../../../../core/utils/widgets/custom_contact_details_widget.dart';
import '../../../../core/utils/widgets/custom_two_button.dart';
import '../../../../generated/l10n.dart';

class SuccessCheckoutPage extends StatelessWidget {
  const SuccessCheckoutPage({
    super.key,
    required this.typeToggle,
    this.id,
    // this.amount,
    this.categoryTitle,
    this.amount,
    this.invoiceReference,
    this.paymentMethod,
    this.referenceId,
    this.transactionId,
    this.total,
    this.discount,
    this.status,
    this.name,
    this.phone,
    this.startDate,
    this.endDate,
    this.address,
  });
  // todo : finish translate
  final TypeToggle typeToggle;
  final int? id;
  final num? amount;
  final String? categoryTitle;
  final String? invoiceReference;
  final String? paymentMethod;
  final String? referenceId;
  final String? transactionId;
  final String? discount;
  final String? total;
  final String? status;
  final String? name;
  final String? phone;
  final String? startDate;
  final String? endDate;
  final String? address;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(17.2),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    const SizedBox(width: double.infinity),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                    SvgPicture.asset(AppIcons.successPhoto1),
                    SvgPicture.asset(AppIcons.successPhoto2),
                    SizedBox(height: 30.h),
                  ],
                ),
                Text(
                  S.of(context).thank_you,
                  style: AppStyles.textStyle30w500black2(context),
                ),
                Text(
                  S.of(context).your_booking_has_been_placed,
                  style: AppStyles.textStyle30w500black2(context).copyWith(
                    fontSize: 16.sp,
                  ),
                ),
                SizedBox(height: 28.h),
                CustomDataContainer(
                  id: id?.toInt() ?? 0,
                  amount: amount ?? 0,
                  categoryTitle: categoryTitle ?? "",
                  status: status ?? "", //S.of(context).placed, //"status",
                ),
                SizedBox(height: 24.h),
                CustomContactDetailsWidget(
                  name: name ?? "",
                  phone: phone ?? "",
                ),
                SizedBox(height: 30.h),
                CustomBookingDetails(
                  typeToggle: typeToggle, //TypeToggle.place,
                  subTitle: categoryTitle ?? "", //"Royal Chalet Kuwait",
                  startDate: DateTime.parse(
                      startDate ?? "2020-02-02"), //DateTime.now(),
                  endDate:
                      DateTime.parse(endDate ?? "2020-02-02"), //DateTime.now(),
                  address: address,
                ),
                SizedBox(
                  height: 24.h,
                ),
                PaymentDetails(
                  bookingAmount: amount.toString(),
                  discount: discount ?? "",
                  invoiceReference: invoiceReference ?? "",
                  paymentMethod: paymentMethod ?? "",
                  referenceId: referenceId ?? "",
                  total: total ?? "",
                  transactionId: transactionId ?? "",
                ),
                SizedBox(height: 35.h),
                CustomTwoButton(
                  text1: S.of(context).my_bookings,
                  text2: S.of(context).back_to_home,
                  buttonColor1: AppColor.secondPrimaryColor,
                  buttonColor2: AppColor.blueColor,
                  textColor1: AppColor.whiteColor,
                  textColor2: AppColor.whiteColor,
                  onTap1: () {
                    BlocProvider.of<BottomNavBarCubit>(context).currentIndex =
                        1;
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                          builder: (context) => HomePageView(),
                        ),
                        (route) => false);
                  },
                  onTap2: () {
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                          builder: (context) => HomePageView(),
                        ),
                        (route) => false);
                    // Navigator.pushAndRemoveUntil(

                    //     context,
                    //     MaterialPageRoute(
                    //       builder: (context) => const HomePageView(),
                    //     ));
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
