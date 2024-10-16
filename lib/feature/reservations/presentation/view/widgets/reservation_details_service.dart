import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sahab_project/core/enums/type_post_enum.dart';
import 'package:sahab_project/core/theme/app_color.dart';
import 'package:sahab_project/core/theme/app_textsyle.dart';
import 'package:sahab_project/core/utils/functions/function.dart';
import 'package:sahab_project/core/utils/widgets/app_button.dart';
import 'package:sahab_project/core/utils/widgets/custom_simple_app_bar_widget.dart';
import 'package:sahab_project/feature/reservations/data/model/service_reservation_details_model.dart';
import 'package:sahab_project/feature/reservations/presentation/manager/cancel_reservation_cubit/cancel_reservation_cubit.dart';
import 'package:sahab_project/feature/reservations/presentation/view/pages/reservation_details_page.dart';
import 'package:sahab_project/feature/reservations/presentation/view/widgets/custom_reservation_booking_details.dart';
import 'package:sahab_project/feature/reservations/presentation/view/widgets/reservation_payment_details.dart';
import 'package:sahab_project/generated/l10n.dart';

class ReservationDetailsService extends StatelessWidget {
  const ReservationDetailsService({
    super.key,
    required this.serviceModel,
  });
  final ServiceReservationDetailsModel serviceModel;
  @override
  Widget build(BuildContext context) {
    String image =
        serviceModel.images!.isEmpty ? "" : serviceModel.images?.first;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //? appBar
          CustomSimpleAppBarWidget(
            appBarTitle: S.of(context).reservation,
          ),
          //? -------------------------
          SizedBox(height: 27.h),
          //? booking id and status
          FirstContainer(
            bookingId: serviceModel.id.toString(),
            status: serviceModel.status ?? "",
          ),
          //? ---------------------
          SizedBox(height: 16.h),
          //? image , title , tag
          ImageContainer(
            imagePath: image, //serviceModel.images?.first ?? "",
            title: serviceModel.serviceTitle ?? "",
            secondTitle: serviceModel.categoryTitle ?? "",
            // tag: serviceModel.t,
            typeToggle: TypeToggle.service,
          ),
          //? --------------------
          SizedBox(height: 30.h),
          //? address
          AddressSection(
            address: serviceModel.address ?? "",
            typeToggle: TypeToggle.service,
          ),
          //? -------------------
          SizedBox(height: 17.h),
          const CustomDivider(),
          SizedBox(height: 22.h),
          //? name and number
          UserDetailsSection(
            name: serviceModel.name ?? "",
            phone: serviceModel.phone ?? "",
          ),
          //? -----------------------
          SizedBox(height: 17.h),
          const CustomDivider(),
          SizedBox(height: 22.h),
          //? booking details , title and dates
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: CustomReservationBookingDetails(
              endDateText: S.of(context).time, //"Time",
              startDateText: S.of(context).date, //"Date",
              typeToggle: TypeToggle.service,
              startDate: serviceModel.startingDate ?? DateTime.now(),
              endDate: serviceModel.endingDate ?? DateTime.now(),
              title: "${S.of(context).details} ${serviceModel.serviceTitle}",
              subTitle: serviceModel.serviceTitle ?? "",
            ),
          ),
          //? ----------------------------------
          SizedBox(height: 17.h),
          const CustomDivider(),
          SizedBox(height: 22.h),
          //? payment details
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: ReservationPaymentDetails(
              bookingAmount: serviceModel.totalPrice.toString(),
              discount: serviceModel.discount.toString(),
              invoiceReference: serviceModel.invoiceReference ?? "",
              paymentMethod: serviceModel.paymentMethod ?? "",
              referenceId: serviceModel.referenceId ?? "",
              total: serviceModel.total.toString(),
              transactionId: serviceModel.transactionId ?? "",
            ),
          ),
          //? --------------------
          SizedBox(height: 55.h),
          //? cancel button
          if (serviceModel.status == "placed")
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: AppButton(
                height: 50.h,
                width: double.infinity,
                onTap: () {
                  AppFunction.deleteQuestionDialog(
                    context,
                    onNoTap: () {
                      Navigator.of(context).pop();
                    },
                    onYesTap: () {
                      BlocProvider.of<CancelReservationCubit>(context)
                          .cancelBooking(id: serviceModel.id ?? -1);
                      Navigator.of(context).pop();
                    },
                    text1: S
                        .of(context)
                        .first_delete_reservation_message, //"Are you sure want to Delete This Reservation",
                    text2: S.of(context).second_delete_reservation_message,
                    title: S
                        .of(context)
                        .delete_reservation, //"Delete Reservation",
                    isLoading: false,
                  );
                },
                text: S.of(context).cancel_booking,
                color: AppColor.redColor,
                radius: 5,
                fontSize: 16,
                fontFamily: AppStyles.getFontFamily(context),
                textColor: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          //? ------------------
          SizedBox(
            height: 20.h,
          ),
        ],
      ),
    );
  }
}
