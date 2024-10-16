import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../generated/l10n.dart';
import '../../theme/app_textsyle.dart';
import 'custom_app_title.dart';

class CustomContactDetailsWidget extends StatelessWidget {
  const CustomContactDetailsWidget({
    super.key,
    required this.name,
    required this.phone,
  });
  final String name;
  final String phone;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.only(start: 3),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomAppTitle(
            title: S.of(context).contact_details,
          ),
          SizedBox(height: 7.h),
          Text(
            name,
            style: AppStyles.textstyle16w400Brown(context),
          ),
          SizedBox(height: 11.h),
          Text(
            phone,
            style: AppStyles.textstyle16w400Brown(context),
          ),
        ],
      ),
    );
  }
}
