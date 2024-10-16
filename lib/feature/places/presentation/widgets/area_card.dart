import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sahab_project/core/theme/app_color.dart';
import 'package:sahab_project/core/theme/app_textsyle.dart';
import 'package:sahab_project/core/utils/icons/app_icons.dart';
import 'package:sahab_project/feature/home/presentation/manager/area_cubit/area_cubit.dart';
import 'package:sahab_project/feature/places/presentation/pages/area_page.dart';
import 'package:sahab_project/feature/places/presentation/pages/area_page.dart';

import '../../../../generated/l10n.dart';

class AreaCard extends StatelessWidget {
  const AreaCard({
    super.key,
  });
// todo : finish translate
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 361.w,
      height: 60.h,
      padding: EdgeInsets.symmetric(horizontal: 18.w),
      margin: EdgeInsets.only(left: 16.w, right: 16.w, top: 10.h, bottom: 32.h),
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(5)),
          color: AppColor.borderRadiusColor),
      child: InkWell(
        onTap: () {
          if (BlocProvider.of<AreaCubit>(context).areaList.isEmpty) {
            BlocProvider.of<AreaCubit>(context).getAllArea(context);
          }

          Navigator.of(context).push(
            CupertinoPageRoute(
              builder: (context) => AreaPage(),
            ),
          );
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              S.of(context).area,
              style: AppStyles.style16(context),
            ),
            SvgPicture.asset(AppIcons.arrow)
          ],
        ),
      ),
    );
  }
}
