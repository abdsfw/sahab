import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sahab_project/core/const.dart';
import 'package:sahab_project/core/theme/app_color.dart';
import 'package:sahab_project/core/theme/app_textsyle.dart';
import 'package:sahab_project/core/utils/cache/cache_helper.dart';
import 'package:sahab_project/core/utils/icons/app_icons.dart';
import 'package:sahab_project/feature/account/presentation/manager/static_value_cubit/static_value_cubit.dart';
import 'package:sahab_project/feature/account/presentation/view/widgets/edit_profile.dart';
import 'package:sahab_project/feature/account/presentation/view/widgets/information_grid_view.dart';
import 'package:sahab_project/feature/account/presentation/view/widgets/my_account.dart';
import 'package:sahab_project/feature/account/presentation/view/widgets/my_account_text.dart';
import 'package:sahab_project/feature/account/presentation/view/widgets/option_widget.dart';
import 'package:sahab_project/feature/reservations/presentation/view/pages/reservations_view.dart';

import '../../../../../generated/l10n.dart';
import '../pages/my_post_view.dart';
import 'setting_option_list.dart';
import 'support_option_list.dart';

class VendorAccountBody extends StatelessWidget {
  const VendorAccountBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsetsDirectional.only(start: 16, end: 16, top: 15),
        child: ListView(
          padding: EdgeInsets.zero,
          clipBehavior: Clip.none,
          children: [
            const MyAccountText(),
            SizedBox(
              height: 27.h,
            ),
            const MyAccount(),
            SizedBox(
              height: 27.h,
            ),
            BlocBuilder<StaticValueCubit, StaticValueState>(
              builder: (context, state) {
                if (state is StaticValueLoading) {
                  return ShimmerGridViewInformationWidget();
                } else {
                  return GridViewInformationWidget();
                }
              },
            ),
            SizedBox(
              height: 31.h,
            ),
            const SettingOptionList(),
            SizedBox(
              height: 11.h,
            ),
            const AccountOptionList(),
            SizedBox(height: 13.h),
            // OptionWidget(
            //   title: "Edit Account",
            //   trailing: SvgPicture.asset(AppIcons.rightArrow),
            //   leadingIcon: AppIcons.logo,
            // ),
            // OptionWidget(
            //   title: "My Post",
            //   trailing: SvgPicture.asset(AppIcons.rightArrow),
            //   leadingIcon: AppIcons.postWrite,
            // ),
            // OptionWidget(
            //   title: "Reservations",
            //   trailing: SvgPicture.asset(AppIcons.rightArrow),
            //   leadingIcon: AppIcons.calendar,
            // ),
            SizedBox(
              height: 11.h,
            ),
            const SupportOptionList(),
            SizedBox(
              height: 13.h,
            ),
            //!here
            Text(
              "Version 1.0.0",
              style: AppStyles.style14Bold(context),
            ),
            SizedBox(
              height: 5.h,
            ),
            Text(
              "Powered By Line  ",
              style: AppStyles.style14(context)
                  .copyWith(color: AppColor.poweredBy),
            ),
            SizedBox(
              height: 19.h,
            ),
          ],
        ),
      ),
    );
  }
}

class AccountOptionList extends StatelessWidget {
  const AccountOptionList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          S.of(context).Account,
          style: AppStyles.style18semibold(context),
        ),
        SizedBox(
          height: 12.h,
        ),
        OptionWidget(
          title: S.of(context).edit_account,
          onTap: () {
            Navigator.push(
                context,
                CupertinoPageRoute(
                  builder: (context) => const EditProfileScreen(),
                ));
          },
          trailing: CacheHelper.getData(key: Constant.kLang) == 'ar'
              ? SvgPicture.asset(
                  AppIcons.left,
                )
              : SvgPicture.asset(AppIcons.rightArrow),
          leadingIcon: AppIcons.logo,
        ),
        OptionWidget(
          title: S.of(context).my_posts,
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const MyPostView(),
            ));
          },
          trailing: CacheHelper.getData(key: Constant.kLang) == 'ar'
              ? SvgPicture.asset(
                  AppIcons.left,
                )
              : SvgPicture.asset(AppIcons.rightArrow),
          leadingIcon: AppIcons.postWrite,
        ),
        OptionWidget(
          title: S.of(context).reservations, //"Reservations",
          onTap: () {
            Navigator.of(context).push(CupertinoPageRoute(
              builder: (context) => ReservationsView(),
            ));
          },
          trailing: CacheHelper.getData(key: Constant.kLang) == 'ar'
              ? SvgPicture.asset(
                  AppIcons.left,
                )
              : SvgPicture.asset(AppIcons.rightArrow),
          leadingIcon: AppIcons.calendar,
        ),
      ],
    );
  }
}
