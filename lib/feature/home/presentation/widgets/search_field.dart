import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sahab_project/core/theme/app_color.dart';
import 'package:sahab_project/core/theme/app_textsyle.dart';
import 'package:sahab_project/core/utils/icons/app_icons.dart';

class SearchField extends StatelessWidget {
  const SearchField({
    super.key,
    required this.hintText,
    required this.controller,
    this.onFieldSubmitted,
  });
  final String hintText;
  final TextEditingController controller;
  final void Function(String)? onFieldSubmitted;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTapOutside: (event) {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      controller: controller,
      cursorColor: AppColor.darkBlueColor,
      onFieldSubmitted: onFieldSubmitted,
      decoration: InputDecoration(
        suffixIcon: Container(
          margin: const EdgeInsets.all(12),
          child: SvgPicture.asset(
            AppIcons.search,
            height: 22,
            width: 22,
          ),
        ),
        hintText: hintText,
        hintStyle: AppStyles.style14(context).copyWith(
            fontWeight: FontWeight.w300, color: AppColor.greyHintColor),
        contentPadding: EdgeInsets.symmetric(
          vertical: 0,
          horizontal: 20.w,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide:
              const BorderSide(color: AppColor.borderSearchColor, width: 2),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide:
              const BorderSide(color: AppColor.borderSearchColor, width: 1),
        ),
      ),
    );
  }
}
