import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sahab_project/core/theme/app_color.dart';

class CustomBackButton extends StatelessWidget {
  const CustomBackButton({
    super.key,
    required this.onTap,
    required this.iconPath,
  });
  final void Function() onTap;
  final String iconPath;
  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 7,
      borderRadius: BorderRadius.circular(
        15,
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(
          15,
        ),
        child: Container(
          height: 30,
          width: 30,
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
              15,
            ),
          ),
          child: SvgPicture.asset(
            iconPath,

            // fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
