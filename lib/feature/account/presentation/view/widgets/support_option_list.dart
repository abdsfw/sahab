import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sahab_project/core/const.dart';
import 'package:sahab_project/core/theme/app_textsyle.dart';
import 'package:sahab_project/core/utils/cache/cache_helper.dart';
import 'package:sahab_project/core/utils/icons/app_icons.dart';
import 'package:sahab_project/feature/account/presentation/manager/contact_cubit/contact_cubit.dart';
import 'package:sahab_project/feature/account/presentation/manager/static_page_cubit/static_page_cubit.dart';
import 'package:sahab_project/feature/account/presentation/view/pages/abouat_sahab_view.dart';
import 'package:sahab_project/feature/account/presentation/view/pages/conact_screen.dart';
import 'package:sahab_project/feature/account/presentation/view/pages/terams_screen.dart';
import 'package:sahab_project/feature/account/presentation/view/pages/terms_condition.dart';
import 'package:sahab_project/feature/account/presentation/view/widgets/logout_dialog.dart';
import 'package:sahab_project/feature/account/presentation/view/widgets/option_widget.dart';
import 'package:sahab_project/feature/auth/presentation/pages/login/login_screen.dart';

import '../../../../../generated/l10n.dart';

class SupportOptionList extends StatelessWidget {
  const SupportOptionList({super.key, this.isGuest = false});
  final bool isGuest;
// todo : finish translate
  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      children: [
        Text(
          S.of(context).support,
          style: AppStyles.style18semibold(context),
        ),
        SizedBox(
          height: 12.h,
        ),
        OptionWidget(
          title: S.of(context).about_sahab,
          onTap: () {
            Navigator.push(
              context,
              CupertinoPageRoute(
                builder: (context) => const AboutSahabScreen(),
              ),
            );
          },
          trailing: CacheHelper.getData(key: Constant.kLang) == 'ar'
              ? SvgPicture.asset(
                  AppIcons.left,
                )
              : SvgPicture.asset(AppIcons.rightArrow),
          leadingIcon: AppIcons.logo,
        ),
        OptionWidget(
          title: S.of(context).privacy_policy,
          onTap: () {
            Navigator.push(
                context,
                CupertinoPageRoute(
                  builder: (context) => const TermsScreen(),
                ));
          },
          trailing: CacheHelper.getData(key: Constant.kLang) == 'ar'
              ? SvgPicture.asset(
                  AppIcons.left,
                )
              : SvgPicture.asset(AppIcons.rightArrow),
          leadingIcon: AppIcons.privacy,
        ),
        OptionWidget(
          // ----"Terms & conditions",
          title: S.of(context).Terms_Condition,
          onTap: () {
            Navigator.push(
                context,
                CupertinoPageRoute(
                  builder: (context) => const TermsCondition(),
                ));
          },
          trailing: CacheHelper.getData(key: Constant.kLang) == 'ar'
              ? SvgPicture.asset(
                  AppIcons.left,
                )
              : SvgPicture.asset(AppIcons.rightArrow),
          leadingIcon: AppIcons.terms,
        ),
        OptionWidget(
          title: S.of(context).contacts_us,
          onTap: () {
            ContactCubit contactCubit = ContactCubit.get(context);
            StaticPageCubit staticPageCubit = StaticPageCubit.get(context);
            contactCubit.initTextController();
            staticPageCubit.getAllStaticLink();
            Navigator.push(
                context,
                CupertinoPageRoute(
                  builder: (context) => ContactScreen(),
                ));
          },
          trailing: CacheHelper.getData(key: Constant.kLang) == 'ar'
              ? SvgPicture.asset(
                  AppIcons.left,
                )
              : SvgPicture.asset(AppIcons.rightArrow),
          leadingIcon: AppIcons.contacts,
        ),
        if (!isGuest)
          OptionWidget(
            title: S.of(context).logout,
            onTap: () {
              showDialog(
                context: context,
                builder: (context) {
                  return const LogoutDialog();
                },
              );
            },
            trailing: CacheHelper.getData(key: Constant.kLang) == 'ar'
                ? SvgPicture.asset(
                    AppIcons.left,
                  )
                : SvgPicture.asset(AppIcons.rightArrow),
            leadingIcon: AppIcons.logout,
          ),
      ],
    );
  }
}
