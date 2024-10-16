import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sahab_project/core/theme/app_textsyle.dart';
import 'package:sahab_project/feature/auth/presentation/manager/cubit/otp_cubit/otp_cubit.dart';

// ignore: must_be_immutable
class OTPFormTextWidget extends StatelessWidget {
  OTPFormTextWidget({
    Key? key,
    required this.first,
    required this.second,
    required this.third,
    required this.fourth,
    required this.focusNode1,
    required this.focusNode2,
    required this.focusNode3,
    required this.focusNode4,
  }) : super(key: key);

  TextEditingController first;
  TextEditingController second;
  TextEditingController third;
  TextEditingController fourth;
  FocusNode focusNode1;
  FocusNode focusNode2;
  FocusNode focusNode3;
  FocusNode focusNode4;

  @override
  Widget build(BuildContext context) {
    OtpCubit otpCubit = OtpCubit.get(context);
    return Form(
      key: otpCubit.otpFormKey,
      child: Row(
        children: [
          ///first
          Container(
            width: 73.w,
            height: 73.w,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(10)),
            child: TextFormField(
              buildCounter: (
                context, {
                required int currentLength,
                required bool isFocused,
                required int? maxLength,
              }) {
                return const SizedBox();
              },
              controller: first,
              textAlign: TextAlign.center,
              maxLength: 1,
              focusNode: focusNode1,
              onChanged: (value) {
                if (value.isEmpty) {
                } else {
                  focusNode2.requestFocus();
                }
              },
              clipBehavior: Clip.none,
              style: AppStyles.style20(context)
                  .copyWith(fontWeight: FontWeight.w700, color: Colors.black),
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 30.w, vertical: 22.w),
                border: InputBorder.none,
                fillColor: Color(0xffFFFFFF),
              ),
            ),
          ),
          SizedBox(
            width: 23.w,
          ),

          /// second
          Container(
            width: 73.w,
            height: 73.w,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(10)),
            child: TextFormField(
              buildCounter: (context,
                  {required int currentLength,
                  required bool isFocused,
                  required int? maxLength}) {
                return const SizedBox();
              },
              controller: second,
              textAlign: TextAlign.center,
              maxLength: 1,
              focusNode: focusNode2,
              onTap: () {
                if (first.text.isEmpty) {
                  focusNode1.requestFocus();
                }
              },
              onChanged: (value) {
                if (value.isEmpty) {
                } else {
                  focusNode3.requestFocus();
                }
              },
              clipBehavior: Clip.none,
              style: AppStyles.style20(context)
                  .copyWith(fontWeight: FontWeight.w700, color: Colors.black),
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 30.w, vertical: 22.w),
                border: InputBorder.none,
                fillColor: const Color(0xffFFFFFF),
              ),
            ),
          ),
          SizedBox(
            width: 23.w,
          ),

          /// third
          Container(
            width: 73.w,
            height: 73.w,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(10)),
            child: TextFormField(
              buildCounter: (context,
                  {required int currentLength,
                  required bool isFocused,
                  required int? maxLength}) {
                return const SizedBox();
              },
              controller: third,
              textAlign: TextAlign.center,
              maxLength: 1,
              onTap: () {
                if (first.text.isEmpty) {
                  focusNode1.requestFocus();
                } else if (second.text.isEmpty) {
                  focusNode2.requestFocus();
                }
              },
              focusNode: focusNode3,
              onChanged: (value) {
                if (value.isEmpty) {
                } else {
                  focusNode4.requestFocus();
                }
              },
              clipBehavior: Clip.none,
              keyboardType: TextInputType.number,
              style: AppStyles.style20(context)
                  .copyWith(fontWeight: FontWeight.w700, color: Colors.black),
              decoration: InputDecoration(
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 30.w, vertical: 22.w),
                border: InputBorder.none,
                fillColor: const Color(0xffFFFFFF),
              ),
            ),
          ),
          SizedBox(
            width: 23.w,
          ),

          ///forth
          Container(
            width: 73.w,
            height: 73.w,
            margin: EdgeInsets.zero,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(10)),
            child: TextFormField(
              buildCounter: (context,
                  {required int currentLength,
                  required bool isFocused,
                  required int? maxLength}) {
                return const SizedBox();
              },
              controller: fourth,
              textAlign: TextAlign.center,
              maxLength: 1,
              onTap: () {
                if (first.text.isEmpty) {
                  focusNode1.requestFocus();
                } else if (second.text.isEmpty) {
                  focusNode2.requestFocus();
                } else if (third.text.isEmpty) {
                  focusNode3.requestFocus();
                }
              },
              focusNode: focusNode4,
              onChanged: (value) {
                if (value.isEmpty) {
                } else {
                  focusNode4.unfocus();
                }
              },
              clipBehavior: Clip.none,
              style: AppStyles.style20(context)
                  .copyWith(fontWeight: FontWeight.w700, color: Colors.black),
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 30.w, vertical: 22.h),
                border: InputBorder.none,
                fillColor: const Color(0xffFFFFFF),
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return '';
                }
                return null;
              },
            ),
          ),
          // SizedBox(
          //   width: 23.w,
          // ),
        ],
      ),
    );
  }
}
