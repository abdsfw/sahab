import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sahab_project/core/enums/type_post_enum.dart';
import 'package:sahab_project/core/theme/app_color.dart';
import 'package:sahab_project/core/theme/app_textsyle.dart';
import 'package:sahab_project/core/utils/widgets/app_button.dart';
import 'package:sahab_project/core/utils/widgets/circular_progress_indicator.dart';
import 'package:sahab_project/core/utils/widgets/custom_no_internet_and_error_view.dart';
import 'package:sahab_project/feature/auth/presentation/pages/login/login_screen.dart';
import 'package:sahab_project/feature/checkout/presentation/manager/promo_code_cubit/promo_code_cubit.dart';
import 'package:sahab_project/feature/checkout/presentation/views/check_out_page.dart';
import 'package:sahab_project/feature/places/data/model/place_details_model/special_days.dart';
import 'package:sahab_project/feature/places/presentation/manager/place_booking_date_cubit/place_booking_date_cubit.dart';
import 'package:sahab_project/feature/places/presentation/manager/place_details_cubit/place_details_cubit.dart';
import 'package:sahab_project/feature/places/presentation/widgets/calendar.dart';
import 'package:sahab_project/core/utils/widgets/custom_simple_app_bar_widget.dart';
import 'package:sahab_project/generated/l10n.dart';

import '../../../../core/utils/widgets/custom_two_date_selected_widget.dart';
import '../../../account/presentation/manager/account_cubit/account_cubit.dart';

class BookNow extends StatelessWidget {
  const BookNow({
    super.key,
    required this.weekDayPrice,
    required this.weekEndPrice,
    required this.placeId,
    this.specialDays,
    // this.isEdit = false,
  });
  final num weekDayPrice;
  final num weekEndPrice;
  final int placeId;
  final List<SpecialDays>? specialDays;

  // final bool isEdit;
  @override
  Widget build(BuildContext context) {
    // DateTime? selectedEndDate;
    return BlocProvider(
      create: (context) => PlaceBookingDateCubit()
        ..setTwoPrice(weekDayPrice: weekDayPrice, weekEndPrice: weekEndPrice)
        ..fetchIgnorePlaceDate(placeId: placeId)
        ..setSpecial(specialDays),
      child: WillPopScope(
        onWillPop: () async {
          BlocProvider.of<PromoCodeCubit>(context).reset();

          return true;
        },
        child: Scaffold(
          body: BlocBuilder<PlaceBookingDateCubit, PlaceBookingDateState>(
            builder: (context, state) {
              if (state is LoadingFetchIgnoreDatesState) {
                return Center(
                  child: CustomCircularProgressIndicator(),
                );
              } else if (state is FailureFetchIgnoreDatesState) {
                return CustomNoInternetAndErrorView(
                  onTryAgainButton: () {
                    BlocProvider.of<PlaceBookingDateCubit>(context)
                        .fetchIgnorePlaceDate(placeId: placeId);
                  },
                  withReturn: true,
                );
              } else {
                return BookNowBody();
              }
            },
          ),
        ),
      ),
    );
  }
}

class BookNowBody extends StatelessWidget {
  const BookNowBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    PlaceBookingDateCubit cubit = PlaceBookingDateCubit.get(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomSimpleAppBarWidget(
          appBarTitle: S.of(context).booking_now,
          onIconTap: () {
            BlocProvider.of<PromoCodeCubit>(context).reset();
            Navigator.of(context).pop();
          },
        ),
        Expanded(child: SizedBox()),
        Calendar(),
        Expanded(
          child: SizedBox(
              // height: 36.h,
              ),
        ),
        BlocBuilder<PlaceBookingDateCubit, PlaceBookingDateState>(
            builder: (context, state) {
          if (cubit.startDateString != null && cubit.endDateString != null) {
            return CustomTwoDateSelectedWidget(
              startDateTime: cubit.startDateString!,
              endDateTime: cubit.endDateString!,
            );
          }
          return SizedBox();
        }),
        Expanded(
          flex: 6,
          child: SizedBox(
              // height: 200.h,
              ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                S.of(context).booking_amount,
                style: AppStyles.style18semibold(context),
              ),
              BlocBuilder<PlaceBookingDateCubit, PlaceBookingDateState>(
                builder: (context, state) {
                  return Text(
                    "${cubit.totalPrice.toStringAsFixed(3)} KD",
                    style: AppStyles.style18semibold(context),
                  );
                },
              ),
            ],
          ),
        ),
        // SizedBox(
        //   height: 16.h,
        // ),
        BlocBuilder<PlaceBookingDateCubit, PlaceBookingDateState>(
          builder: (context, state) {
            return Padding(
              padding: EdgeInsets.all(16),
              child: AppButton(
                onTap: (cubit.startDate == null)
                    ? null
                    : () {
                        //? navigate to check out
                        if (BlocProvider.of<AccountCubit>(context).userRole ==
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
                          Navigator.of(context).push(
                            CupertinoPageRoute(
                              builder: (context) => CheckOutPage(
                                endDate: cubit.endDate ?? DateTime.now(),
                                id: BlocProvider.of<PlaceDetailsCubit>(context)
                                        .placeDetails
                                        ?.id ??
                                    -1,
                                startDate: cubit.startDate ?? DateTime.now(),
                                price: cubit.totalPrice,
                                typeToggle: TypeToggle.place,
                                bookingTitle:
                                    BlocProvider.of<PlaceDetailsCubit>(context)
                                            .placeDetails
                                            ?.title ??
                                        "",
                              ),
                            ),
                          );
                        }
                      },
                text: S.of(context).proceed_to_checkout,
                color: (cubit.startDate == null)
                    ? AppColor.stepColor
                    : AppColor.blueColor,
                radius: 5,
                fontSize: 16.sp,
                textColor: Colors.white,
                fontWeight: FontWeight.w600,
                fontFamily: AppStyles.getFontFamily(context),
                height: 50.h,
              ),
            );
          },
        ),
      ],
    );
  }
}
