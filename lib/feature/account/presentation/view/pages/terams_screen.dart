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

class TermsScreen extends StatelessWidget {
  const TermsScreen({super.key});
  // todo : finish translate
  @override
  Widget build(BuildContext context) {
    StaticPageCubit staticPageCubit = StaticPageCubit.get(context);
    String title = CacheHelper.getData(key: Constant.kLang) == 'ar'
        ? "privacy_ar"
        : "privacy_en";
    staticPageCubit.getStaticPage(title);
    // staticPageCubit.getStaticPage("privacy");
    return Scaffold(
      backgroundColor: AppColor.pageBackGround,
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          CustomSimpleAppBarWidget(
            //-- "Terms & Condition",
            appBarTitle: S.of(context).privacy_policy,
          ),
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
                  padding: const EdgeInsets.all(16.0),
                  child: Text(staticPageCubit.contentPage,
                      style: AppStyles.style16(context).copyWith(height: 2)),
                );
              }
            },
          )
        ],
      ),
    );
  }
}
