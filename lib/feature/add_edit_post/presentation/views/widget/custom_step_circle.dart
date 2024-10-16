import 'package:flutter/material.dart';

import '../../../../../core/theme/app_color.dart';

class CustomStepCircle extends StatelessWidget {
  const CustomStepCircle({
    super.key,
    this.color = AppColor.blueColor,
  });
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          height: 7,
          width: 7,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        Container(
          height: 27,
          width: 27,
          decoration: BoxDecoration(
            // color: AppColor.blueColor,
            shape: BoxShape.circle,
            border: Border.all(
              width: 2,
              color: color,
            ),
          ),
        ),
      ],
    );
  }
}
