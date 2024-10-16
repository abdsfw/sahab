import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sahab_project/core/const.dart';
import 'package:sahab_project/core/enums/type_post_enum.dart';
import 'package:sahab_project/core/theme/app_textsyle.dart';
import 'package:sahab_project/core/utils/cache/cache_helper.dart';
import 'package:sahab_project/core/utils/widgets/circular_progress_indicator.dart';
import 'package:sahab_project/core/utils/widgets/custom_no_internet_and_error_view.dart';
import 'package:sahab_project/feature/Bookings/presentation/manager/booking_cubit/booking_cubit.dart';
import 'package:sahab_project/feature/Bookings/presentation/manager/booking_toggle_cubit/booking_toggle_cubit.dart';
import 'package:sahab_project/feature/Bookings/presentation/manager/place_booking_cubit/place_booking_cubit.dart';
import 'package:sahab_project/feature/Bookings/presentation/manager/service_booking_cubit/service_booking_cubit.dart';
import 'package:sahab_project/feature/Bookings/presentation/views/booking_places_page.dart';
import 'package:sahab_project/feature/Bookings/presentation/views/widgets/no_booking_page.dart';
import 'package:sahab_project/feature/account/presentation/manager/account_cubit/account_cubit.dart';
import 'package:sahab_project/feature/auth/presentation/pages/login/login_screen.dart';
import '../../../../core/theme/app_color.dart';
import '../../../../core/utils/widgets/custom_two_button.dart';
import '../../../../generated/l10n.dart';
import '../../../../core/utils/widgets/custom_data_container.dart';

class BookingMainPage extends StatelessWidget {
  const BookingMainPage({super.key});

  @override
  Widget build(BuildContext context) {
    print(BlocProvider.of<AccountCubit>(context).userRole);
    if (BlocProvider.of<AccountCubit>(context).userRole == 'guest') {
      return LoginScreen(
        atBooking: true,
      );
    }
    return BookingHomePage();
  }
}

class BookingHomePage extends StatelessWidget {
  const BookingHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => BookingToggleCubit(),
        ),
        // BlocProvider(
        //   create: (context) => BookingCubit(),
        // ),
        BlocProvider(
          create: (context) =>
              ServiceBookingCubit()..getAllBookingServiceData(context),
        ),
        BlocProvider(
          create: (context) =>
              PlaceBookingCubit()..getAllBookingPlaceData(context),
        ),
      ],
      child: const BookingHomePageBody(),
    );
  }
}

class BookingHomePageBody extends StatelessWidget {
  const BookingHomePageBody({
    super.key,
  });
// todo : finish translate
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsetsDirectional.only(
          start: 16,
          top: 15.h,
          end: 16,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              S.of(context).my_bookings,
              style: AppStyles.textStyle16w400DarkBlue(context),
            ),
            SizedBox(
              height: 30.h,
            ),
            BlocBuilder<BookingToggleCubit, BookingToggleState>(
              builder: (context, state) {
                return CustomTwoButton(
                  text1: S.of(context).places,
                  text2: S.of(context).services,
                  buttonColor1: state is PlaceBookingPageState
                      ? AppColor.blueColor
                      : AppColor.grey2Color,
                  buttonColor2: state is ServiceBookingPageState
                      ? AppColor.blueColor
                      : AppColor.grey2Color,
                  textColor1: state is PlaceBookingPageState
                      ? const Color(0xffFFFFFF)
                      : AppColor.brownColor,
                  textColor2: state is ServiceBookingPageState
                      ? const Color(0xffFFFFFF)
                      : AppColor.brownColor,
                  onTap1: () {
                    BlocProvider.of<BookingToggleCubit>(context)
                        .togglePlaceService(TypeToggle.place);
                  },
                  onTap2: () {
                    BlocProvider.of<BookingToggleCubit>(context)
                        .togglePlaceService(TypeToggle.service);
                  },
                );
              },
            ),
            SizedBox(
              height: 19.h,
            ),
            BlocBuilder<BookingToggleCubit, BookingToggleState>(
              builder: (context, state) {
                if (state is ServiceBookingPageState) {
                  return const ServiceBookingListView();
                } else {
                  return const PlaceBookingListView();
                }
              },
            ),
            SizedBox(
              height: 20.h,
            ),
          ],
        ),
      ),
    );
  }
}

class PlaceBookingListView extends StatelessWidget {
  const PlaceBookingListView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: BlocBuilder<PlaceBookingCubit, PlaceBookingState>(
        builder: (context, state) {
          if (state is LoadingGetPlaceDataState) {
            return const Center(
              child: CustomCircularProgressIndicator(),
            );
          } else if (state is FailureGetPlaceDataState) {
            return CustomNoInternetAndErrorView(
              onTryAgainButton: () {
                BlocProvider.of<PlaceBookingCubit>(context)
                    .getAllBookingPlaceData(context);
              },
            );
          } else if (state is SuccessGetPlaceDataState) {
            if (state.placeBookingData.isEmpty) {
              return CustomNoDataPage(
                message: S.of(context).no_bookings,
              );
            }
            return ListView.separated(
              separatorBuilder: (context, index) => SizedBox(
                height: 10.h,
              ),
              itemCount: state.placeBookingData.length,
              itemBuilder: (context, index) => CustomDataContainer(
                title: state.placeBookingData[index].placeTitle ?? "",
                onTap: () {
                  Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (context) => BookingDetailsPage(
                        bookingId: state.placeBookingData[index].id ?? -1,
                        typeToggle: TypeToggle.place,
                      ),
                    ),
                  ).then((value) {
                    if (value == "success") {
                      BlocProvider.of<PlaceBookingCubit>(context)
                          .getAllBookingPlaceData(context);
                    }
                  });
                },
                amount: state.placeBookingData[index].totalPrice ?? -1,
                categoryTitle:
                    state.placeBookingData[index].categoryTitle ?? '',
                id: state.placeBookingData[index].id ?? -1,
                status: state.placeBookingData[index].status ?? '',
              ),
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}

class ServiceBookingListView extends StatelessWidget {
  const ServiceBookingListView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: BlocBuilder<ServiceBookingCubit, ServiceBookingState>(
        builder: (context, state) {
          if (state is LoadingGetServiceDataState) {
            return const Center(
              child: CustomCircularProgressIndicator(),
            );
          } else if (state is FailureGetServiceDataState) {
            return CustomNoInternetAndErrorView(
              onTryAgainButton: () {
                BlocProvider.of<ServiceBookingCubit>(context)
                    .getAllBookingServiceData(context);
              },
            );
          } else if (state is SuccessGetServiceDataState) {
            if (state.serviceBookingData.isEmpty) {
              return CustomNoDataPage(
                message: S.of(context).no_bookings,
              );
            }
            return ListView.separated(
              separatorBuilder: (context, index) => SizedBox(
                height: 10.h,
              ),
              itemCount: state.serviceBookingData.length,
              itemBuilder: (context, index) => CustomDataContainer(
                title: state.serviceBookingData[index].serviceTitle ?? "",
                onTap: () {
                  Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (context) => BookingDetailsPage(
                        bookingId: state.serviceBookingData[index].id ?? -1,
                        typeToggle: TypeToggle.service,
                      ),
                    ),
                  ).then((value) {
                    if (value == "success") {
                      BlocProvider.of<ServiceBookingCubit>(context)
                          .getAllBookingServiceData(context);
                    }
                  });
                  ;
                },
                amount: state.serviceBookingData[index].totalPrice ?? -1,
                categoryTitle:
                    state.serviceBookingData[index].categoryTitle ?? 'error',
                id: state.serviceBookingData[index].id ?? -1,
                status: state.serviceBookingData[index].status ?? 'error',
              ),
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
