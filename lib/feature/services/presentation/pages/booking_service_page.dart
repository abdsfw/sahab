import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sahab_project/core/enums/type_post_enum.dart';
import 'package:sahab_project/core/theme/app_color.dart';
import 'package:sahab_project/core/theme/app_textsyle.dart';
import 'package:sahab_project/core/utils/widgets/circular_progress_indicator.dart';
import 'package:sahab_project/core/utils/widgets/custom_no_internet_and_error_view.dart';
import 'package:sahab_project/core/utils/widgets/custom_simple_app_bar_widget.dart';
import 'package:sahab_project/feature/account/presentation/manager/account_cubit/account_cubit.dart';
import 'package:sahab_project/feature/auth/presentation/pages/login/login_screen.dart';
import 'package:sahab_project/feature/checkout/presentation/views/check_out_page.dart';
import 'package:sahab_project/feature/services/presentation/manager/manage_service_booking_data_cubit/manage_service_booking_data_cubit.dart';
import 'package:sahab_project/feature/services/presentation/manager/service_booking_date_cubit/service_booking_date_cubit.dart';
import '../../../../core/utils/widgets/app_button.dart';
import '../../../../generated/l10n.dart';
import '../widgets/address_and_amount_section.dart';
import '../widgets/booking_date_section.dart';
import '../widgets/booking_time_section.dart';

class BookingServicePage extends StatelessWidget {
  const BookingServicePage({
    super.key,
    required this.price,
    required this.serviceID,
    required this.serviceTitle,
  });
  final num price;
  final int serviceID;
  final String serviceTitle;
// todo : finish translate
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ServiceBookingDateCubit()
            ..setPriceTitleId(
                price: price, serviceTitle: serviceTitle, id: serviceID)
            ..fetchEnableService(serviceId: serviceID),
        ),
        BlocProvider(
          create: (context) => ManageServiceBookingDataCubit(),
        ),
      ],
      child: Scaffold(
        body: BlocBuilder<ServiceBookingDateCubit, ServiceBookingDateState>(
          builder: (context, state) {
            // return BookingServiceBody();

            if (state is LoadingFetchServiceDates) {
              return Center(
                child: CustomCircularProgressIndicator(),
              );
            } else if (state is FailureFetchServiceDates) {
              return CustomNoInternetAndErrorView(
                onTryAgainButton: () {
                  BlocProvider.of<ServiceBookingDateCubit>(context)
                      .fetchEnableService(serviceId: serviceID);
                },
              );
            } else if (state is SuccessFetchServiceDates) {
              return BookingServiceBody();
            }
            return SizedBox();
          },
        ),
      ),
    );
  }
}

class BookingServiceBody extends StatelessWidget {
  const BookingServiceBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    ServiceBookingDateCubit cubit = ServiceBookingDateCubit.get(context);
    ManageServiceBookingDataCubit manageCubit =
        ManageServiceBookingDataCubit.get(context);
    return Column(
      children: [
        CustomSimpleAppBarWidget(
          appBarTitle: S.of(context).book_now,
        ),
        SizedBox(height: 15.h),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 35.h),
                      const BookingDateSection(),
                      SizedBox(height: 36.h),
                      const BookingTimeSection(),
                      SizedBox(height: 28.h),
                      const AddressAndAmountSection(),
                      SizedBox(
                        height: 18.h,
                      ),
                      BlocBuilder<ManageServiceBookingDataCubit,
                          ManageServiceBookingDataState>(
                        builder: (context, state) {
                          return AppButton(
                            width: double.infinity,
                            height: 50.h,
                            onTap: state is SuccessToGoToCheckout
                                ? () {
                                    if (BlocProvider.of<AccountCubit>(context)
                                            .userRole ==
                                        'guest') {
                                      Navigator.of(context).push(
                                        CupertinoPageRoute(
                                          builder: (context) => LoginScreen(
                                            atBooking: true,
                                            withReturn: true,
                                          ),
                                        ),
                                      );
                                    } else {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => CheckOutPage(
                                            typeToggle: TypeToggle.service,
                                            bookingTitle:
                                                cubit.serviceTitle ?? "",
                                            price: cubit.price ?? 0,
                                            startDate: manageCubit
                                                .selectedRangeTime!.start,
                                            endDate: manageCubit
                                                .selectedRangeTime!.end,
                                            id: cubit.id!,
                                            address: manageCubit
                                                .addressController.text,
                                          ),
                                        ),
                                      );
                                    }
                                  }
                                : null,
                            text: S.of(context).proceed_to_checkout,
                            color: state is SuccessToGoToCheckout
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
                        height: 20.h,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
