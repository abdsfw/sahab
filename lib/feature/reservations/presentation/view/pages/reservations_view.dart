import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahab_project/feature/reservations/presentation/manager/place_reservation_cubit/place_reservation_cubit.dart';
import 'package:sahab_project/feature/reservations/presentation/manager/service_reservation_cubit/service_reservation_cubit.dart';
import 'package:sahab_project/feature/reservations/presentation/manager/toggle_reservation_cubit/toggle_reservation_cubit.dart';

import '../widgets/reservations_view_body.dart';

class ReservationsView extends StatelessWidget {
  const ReservationsView({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ToggleReservationCubit(),
        ),
        BlocProvider(
          create: (context) =>
              ServiceReservationCubit()..getAllBookingServiceData(context),
        ),
        BlocProvider(
          create: (context) =>
              PlaceReservationCubit()..getAllBookingPlaceData(context),
        ),
      ],
      child: const Scaffold(
        body: ReservationsViewBody(),
      ),
    );
  }
}
