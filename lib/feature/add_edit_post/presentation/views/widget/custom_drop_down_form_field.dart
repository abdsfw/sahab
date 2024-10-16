import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../core/theme/app_color.dart';
import '../../../../../core/theme/app_textsyle.dart';
import '../../../../../core/utils/icons/app_icons.dart';

class CustomDropDownFormField extends StatelessWidget {
  const CustomDropDownFormField({
    super.key,
    required this.hintText,
    required this.listItem,
    this.onChanged,
    this.validator,
    this.value,
  });
  final String hintText;
  final List<dynamic> listItem;
  final void Function(String?)? onChanged;
  final String? Function(String?)? validator;
  final String? value;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColor.whiteColor,
        borderRadius: BorderRadius.circular(
          5,
        ),
      ),
      child: DropdownButtonFormField(
        value: value,
        validator: validator,
        borderRadius: BorderRadius.circular(
          5,
        ),
        style: AppStyles.textStyle14w500DarkBlue(context),
        items: listItem
            .map(
              (e) => DropdownMenuItem(
                value: e.toString(),
                child: Text(e.toString()),
              ),
            )
            .toList(),
        onChanged: onChanged,
        icon: SvgPicture.asset(AppIcons.dropDownIcon),
        decoration: InputDecoration(
          errorStyle: AppStyles.textStyle14w400GreyHint(context).copyWith(
            color: AppColor.redColor,
          ),
          hintText: hintText,
          hintStyle: AppStyles.textStyle14w500DarkBlue(context),
          contentPadding: EdgeInsets.symmetric(
            vertical: 0,
            horizontal: 20.w,
          ),

          // enabledBorder: null,
          // (!withoutFocusedBorder)
          //     ? OutlineInputBorder(
          //         borderRadius: BorderRadius.circular(5),
          //         borderSide: const BorderSide(
          //             color: AppColor.borderSearchColor, width: 2),
          //       )
          //     : null,
          border: const OutlineInputBorder(borderSide: BorderSide.none),
        ),
      ),
    );
  }
}
