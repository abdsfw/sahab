import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sahab_project/core/const.dart';
import 'package:sahab_project/core/theme/app_textsyle.dart';
import 'package:sahab_project/core/utils/cache/cache_helper.dart';
import 'package:sahab_project/core/utils/widgets/circular_progress_indicator.dart';
import 'package:sahab_project/core/utils/widgets/custom_simple_app_bar_widget.dart';
import 'package:sahab_project/feature/account/presentation/manager/static_page_cubit/static_page_cubit.dart';
import 'package:sahab_project/generated/l10n.dart';

class TermsCondition extends StatelessWidget {
  const TermsCondition({super.key});

  @override
  Widget build(BuildContext context) {
    StaticPageCubit staticPageCubit = StaticPageCubit.get(context);
    String title = CacheHelper.getData(key: Constant.kLang) == 'ar'
        ? "terms_ar"
        : 'terms_en';
    staticPageCubit.getStaticPage(title);
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          CustomSimpleAppBarWidget(appBarTitle: S.of(context).term_Conditions),
          BlocBuilder<StaticPageCubit, StaticPageState>(
            builder: (context, state) {
              if (state is StaticPageLoading) {
                return Container(
                  height: 600.h,
                  alignment: Alignment.center,
                  child: CustomCircularProgressIndicator(),
                );
              } else {
                return Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.w, vertical: 33.h),
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
