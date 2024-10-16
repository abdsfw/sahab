import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sahab_project/core/const.dart';
import 'package:sahab_project/core/notifiction/notification_services.dart';
import 'package:sahab_project/core/theme/app_color.dart';
import 'package:sahab_project/core/theme/app_textsyle.dart';
import 'package:sahab_project/core/utils/cache/cache_helper.dart';
import 'package:sahab_project/core/utils/icons/app_icons.dart';
import 'package:sahab_project/core/utils/widgets/app_button.dart';
import 'package:sahab_project/feature/account/presentation/view/widgets/option_widget.dart';
import 'package:sahab_project/feature/boarding/presentation/manager/lang_cubit/lang_cubit.dart';

import '../../../../../generated/l10n.dart';

class SettingOptionList extends StatefulWidget {
  const SettingOptionList({super.key});

  @override
  State<SettingOptionList> createState() => _SettingOptionListState();
}

class _SettingOptionListState extends State<SettingOptionList> {
  bool notificationsEnabled = true;
  void toggleNotifications(bool newValue) {
    setState(() {
      notificationsEnabled = newValue;
    });

    // Perform any additional logic here, such as updating preferences or calling APIs
  }

// todo : finish translates
  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      children: [
        Text(
          S.of(context).settings,
          style: AppStyles.style18semibold(context),
        ),
        SizedBox(
          height: 12.h,
        ),
        BlocBuilder<LangCubit, LangState>(
          builder: (context, state) {
            return OptionWidget(
              title: S.of(context).change_language,
              trailing: Text(
                BlocProvider.of<LangCubit>(context).langUi,
                style: TextStyle(
                  fontSize: 20.sp,
                ),
              ),
              leadingIcon: AppIcons.language,
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    backgroundColor: AppColor.pageBackGround,
                    scrollable: true,
                    content: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        AppButton(
                            width: 185.w,
                            height: 100.h,
                            onTap: () {
                              BlocProvider.of<LangCubit>(context)
                                  .changeLang(context, language: 'en');
                              Navigator.of(context).pop();
                            },
                            text: 'English',
                            color: AppColor.blueColor,
                            radius: 10.r,
                            fontSize: 18.sp,
                            fontFamily: AppFont.Poppins,
                            textColor: AppColor.textColor,
                            fontWeight: FontWeight.w600),
                        SizedBox(
                          height: 30.h,
                        ),
                        AppButton(
                            width: 185.w,
                            height: 100.h,
                            onTap: () {
                              BlocProvider.of<LangCubit>(context)
                                  .changeLang(context, language: 'ar');
                              Navigator.of(context).pop();
                            },
                            text: 'العربية',
                            color: AppColor.secondPrimaryColor,
                            radius: 10.r,
                            fontSize: 18.sp,
                            fontFamily: AppFont.Almarai,
                            textColor: AppColor.textColor,
                            fontWeight: FontWeight.w700),
                      ],
                    ),
                    // actions: [
                    //   ElevatedButton(
                    //     onPressed: () {
                    //       BlocProvider.of<LangCubit>(context)
                    //           .changeLang(language: 'en');
                    //     },
                    //     child: const Text('English'),
                    //   ),
                    //   // ignore: prefer_const_constructors
                    //   SizedBox(
                    //     height: 10,
                    //   ),
                    //   ElevatedButton(
                    //     onPressed: () {
                    //       BlocProvider.of<LangCubit>(context)
                    //           .changeLang(language: 'ar');
                    //     },
                    //     child: const Text('العربية'),
                    //   ),
                    // ],
                  ),
                );
              },
            );
          },
        ),
        OptionWidget(
          title: S.of(context).notification,
          onTap: () {},
          trailing: SizedBox(
            height: 31.h,
            width: 51.w,
            child: CupertinoSwitch(
              value: CacheHelper.getData(key: Constant.kIsNotificationActive) ==
                      null
                  ? true
                  : CacheHelper.getData(key: Constant.kIsNotificationActive),
              onChanged: (value) {
                setState(() {
                  NotificationServices.instance.toggleNotifications(value);
                  CacheHelper.setData(
                      key: Constant.kIsNotificationActive, value: value);
                });
              },
            ),
          ),
          leadingIcon: AppIcons.notification,
        ),
      ],
    );
  }
}
