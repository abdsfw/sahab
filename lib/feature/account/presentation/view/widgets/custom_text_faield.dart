import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sahab_project/core/theme/app_color.dart';
import 'package:sahab_project/core/theme/app_textsyle.dart';

class TextForEditScreen extends StatelessWidget {
  const TextForEditScreen({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.only(start: 16.w),
      child: Text(text, style: AppStyles.style14semibold(context)),
    );
  }
}

class CustomTextInput extends StatelessWidget {
  final String hintText;
  final TextInputType keyboardType;
  final TextEditingController textEditingController;
  const CustomTextInput({
    super.key,
    required this.hintText,
    this.keyboardType = TextInputType.text,
    required this.textEditingController,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.symmetric(horizontal: 16.w),
      child: TextFormField(
        controller: textEditingController,
        keyboardType: keyboardType,
        style: AppStyles.style12(context)
            .copyWith(color: AppColor.greyColor, fontWeight: FontWeight.w400),
        decoration: InputDecoration(
          contentPadding:
              EdgeInsets.symmetric(vertical: 12.h, horizontal: 20.w),
          filled: true,
          fillColor: Colors.white,
          border: InputBorder.none,
          hintText: hintText,
          hintStyle: TextStyle(
            fontSize: 12.sp,
            color: AppColor.greyHintColor,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }
}
