import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sahab_project/core/const.dart';
import 'package:sahab_project/core/theme/app_color.dart';
import 'package:sahab_project/core/theme/app_textsyle.dart';
import 'package:sahab_project/core/utils/cache/cache_helper.dart';
import 'package:sahab_project/core/utils/widgets/circular_progress_indicator.dart';
import 'package:sahab_project/core/utils/widgets/custom_simple_app_bar_widget.dart';
import 'package:sahab_project/feature/account/presentation/manager/static_page_cubit/static_page_cubit.dart';

import '../../../../../generated/l10n.dart';

class AboutSahabScreen extends StatelessWidget {
  const AboutSahabScreen({super.key});
// todo : finish translate
  @override
  Widget build(BuildContext context) {
    StaticPageCubit staticPageCubit = StaticPageCubit.get(context);
    String title = CacheHelper.getData(key: Constant.kLang) == 'ar'
        ? "about_ar"
        : "about_en";
    staticPageCubit.getStaticPage(title);
    return Scaffold(
      backgroundColor: AppColor.pageBackGround,
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          CustomSimpleAppBarWidget(appBarTitle: S.of(context).about_sahab),
          SizedBox(height: 41.h),
          Container(
            width: 361,
            height: 180.50,
            margin: EdgeInsets.symmetric(horizontal: 16.w),
            decoration: ShapeDecoration(
              color: const Color(0xFF5679B6),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: Center(
              child: AspectRatio(
                  aspectRatio: 2,
                  child: Image.asset(
                    Constant.kLogoImage,
                  )),
            ),
          ),
          SizedBox(height: 13.h),
          BlocBuilder<StaticPageCubit, StaticPageState>(
            builder: (context, state) {
              if (state is StaticPageLoading) {
                return CustomCircularProgressIndicator();
              } else {
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Text(
                    staticPageCubit.contentPage,
                    style: AppStyles.style16(context).copyWith(height: 2),
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
