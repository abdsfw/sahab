import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sahab_project/core/theme/app_textsyle.dart';
import 'package:sahab_project/feature/Bookings/presentation/manager/rating_cubit/rating_cubit.dart';

class CustomRatingButton extends StatelessWidget {
  const CustomRatingButton({
    super.key,
    this.onTap,
    required this.path,
    // required this.path2,
    required this.color,
    // required this.color2,
    required this.title,
    this.topStart = Radius.zero,
    this.bottomStart = Radius.zero,
    this.bottomEnd = Radius.zero,
    this.topEnd = Radius.zero,
  });
  final void Function()? onTap;
  final String path;
  // final String path2;
  final Color color;
  // final Color color2;
  final Radius topStart;
  final Radius bottomStart;
  final Radius bottomEnd;
  final Radius topEnd;
  final String title;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Column(
          children: [
            Image(
              image: AssetImage(path),
            ),
            SizedBox(
              height: 20.h,
            ),
            Container(
              height: 18.h,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadiusDirectional.only(
                  topStart: topStart,
                  bottomStart: bottomStart,
                  bottomEnd: bottomEnd,
                  topEnd: topEnd,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsetsDirectional.only(top: 5),
              child: Text(
                title,
                style: AppStyles.textStyle15w400Black(context),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
