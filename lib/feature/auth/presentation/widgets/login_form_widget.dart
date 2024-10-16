import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sahab_project/core/notifiction/notification_cubit/notification_cubit.dart';
import 'package:sahab_project/core/theme/app_textsyle.dart';
import 'package:sahab_project/core/utils/functions/function.dart';
import 'package:sahab_project/core/utils/widgets/circular_progress_indicator.dart';
import 'package:sahab_project/feature/account/presentation/manager/account_cubit/account_cubit.dart';
import 'package:sahab_project/feature/account/presentation/view/pages/terams_screen.dart';
import 'package:sahab_project/feature/account/presentation/view/pages/terms_condition.dart';
import 'package:sahab_project/feature/auth/presentation/manager/cubit/login_cubit/cubit/login_cubit.dart';
import 'package:sahab_project/feature/auth/presentation/manager/cubit/register_cubit/register_cubit.dart';
import 'package:sahab_project/feature/auth/presentation/pages/login/login_screen.dart';
import 'package:sahab_project/feature/auth/presentation/pages/otp/otp_screen.dart';
import 'package:sahab_project/feature/boarding/presentation/manager/lang_cubit/lang_cubit.dart';
import 'package:sahab_project/feature/home/presentation/pages/home_page_view.dart';

import '../../../../core/theme/app_color.dart';
import '../../../../core/utils/widgets/app_button.dart';
import '../../../../core/utils/widgets/app_text.dart';
import '../../../../generated/l10n.dart';

class LoginFormWidget extends StatelessWidget {
  LoginFormWidget({
    Key? key,
    required this.hintText,
    // required this.fontFamily,
    required this.buttonWidth,
    required this.buttonText,
    required this.validator,
  }) : super(key: key);

  String hintText;
  // String fontFamily;
  double buttonWidth;
  String buttonText;
  String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    LoginCubit loginCubit = LoginCubit.get(context);
    return Form(
      key: loginCubit.loginFormKey,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsetsDirectional.only(end: 16.w),
            child: TextFormField(
              controller: loginCubit.numberController,
              keyboardType: TextInputType.number,
              maxLength: 8,
              onTapOutside: (event) {
                FocusManager.instance.primaryFocus?.unfocus();
              },
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
              ],
              decoration: InputDecoration(
                  contentPadding:
                      EdgeInsetsDirectional.only(bottom: 2.h, start: 16.w),
                  border: InputBorder.none,
                  fillColor: const Color(0xffFFFFFF),
                  filled: true,
                  hintText: hintText,
                  errorStyle: AppStyles.style12(context)
                      .copyWith(color: AppColor.redColor),
                  hintStyle: TextStyle(
                    fontFamily: AppFunction.checkFamilyFont(context),
                    fontSize: 12.sp,
                    color: const Color(0xff7B7B7B),
                    fontWeight: FontWeight.w400,
                  )),
              validator: validator,
            ),
          ),
          SizedBox(
            height: 34.h,
          ),
          Padding(
            padding: const EdgeInsetsDirectional.only(end: 16),
            child: BlocConsumer<LoginCubit, LoginState>(
              listener: (context, state) {
                if (state is LoginSuccess) {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => OTPScreen(),
                    ),
                  );
                }
              },
              builder: (context, state) {
                if (state is LoginLoading) {
                  return const CustomCircularProgressIndicator();
                }
                return AppButton(
                    width: buttonWidth,
                    height: 50.h,
                    onTap: () async {
                      await loginCubit.sendOtp();
                    },
                    text: buttonText,
                    color: AppColor.blueColor,
                    radius: 5.r,
                    fontSize: 16.sp,
                    // fontFamily: fontFamily,
                    textColor: const Color(0xffFFFFFF),
                    fontWeight: FontWeight.w600);
              },
            ),
          )
        ],
      ),
    );
  }
}

// ignore: must_be_immutable
class RegisterFormWidget extends StatelessWidget {
  RegisterFormWidget({
    Key? key,
    required this.hintText,
    // required this.fontFamily,
    required this.buttonWidth,
    required this.buttonText,
    required this.validatorName,
    required this.validatorEmail,
    // required this.en,
    // required this.lang,
  }) : super(key: key);

  String hintText;
  // String fontFamily;
  double buttonWidth;
  String buttonText;
  // String lang;
  String? Function(String?)? validatorName;
  String? Function(String?)? validatorEmail;
  // bool en;

  @override
  Widget build(BuildContext context) {
    RegisterCubit registerCubit = RegisterCubit.get(context);
    return Form(
      key: registerCubit.registererFormKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// name
          AppText(
              text: S.of(context).full_name,
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
              color: AppColor.brownColor),
          SizedBox(
            height: 7.h,
          ),
          TextFormField(
            controller: registerCubit.name,
            keyboardType: TextInputType.name,
            decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding:
                    const EdgeInsetsDirectional.only(bottom: 4, start: 16),
                fillColor: const Color(0xffFFFFFF),
                filled: true,
                hintText: hintText,
                errorStyle: AppStyles.style12(context)
                    .copyWith(color: AppColor.redColor),
                hintStyle: TextStyle(
                  fontFamily: AppFunction.checkFamilyFont(context),
                  fontSize: 12.sp,
                  color: const Color(0xff7B7B7B),
                  fontWeight: FontWeight.w400,
                )),
            validator: validatorName,
          ),
          SizedBox(
            height: 32.h,
          ),

          /// email
          AppText(
              text: S.of(context).email,
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
              color: AppColor.brownColor),
          const SizedBox(
            height: 7,
          ),
          TextFormField(
            controller: registerCubit.email,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
                border: InputBorder.none,
                fillColor: const Color(0xffFFFFFF),
                filled: true,
                hintText: hintText,
                errorStyle: AppStyles.style12(context)
                    .copyWith(color: AppColor.redColor),
                hintStyle: TextStyle(
                  fontFamily: AppFunction.checkFamilyFont(context),
                  fontSize: 12.sp,
                  color: const Color(0xff7B7B7B),
                  fontWeight: FontWeight.w400,
                )),
            validator: validatorEmail,
          ),
          SizedBox(
            height: 25.h,
          ),
          Row(
            children: [
              AppText(
                  text: S.of(context).by_continuing_you_agree_to_sahab,
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xff797979)),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TermsCondition(),
                      ));
                },
                child: AppText(
                    text: S.of(context).terms_conditions,
                    fontSize: 11.sp,
                    decoration: TextDecoration.underline,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xff000000)),
              ),
              AppText(
                  text: S.of(context).and,
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xff797979)),
            ],
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TermsScreen(),
                  ));
            },
            child: AppText(
                text: S.of(context).privacy_policy,
                fontSize: 11.sp,
                decoration: TextDecoration.underline,
                fontWeight: FontWeight.w600,
                color: const Color(0xff000000)),
          ),
          const SizedBox(
            height: 25,
          ),

          Padding(
            padding: EdgeInsetsDirectional.zero,
            child: BlocConsumer<RegisterCubit, RegisterState>(
              listener: (context, state) {
                if (state is RegisterSuccess) {
                  // Show dialog on successful registration
                  AppFunction.confirmDialog(
                    context,
                    title: S.of(context).success,
                    text1: S.of(context).account_has_been_registered,
                    onYesTap: () {
                      BlocProvider.of<NotificationCubit>(context)
                          .sendNotificationToken();

                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const HomePageView()),
                        (route) => false,
                      );
                    },
                  );
                  // showDialog(
                  //     context: context,
                  //     builder: (context) {
                  //       return AlertDialog(
                  //         backgroundColor: AppColor.whiteColor,
                  //         shape: RoundedRectangleBorder(
                  //             borderRadius: BorderRadius.circular(5)),
                  //         title: Text(
                  //           "Success",
                  //           style: AppStyles.style16(context).copyWith(
                  //               color: AppColor.darkBlueColor,
                  //               fontWeight: FontWeight.w600),
                  //         ),
                  //         content: Text(
                  //           "Account has been registered!",
                  //           style: AppStyles.style14(context)
                  //               .copyWith(color: AppColor.brownColor),
                  //         ),
                  //         actions: [
                  //           Row(
                  //             mainAxisAlignment: MainAxisAlignment.end,
                  //             children: [
                  //               TextButton(
                  //                 onPressed: () async {
                  //                   Navigator.pushAndRemoveUntil(
                  //                     context,
                  //                     MaterialPageRoute(
                  //                         builder: (context) =>
                  //                             const HomePageView()),
                  //                     (route) => false,
                  //                   );
                  //                 },
                  //                 child: Container(
                  //                   width: 73.w,
                  //                   height: 40.h,
                  //                   decoration: ShapeDecoration(
                  //                     color: const Color(0xFF567AB8),
                  //                     shape: RoundedRectangleBorder(
                  //                       borderRadius: BorderRadius.circular(5),
                  //                     ),
                  //                   ),
                  //                   child: Center(
                  //                     child: Text(
                  //                       "Ok",
                  //                       style:
                  //                           AppStyles.style16(context).copyWith(
                  //                         fontWeight: FontWeight.w600,
                  //                         color: AppColor.whiteColor,
                  //                       ),
                  //                     ),
                  //                   ),
                  //                 ),
                  //               )
                  //             ],
                  //           )
                  //         ],
                  //       );
                  //     });
                  registerCubit.email.clear();
                  registerCubit.name.clear();
                } else if (state is RegisterError) {
                  AppFunction.confirmDialog(
                    context,
                    title: S.of(context).general_error,
                    onYesTap: () {
                      Navigator.of(context).pop();
                    },
                  );
                  // showDialog(
                  //   context: context,
                  //   builder: (context) {
                  //     return AlertDialog(
                  //       title: Text(state.errMessage),
                  //     );
                  //   },
                  // );
                }
              },
              builder: (context, state) {
                if (state is RegisterLoading) {
                  return const CustomCircularProgressIndicator();
                }
                return AppButton(
                    width: buttonWidth,
                    height: 50.h,
                    onTap: () {
                      registerCubit.register(context);
                    },
                    text: buttonText,
                    color: AppColor.blueColor,
                    radius: 5.r,
                    fontSize: 16.sp,
                    // fontFamily: fontFamily,
                    textColor: const Color(0xffFFFFFF),
                    fontWeight: FontWeight.w600);
              },
            ),
          )
        ],
      ),
    );
  }
}
