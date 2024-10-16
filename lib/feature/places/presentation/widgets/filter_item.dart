import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sahab_project/core/theme/app_color.dart';
import 'package:sahab_project/core/theme/app_textsyle.dart';

class FilterListItem extends StatelessWidget {
  final String title;
  final int value;
  final int groupValue;
  final Function(int?) onChanged;

  const FilterListItem({
    Key? key,
    required this.title,
    required this.value,
    required this.groupValue,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onChanged(value);
      },
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Row(
          children: [
            Expanded(
              child: Text(
                title,
                style: AppStyles.style16(context).copyWith(color: Colors.black),
              ),
            ),
            Radio(
              activeColor: AppColor.blueColor,
              value: value,
              groupValue: groupValue,
              onChanged: onChanged,
            ),
          ],
        ),
      ),
    );
    // ListTile(
    //   title: Text(
    //     title,
    //     style: AppStyles.style16(context).copyWith(color: Colors.black),
    //   ),
    //   trailing: Radio(
    //     activeColor: AppColor.blueColor,
    //     value: value,
    //     groupValue: groupValue,
    //     onChanged: onChanged,
    //   ),
    // );
  }
}
