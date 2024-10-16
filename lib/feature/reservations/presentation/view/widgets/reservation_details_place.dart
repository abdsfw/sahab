import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:sahab_project/core/enums/type_post_enum.dart';
import 'package:sahab_project/core/theme/app_color.dart';
import 'package:sahab_project/core/theme/app_textsyle.dart';
import 'package:sahab_project/core/utils/functions/function.dart';
import 'package:sahab_project/core/utils/widgets/app_button.dart';
import 'package:sahab_project/core/utils/widgets/circular_progress_indicator.dart';
import 'package:sahab_project/core/utils/widgets/custom_simple_app_bar_widget.dart';
import 'package:sahab_project/feature/reservations/data/model/place_reservation_details_model.dart';
import 'package:sahab_project/feature/reservations/presentation/manager/cancel_reservation_cubit/cancel_reservation_cubit.dart';
import 'package:sahab_project/feature/reservations/presentation/view/pages/reservation_details_page.dart';
import 'package:sahab_project/feature/reservations/presentation/view/widgets/custom_reservation_booking_details.dart';
import 'package:sahab_project/feature/reservations/presentation/view/widgets/reservation_payment_details.dart';
import 'package:sahab_project/generated/l10n.dart';

class ReservationDetailsPlace extends StatelessWidget {
  const ReservationDetailsPlace({
    super.key,
    required this.placeModel,
  });
  final PlaceReservationDetailsModel placeModel;

  @override
  Widget build(BuildContext context) {
    String image = placeModel.images!.isEmpty ? "" : placeModel.images?.first;
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
            bookingId: placeModel.id.toString(),
            status: placeModel.status ?? "",
          ),
          //? ---------------------
          SizedBox(height: 16.h),
          //? image , title , tag
          ImageContainer(
            imagePath: image, //placeModel.images?.first ?? "",
            title: placeModel.placeTitle ?? "",
            secondTitle: placeModel.categoryTitle ?? "",
            tag: AppFunction.typeTranslate(placeModel.tag ?? "", context),
            typeToggle: TypeToggle.place,
          ),
          //? --------------------
          SizedBox(height: 30.h),
          //? address
          AddressSection(
            address: placeModel.address ?? "",
            typeToggle: TypeToggle.place,
          ),
          //? -------------------
          SizedBox(height: 17.h),
          const CustomDivider(),
          SizedBox(height: 22.h),
          //? name and number
          UserDetailsSection(
            name: placeModel.name ?? "",
            phone: placeModel.phone ?? "",
          ),
          //? -----------------------
          SizedBox(height: 17.h),
          const CustomDivider(),
          SizedBox(height: 22.h),
          //? booking details , title and dates
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: CustomReservationBookingDetails(
              endDateText: S.of(context).end_date, // "End Date",
              startDateText: S.of(context).startDate, // "Start Date",
              typeToggle: TypeToggle.place,
              startDate: placeModel.startingDate ?? DateTime.now(),
              endDate: placeModel.endingDate ?? DateTime.now(),
              title: S.of(context).booking_details, // "Booking Details",
              subTitle: placeModel.placeTitle ?? "",
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
              bookingAmount: placeModel.totalPrice.toString(),
              discount: placeModel.discount.toString(),
              invoiceReference: placeModel.invoiceReference ?? "",
              paymentMethod: placeModel.paymentMethod ?? "",
              referenceId: placeModel.referenceId ?? "",
              total: placeModel.total.toString(),
              transactionId: placeModel.transactionId ?? "",
            ),
          ),
          //? --------------------
          SizedBox(height: 55.h),
          //? cancel button
          if (placeModel.status == "placed")
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
                          .cancelBooking(id: placeModel.id ?? -1);
                      Navigator.of(context).pop();
                    },
                    //? ---"Are you sure want to Delete This Reservation",
                    text1: S.of(context).first_delete_reservation_message,
                    //?  "deleting post will not effect on any previous bookings",
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
