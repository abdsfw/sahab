import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sahab_project/core/const.dart';
import 'package:sahab_project/core/theme/app_textsyle.dart';
import 'package:sahab_project/core/utils/cache/cache_helper.dart';
import 'package:sahab_project/core/utils/icons/app_icons.dart';
import 'package:sahab_project/feature/account/presentation/manager/account_cubit/account_cubit.dart';
import 'package:sahab_project/feature/account/presentation/view/pages/guest_account_view.dart';
import 'package:sahab_project/feature/account/presentation/view/widgets/edit_profile.dart';
import 'package:sahab_project/feature/account/presentation/view/widgets/my_account.dart';
import 'package:sahab_project/feature/account/presentation/view/widgets/my_account_text.dart';
import 'package:sahab_project/feature/account/presentation/view/widgets/option_widget.dart';
import 'package:sahab_project/feature/account/presentation/view/widgets/venodor_account.dart';
import '../../../../../generated/l10n.dart';
import '../widgets/powered_by_widget.dart';
import '../widgets/setting_option_list.dart';
import '../widgets/support_option_list.dart';

class UserAccountView extends StatelessWidget {
  const UserAccountView({super.key});

  @override
  Widget build(BuildContext context) {
    if (BlocProvider.of<AccountCubit>(context).userRole == 'vendor') {
      print("vendor");
      return const VendorAccountBody();
    } else if (BlocProvider.of<AccountCubit>(context).userRole == 'user') {
      print("user");
      return const UserAccountBody();
    } else {
      print("guest");
      return const GuestAccountView();
    }
  }
}

class UserAccountBody extends StatelessWidget {
  const UserAccountBody({super.key});
// todo : finish translate
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: ListView(
          padding: EdgeInsets.zero,
          clipBehavior: Clip.none,
          children: [
            SizedBox(
              height: 12.5.h,
            ),
            const MyAccountText(),
            SizedBox(
              height: 28.h,
            ),
            const MyAccount(),
            SizedBox(
              height: 36.h,
            ),
            const SettingOptionList(),
            SizedBox(
              height: 12.h,
            ),
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
                    MaterialPageRoute(
                      builder: (context) => const EditProfileScreen(),
                    ));
              },
              trailing: CacheHelper.getData(key: Constant.kLang) == 'ar'
                  ? SvgPicture.asset(
                      AppIcons.left,
                    )
                  : SvgPicture.asset(AppIcons.rightArrow),
              leadingIcon: AppIcons.editAccount,
            ),
            SizedBox(
              height: 12.h,
            ),
            const SupportOptionList(),
            SizedBox(
              height: 20.h,
            ),
            const PoweredByWidget(),
          ],
        ),
      ),
    );
  }
}

// class EditableCircularAvatar extends StatelessWidget {
//   const EditableCircularAvatar({
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       alignment: Alignment.topRight,
//       children: [
//         CircleAvatar(
//           radius: 50,
//           child: Icon(Icons.person_off),
//         ),
//         Padding(
//           padding: const EdgeInsets.only(bottom: 6  ),
//           child: InkWell(
//             child: CircleAvatar(
//               radius: 12,
//               backgroundColor: Colors.white,
//               child: Icon(
//                 Icons.edit,
//                 color: Colors.blue,
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
