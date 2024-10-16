import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sahab_project/core/theme/app_textsyle.dart';
import 'package:sahab_project/feature/account/presentation/view/pages/add_post_view.dart';

class PostOption extends StatelessWidget {
  const PostOption({
    super.key,
    required this.color,
    required this.iconPath,
    required this.text,
    this.onTap,
  });
  final Color color;
  final String iconPath;
  final String text;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Column(
          children: [
            CircleAvatar(
              radius: 20,
              backgroundColor: color,
              child: Center(
                child: SvgPicture.asset(
                  iconPath,
                ),
              ),
            ),
            SizedBox(height: 9.h),
            Text(
              text,
              style: AppStyles.style16(context),
            )
          ],
        ),
      ),
    );
  }
}
