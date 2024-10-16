import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sahab_project/core/theme/app_textsyle.dart';
import 'package:sahab_project/core/utils/widgets/custom_back_button.dart';
import 'package:sahab_project/core/utils/widgets/custom_simple_app_bar_widget.dart';
import 'package:sahab_project/feature/auth/presentation/manager/cubit/login_cubit/cubit/login_cubit.dart';
import 'package:sahab_project/feature/auth/presentation/manager/cubit/otp_cubit/otp_cubit.dart';
import '../../../../../core/utils/icons/app_icons.dart';
import '../../../../../core/theme/app_color.dart';
import '../../../../../core/utils/widgets/app_button.dart';
import '../../../../../core/utils/widgets/app_text.dart';
import '../../../../../generated/l10n.dart';
import '../../widgets/otb_text_widget.dart';
import '../../widgets/otp_dont_get_code_widget.dart';
import '../../widgets/otp_form_text_widget.dart';
import '../../widgets/timer_widget.dart';

class OTPScreen extends StatefulWidget {
  OTPScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  var formKey = GlobalKey<FormState>();

  FocusNode focusNod1e1 = FocusNode();

  FocusNode focusNod1e2 = FocusNode();

  FocusNode focusNod1e3 = FocusNode();

  FocusNode focusNod1e4 = FocusNode();

  @override
  Widget build(BuildContext context) {
    OtpCubit otpCubit = OtpCubit.get(context);
    return WillPopScope(
      onWillPop: () => otpCubit.otpInitial(),
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CustomSimpleAppBarWidget(
                appBarTitle: "OTP",
                onIconTap: () {
                  otpCubit.otpInitialInIcon(context);
                },
              ),
              // Padding(
              //   padding: EdgeInsetsDirectional.only(start: 16.w, top: 41.h),
              //   child: Row(
              //     children: [
              //       Padding(
              //         padding: const EdgeInsets.all(00),
              //         child: CustomBackButton(
              //           onTap: () {
              //             // otpCubit.otpInitialInIcon(context);
              //           },
              //           iconPath: AppIcons.backArrow,
              //         ),
              //       ),
              //       SizedBox(
              //         width: 8.w,
              //       ),
              //       Expanded(
              //         child: Text(
              //           'OTP',
              //           style: AppStyles.textStyle16w400DarkBlue(context)
              //               .copyWith(color: Colors.black),
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
              SizedBox(
                height: 102.h,
              ),
              Padding(
                padding: EdgeInsetsDirectional.only(start: 16.w),
                child: SvgPicture.asset(
                  AppIcons.combined_shape,
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.only(start: 16.w),
                child: OTBTextWidget(
                  numberText: BlocProvider.of<LoginCubit>(context)
                      .numberController
                      .text,
                  //? --- We have sent an OTP to Mobile number ---
                  firstText: S.of(context).first_OTP_message,
                  //? --------------------------------------------
                  //? --- Please enter the code received ---------
                  secondText: S.of(context).second_OTP_message,
                  //? --------------------------------------------
                  thirdText: S.of(context).below,
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.only(start: 16.w),
                child: OTPFormTextWidget(
                  first: otpCubit.first, //authBloc.first,
                  second: otpCubit.second, //authBloc.second,
                  third: otpCubit.third, //authBloc.third,
                  fourth: otpCubit.fourth, //authBloc.forth,
                  focusNode1: focusNod1e1,
                  focusNode2: focusNod1e2,
                  focusNode3: focusNod1e3,
                  focusNode4: focusNod1e4,
                ),
              ),
              Form(
                key: formKey,
                child: Column(
                  children: [
                    SizedBox(
                      height: 16.h,
                    ),
                    BlocBuilder<OtpCubit, OtpState>(
                      builder: (context, state) {
                        if (state is OtpFailure) {
                          return Center(
                            child: AppText(
                                //   --- OTP code entered is wrong. Try Again! --
                                text: S.of(context).OTP_error_message,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w400,
                                color: const Color(0xffBF0000)),
                          );
                        } else {
                          return const SizedBox();
                        }
                      },
                    ),
                    SizedBox(
                      height: 16.h,
                    ),
                    BlocBuilder<OtpCubit, OtpState>(
                      builder: (context, state) {
                        return TimerWidget(
                          seconds: otpCubit.timerSeconds,
                          otpCubit: otpCubit,
                        );
                      },
                    ),
                    SizedBox(
                      height: 89.h,
                    ),
                    BlocBuilder<OtpCubit, OtpState>(
                      builder: (context, state) {
                        if (state is OtpTimerFished || state is OtpFailure) {
                          return Center(
                            child: OTPDoNotGetCodeWidget(
                              onTap: () {
                                otpCubit.reSendOtp(context);
                              },
                            ),
                          );
                        } else {
                          return const SizedBox();
                        }
                      },
                    ),
                    SizedBox(
                      height: 72.h,
                    ),

                    /// button
                    BlocConsumer<OtpCubit, OtpState>(
                      listener: (context, state) {},
                      builder: (context, state) {
                        return Padding(
                          padding:
                              EdgeInsetsDirectional.symmetric(horizontal: 16.w),
                          child: AppButton(
                            width: double.infinity,
                            height: 50.h,
                            onTap: () async {
                              String otp = otpCubit.first.text +
                                  otpCubit.second.text +
                                  otpCubit.third.text +
                                  otpCubit.fourth.text;
                              await otpCubit.loginWithOtp(context, otp);
                            },
                            text: S.of(context).Verify,
                            color: AppColor.blueColor,
                            radius: 5.r,
                            fontSize: 16.sp,
                            textColor: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        );
                      },
                    ),
                    SizedBox(
                      height: 30.h,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
