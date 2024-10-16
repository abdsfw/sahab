import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sahab_project/core/theme/app_textsyle.dart';

import '../../theme/app_color.dart';

class CustomInputField extends StatelessWidget {
  const CustomInputField({
    super.key,
    required this.hintText,
    required this.controller,
    this.withoutFocusedBorder = false,
    this.maxLine,
    this.minLine = 1,
    this.onChange,
    this.validator,
    this.inputFormatters,
    this.keyboardType,
  });
  final String hintText;
  final TextEditingController controller;
  final bool withoutFocusedBorder;
  final int? maxLine;
  final int minLine;
  final void Function(String)? onChange;
  final String? Function(String?)? validator;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: EdgeInsets.only(right: 18.w),
      // width: 91.w,
      // height: 200.h,

      decoration: BoxDecoration(
        color: AppColor.whiteColor,
        borderRadius: BorderRadius.circular(
          5,
        ),
      ), //AppColor.backGroundSearchColor,
      child: TextFormField(
        keyboardType: keyboardType,
        validator: validator,
        onChanged: onChange,
        inputFormatters: inputFormatters,
        onTapOutside: (event) {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        // onTapOutside: (event) {
        //   print("hi");
        // },
        onFieldSubmitted: (value) {
          print('hiiiii');
        },
        style: AppStyles.textStyle18w500DarkBlue(context),
        minLines: maxLine,
        maxLines: minLine,
        controller: controller,
        cursorColor: AppColor.darkBlueColor,
        decoration: InputDecoration(
          hintText: hintText,
          errorStyle: AppStyles.textStyle14w400GreyHint(context).copyWith(
            color: AppColor.redColor,
          ),
          hintStyle: AppStyles.textStyle14w400GreyHint(context),
          contentPadding: EdgeInsets.symmetric(
            vertical: 15.h,
            horizontal: 20.w,
          ),
          focusedBorder: (!withoutFocusedBorder)
              ? OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: const BorderSide(
                      color: AppColor.borderSearchColor, width: 2),
                )
              : null,
          border: const OutlineInputBorder(borderSide: BorderSide.none),
        ),
      ),
    );
  }
}
