import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:sahab_project/core/enums/type_post_enum.dart';
import 'package:sahab_project/core/theme/app_color.dart';
import 'package:sahab_project/core/theme/app_textsyle.dart';
import 'package:sahab_project/core/utils/extension/date_time_extension.dart';
import 'package:sahab_project/core/utils/functions/function.dart';
import 'package:sahab_project/core/utils/widgets/app_button.dart';
import 'package:sahab_project/core/utils/widgets/circular_progress_indicator.dart';
import 'package:sahab_project/core/utils/widgets/custom_no_internet_and_error_view.dart';
import 'package:sahab_project/feature/Bookings/presentation/manager/booking_cubit/booking_cubit.dart';
import 'package:sahab_project/feature/Bookings/presentation/manager/cancel_booking_cubit/cancel_booking_cubit.dart';
import 'package:sahab_project/feature/Bookings/presentation/views/rate_booking_page.dart';
import 'package:sahab_project/feature/Bookings/presentation/views/widgets/first_card_booking_details_widget.dart';
import 'package:sahab_project/feature/Bookings/presentation/views/widgets/payment_details.dart';
import 'package:sahab_project/feature/account/presentation/manager/details_delete_cubit/details_delete_cubit.dart';
import '../../../../core/utils/icons/app_icons.dart';
import '../../../../core/utils/widgets/custom_booking_details.dart';
import '../../../../core/utils/widgets/custom_contact_details_widget.dart';
import '../../../../core/utils/widgets/custom_simple_app_bar_widget.dart';
import '../../../../generated/l10n.dart';
import '../../../../core/utils/widgets/custom_data_container.dart';
import 'widgets/test.dart';

class BookingDetailsPage extends StatelessWidget {
  const BookingDetailsPage(
      {super.key, required this.bookingId, required this.typeToggle});
  final int bookingId;
  final TypeToggle typeToggle;
// todo : finish translate
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => BookingCubit()
            ..getBookingDetails(context, id: bookingId, typeToggle: typeToggle),
        ),
        BlocProvider(
          create: (context) => CancelBookingCubit(),
        ),
      ],
      child: BlocConsumer<CancelBookingCubit, CancelBookingState>(
        listener: (context, state) {
          // TODO: implement listener
          if (state is SuccessCancelBookingState) {
            Navigator.of(context).pop("success");
          } else if (state is FailureCancelBookingState) {
            AppFunction.confirmDialog(
              context,
              title: S.of(context).general_error,
              onYesTap: () {
                Navigator.of(context).pop();
              },
            );
          }
        },
        builder: (context, state) {
          return ModalProgressHUD(
            inAsyncCall: state is LoadingCancelBookingState,
            progressIndicator: CustomCircularProgressIndicator(),
            child: Scaffold(
              body: Column(
                children: [
                  CustomSimpleAppBarWidget(
                    appBarTitle: S.of(context).my_bookings,
                  ),
                  // SizedBox(height: 10.h),
                  BlocBuilder<BookingCubit, BookingState>(
                    builder: (context, state) {
                      if (state is LoadingFetchDetailsBookingState) {
                        return Expanded(
                          child: Center(
                            child: CustomCircularProgressIndicator(),
                          ),
                        );
                      } else if (state is FailureFetchDetailsBookingState) {
                        return Expanded(
                          child: CustomNoInternetAndErrorView(
                            onTryAgainButton: () {
                              BlocProvider.of<BookingCubit>(context)
                                  .getBookingDetails(context,
                                      id: bookingId, typeToggle: typeToggle);
                            },
                          ),
                        );
                      } else if (state is SuccessFetchDetailsBookingState) {
                        return BookingDetailsBody(
                          typeToggle: typeToggle,
                          bookingId: bookingId,
                        );
                      }
                      return SizedBox();
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class BookingDetailsBody extends StatelessWidget {
  const BookingDetailsBody({
    super.key,
    required this.typeToggle,
    required this.bookingId,
  });
  final TypeToggle typeToggle;
  final int bookingId;
  @override
  Widget build(BuildContext context) {
    BookingCubit cubit = BookingCubit.get(context);
    var data;
    if (typeToggle == TypeToggle.place) {
      data = cubit.bookingPlaceDetailsData;
    } else {
      data = cubit.bookingServiceDetailsData;
    }
    // Booking data = cubit.bookingDetailsData?.bookings?[0] ?? Booking();
    String? valueOfRating;
    switch (int.tryParse(data.userRating.toString()) ?? 0) {
      case 25:
        valueOfRating = S.of(context).bad;
        break;
      case 50:
        valueOfRating = S.of(context).good; //"good";
        break;
      case 100:
        valueOfRating = S.of(context).excellent;
        break;
      default:
    }
    List<String> image = [];
    for (var element in data.bookings.images) {
      image.add(element.toString());
    }
    return Expanded(
      child: ListView(
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // SizedBox(height: 10.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FirstCardBookingDetails(
                  address: TypeToggle.service == typeToggle
                      ? null
                      : data.bookings.address ?? "",
                  images: image,
                  rating: data.bookings.rating?.substring(0, 3) ?? "",
                  tag: TypeToggle.service == typeToggle
                      ? null
                      : AppFunction.typeTranslate(
                          data.bookings.tag ?? "", context),
                  weekdayPrice: TypeToggle.service == typeToggle
                      ? data.bookings.totalPrice ?? -1
                      : data.bookings.weekdayPrice ?? -1,
                  title: TypeToggle.service == typeToggle
                      ? data.bookings.serviceTitle ?? ""
                      : data.bookings.placeTitle ?? "",
                ),
                // SizedBox(height: 10.h),
                CustomDataContainer(
                  id: data.bookings.id ?? -1,
                  amount: data.bookings.totalPrice ?? -1,
                  categoryTitle: data.bookings.categoryTitle ?? "",
                  status: data.bookings.status ?? "",
                ),
                SizedBox(height: 24.h),
                CustomContactDetailsWidget(
                  name: data.bookings.name ?? "",
                  phone: data.bookings.phone ?? "",
                ),
                SizedBox(height: 31.h),
                CustomBookingDetails(
                  subTitle: TypeToggle.service == typeToggle
                      ? data.bookings.serviceTitle ?? ""
                      : data.bookings.placeTitle ?? "",
                  startDate: data.bookings.startingDate ?? DateTime.now(),
                  endDate: data.bookings.endingDate ?? DateTime.now(),
                  typeToggle: typeToggle,
                  address: typeToggle == TypeToggle.service
                      ? data.bookings.address ?? ""
                      : null,
                ),
                SizedBox(height: 26.h),
                PaymentDetails(
                  bookingAmount: data.bookings.totalPrice ?? "",
                  discount: data.bookings.discount ?? "",
                  invoiceReference: data.bookings.invoiceReference ?? "",
                  paymentMethod: data.bookings.paymentMethod ?? " ",
                  referenceId: data.bookings.referenceId ?? "",
                  total: data.bookings.total ?? "",
                  transactionId: data.bookings.transactionId ?? "",
                ),
                SizedBox(height: 31.h),
                // if ((data?.showButton != null &&
                //         data!.bookings.status != "canceled") ||
                //     (!DateTime.now().isLessThatOrEqual(
                //         data.bookings.endingDate ?? DateTime.now())))

                if ((data.canCancel ||
                        data.canRate ||
                        data.userRating != null) &&
                    data!.bookings.status != "canceled")
                  AppButton(
                    height: 50.h,
                    // width: double.infinity,
                    onTap: () {
                      // if (data!.showButton!) {
                      if (data!.canCancel) {
                        //? cancel method
                        AppFunction.deleteQuestionDialog(
                          context,
                          title:
                              S.of(context).cancel_booking, //"Cancel Booking",
                          text1:
                              S.of(context).are_you_sure_want_to_cancel_booking,
                          // text2: "",
                          onYesTap: () {
                            BlocProvider.of<CancelBookingCubit>(context)
                                .cancelBooking(id: bookingId);
                            Navigator.of(context).pop();
                          },
                          onNoTap: () {
                            Navigator.of(context).pop();
                          },
                          isLoading: false,
                        );
                      } else if (data!.userRating == null && data.canRate) {
                        Navigator.push(
                          context,
                          CupertinoPageRoute(
                            builder: (context) => RateBookingPage(
                              id: bookingId,
                            ),
                          ),
                        ).then((value) {
                          if (value == "success") {
                            BlocProvider.of<BookingCubit>(context)
                                .getBookingDetails(context,
                                    id: bookingId, typeToggle: typeToggle);
                          }
                        });
                      } else {}
                    },
                    text: data!.canCancel //data!.showButton!
                        ? S.of(context).cancel_booking
                        : data!.userRating == null && data.canRate
                            ? S.of(context).rate_booking
                            : "${S.of(context).you_are_rating} $valueOfRating",
                    color: data!.canCancel
                        ? AppColor.redColor
                        : AppColor.blueColor,
                    radius: 5,
                    fontSize: 16,
                    fontFamily: AppStyles.getFontFamily(context),
                    textColor: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                SizedBox(height: 20.h),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
