import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:sahab_project/core/enums/type_post_enum.dart';
import 'package:sahab_project/core/theme/app_color.dart';
import 'package:sahab_project/core/utils/widgets/circular_progress_indicator.dart';
import 'package:sahab_project/core/utils/widgets/custom_no_internet_and_error_view.dart';
import 'package:sahab_project/core/utils/widgets/custom_simple_app_bar_widget.dart';
import 'package:sahab_project/core/utils/widgets/custom_two_button.dart';
import 'package:sahab_project/feature/Bookings/presentation/views/widgets/no_booking_page.dart';
import 'package:sahab_project/feature/reservations/presentation/manager/place_reservation_cubit/place_reservation_cubit.dart';
import 'package:sahab_project/feature/reservations/presentation/manager/service_reservation_cubit/service_reservation_cubit.dart';
import 'package:sahab_project/feature/reservations/presentation/manager/toggle_reservation_cubit/toggle_reservation_cubit.dart';
import 'package:sahab_project/feature/reservations/presentation/view/pages/reservation_details_page.dart';
import 'package:sahab_project/feature/reservations/presentation/view/widgets/reservation_data_container.dart';

import '../../../../../generated/l10n.dart';

class ReservationsViewBody extends StatelessWidget {
  const ReservationsViewBody({super.key});
// todo : finish translate
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomSimpleAppBarWidget(
          appBarTitle: S.of(context).reservation,
        ),
        SizedBox(
          height: 30.h,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: BlocBuilder<ToggleReservationCubit, ToggleReservationState>(
            builder: (context, state) {
              return CustomTwoButton(
                buttonColor1: state is PlaceReservationPageState
                    ? AppColor.blueColor
                    : AppColor.stepColor,
                buttonColor2: state is ServiceReservationPageState
                    ? AppColor.blueColor
                    : AppColor.stepColor,
                text1: S.of(context).places,
                text2: S.of(context).services,
                textColor1: AppColor.whiteColor,
                textColor2: AppColor.whiteColor,
                onTap1: () {
                  BlocProvider.of<ToggleReservationCubit>(context)
                      .togglePlaceService(TypeToggle.place);
                },
                onTap2: () {
                  BlocProvider.of<ToggleReservationCubit>(context)
                      .togglePlaceService(TypeToggle.service);
                },
              );
            },
          ),
        ),
        // SizedBox(
        //   height: 21.h,
        // ),
        BlocBuilder<ToggleReservationCubit, ToggleReservationState>(
          builder: (context, state) {
            if (state is ServiceReservationPageState) {
              return const ServiceReservationListView();
            } else if (state is PlaceReservationPageState) {
              return const PlaceReservationListView();
            } else {
              return const SizedBox();
            }
          },
        )
      ],
    );
  }
}

class ServiceReservationListView extends StatelessWidget {
  const ServiceReservationListView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: BlocBuilder<ServiceReservationCubit, ServiceReservationState>(
        builder: (context, state) {
          if (state is LoadingGetReservationServiceDataState) {
            return const Center(
              child: CustomCircularProgressIndicator(),
            );
          } else if (state is FailureGetReservationServiceDataState) {
            return CustomNoInternetAndErrorView(
              onTryAgainButton: () {
                BlocProvider.of<ServiceReservationCubit>(context)
                    .getAllBookingServiceData(context);
              },
            );
          } else if (state is SuccessGetReservationServiceDataState) {
            if (state.serviceReservationData.isEmpty) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: CustomNoDataPage(message: "There is no reservations"),
              );
            }
            return ListView.builder(
              itemCount: state.serviceReservationData.length,
              itemBuilder: (context, index) {
                String bookingDate = DateFormat("dd/MM/yyyy", "en").format(
                    state.serviceReservationData[index].startingDate ??
                        DateTime.now());

                String firsRangeTime = state
                        .serviceReservationData[index].startingDate?.hour
                        .toString() ??
                    "";
                String secondRangeTime = state
                        .serviceReservationData[index].endingDate?.hour
                        .toString() ??
                    "";
                String bookingTime = "$firsRangeTime - $secondRangeTime";

                return Padding(
                  padding:
                      EdgeInsets.only(bottom: 20.h, left: 16.w, right: 16.w),
                  child: ReservationDataContainer(
                    onTap: () {
                      Navigator.of(context)
                          .push(
                        CupertinoPageRoute(
                          builder: (context) => ReservationDetailsPage(
                            id: state.serviceReservationData[index].id ?? -1,
                            typeToggle: TypeToggle.service,
                          ),
                        ),
                      )
                          .then((value) {
                        if (value == "success")
                          BlocProvider.of<ServiceReservationCubit>(context)
                              .getAllBookingServiceData(context);
                      });
                    },
                    date1: bookingDate,
                    date2: bookingTime,
                    typeToggle: TypeToggle.service,
                    title:
                        state.serviceReservationData[index].serviceTitle ?? "",
                    amount:
                        state.serviceReservationData[index].totalPrice ?? 0.0,
                    categoryTitle:
                        state.serviceReservationData[index].categoryTitle ?? "",
                    id: state.serviceReservationData[index].id ?? -1,
                    status:
                        state.serviceReservationData[index].status ?? "null",
                  ),
                );
              },
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}

class PlaceReservationListView extends StatelessWidget {
  const PlaceReservationListView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: BlocBuilder<PlaceReservationCubit, PlaceReservationState>(
        builder: (context, state) {
          if (state is LoadingGetReservationPlaceDataState) {
            return const Center(
              child: CustomCircularProgressIndicator(),
            );
          } else if (state is FailureGetReservationPlaceDataState) {
            return CustomNoInternetAndErrorView(
              onTryAgainButton: () {
                BlocProvider.of<PlaceReservationCubit>(context)
                    .getAllBookingPlaceData(context);
              },
            );
          } else if (state is SuccessGetReservationPlaceDataState) {
            if (state.placeReservationData.isEmpty) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: CustomNoDataPage(
                    message: S.of(context).there_is_no_reservations),
              );
            }
            return ListView.builder(
              itemCount: state.placeReservationData.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding:
                      EdgeInsets.only(bottom: 20.h, left: 16.w, right: 16.w),
                  child: ReservationDataContainer(
                    onTap: () {
                      Navigator.of(context)
                          .push(
                        CupertinoPageRoute(
                          builder: (context) => ReservationDetailsPage(
                            id: state.placeReservationData[index].id ?? -1,
                            typeToggle: TypeToggle.place,
                          ),
                        ),
                      )
                          .then((value) {
                        if (value == "success")
                          BlocProvider.of<PlaceReservationCubit>(context)
                              .getAllBookingPlaceData(context);
                      });
                    },
                    date1: DateFormat("dd/MM/yyyy", "en").format(
                        state.placeReservationData[index].startingDate ??
                            DateTime.now()),
                    date2: DateFormat("dd/MM/yyyy", "en").format(
                        state.placeReservationData[index].endingDate ??
                            DateTime.now()),
                    typeToggle: TypeToggle.place,
                    title:
                        state.placeReservationData[index].placeTitle ?? "null",
                    amount: state.placeReservationData[index].totalPrice ?? 0.0,
                    categoryTitle:
                        state.placeReservationData[index].categoryTitle ??
                            "null",
                    id: state.placeReservationData[index].id ?? -1,
                    status: state.placeReservationData[index].status ?? "null",
                  ),
                );
              },
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
