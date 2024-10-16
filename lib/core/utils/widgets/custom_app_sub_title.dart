import 'package:flutter/material.dart';

import '../../theme/app_textsyle.dart';

class CustomAppSubTitle extends StatelessWidget {
  const CustomAppSubTitle({
    super.key,
    required this.subTitle,
  });
  final String subTitle;
  @override
  Widget build(BuildContext context) {
    return Text(
      subTitle,
      style: AppStyles.textStyle18w500DarkBlue(context),
    );
  }
}
