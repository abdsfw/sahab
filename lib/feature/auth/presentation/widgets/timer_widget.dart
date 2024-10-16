import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sahab_project/feature/auth/presentation/manager/cubit/otp_cubit/otp_cubit.dart';
import 'package:timer_count_down/timer_count_down.dart';

class TimerWidget extends StatelessWidget {
  TimerWidget({
    Key? key,
    required this.seconds,
    required this.otpCubit,
  }) : super(key: key);
  int seconds;

  final OtpCubit otpCubit;
  @override
  Widget build(BuildContext context) {
    print("object");
    return Padding(
      padding: EdgeInsetsDirectional.only(end: 16.w),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              BlocBuilder<OtpCubit, OtpState>(
                builder: (context, state) {
                  return Countdown(
                    seconds: otpCubit.timerSeconds,
                    build: (BuildContext context, double time) {
                      print(time);
                      int minutes = time ~/ 60;
                      double secondsD = time % 60;
                      int seconds = secondsD.toInt();
                      String timeDown =
                          "${minutes.toString().padLeft(2, "0")}:${seconds.toString().padLeft(2, "0")}";
                      return Text("( $timeDown )");
                    },
                    interval: const Duration(seconds: 1),
                    controller: otpCubit.timerController..start(),
                    onFinished: otpCubit.timerFished,
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
