import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sahab_project/core/theme/app_textsyle.dart';
import 'package:sahab_project/core/utils/icons/app_icons.dart';
import 'package:sahab_project/core/utils/widgets/custom_simple_app_bar_widget.dart';
import 'package:sahab_project/feature/account/presentation/manager/account_cubit/account_cubit.dart';
import 'package:sahab_project/feature/boarding/presentation/manager/lang_cubit/lang_cubit.dart';
import 'package:sahab_project/feature/home/presentation/pages/home_page_view.dart';
import 'package:sahab_project/generated/l10n.dart';
import '../../../../../core/const.dart';
import '../../../../../core/utils/cache/cache_helper.dart';
import '../../../../../core/utils/logo/logos_app.dart';
import '../../../../../core/theme/app_color.dart';
import '../../../../../core/utils/widgets/app_text.dart';
import '../../widgets/login_form_widget.dart';
import '../../widgets/login_logo_text_widget.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key, this.withReturn = false, this.atBooking = false})
      : super(key: key);
  final bool withReturn;
  final bool atBooking;
  var formKey = GlobalKey<FormState>();
  TextEditingController number = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    // String lang = BlocProvider.of<LangCubit>(context).lang;
    // bool en = lang == 'en';
    return Scaffold(
      body: Column(
        children: [
          if (withReturn)
            CustomSimpleAppBarWidget(appBarTitle: "", iconPath: AppIcons.close),
          Expanded(
            child: Padding(
              padding: const EdgeInsetsDirectional.only(start: 16),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: h * 0.20,
                    ),
                    LoginLogoTextWidget(
                      imagePath: LogoApp.group,
                      firstText: S.of(context).welcome_back,
                      secondText: S.of(context).glad_message,
                    ),
                    AppText(
                      text: S.of(context).mobile_number,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                      fontFamily: AppStyles.getFontFamily(context),
                      color: const Color(
                        0xff2E2E2E,
                      ),
                    ),
                    SizedBox(
                      height: 7.h,
                    ),
                    LoginFormWidget(
                      hintText: S.of(context).enter_here,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return S.of(context).empty_field_message;
                        } else if (value.length < 8) {
                          return S
                              .of(context)
                              .phone_must_be_digital; //"phone must be 8 digital";
                        }
                        return null;
                      },
                      buttonWidth: w,
                      buttonText: S.of(context).login,
                    ),
                    if (!atBooking)
                      TextButton(
                        onPressed: () async {
                          BlocProvider.of<AccountCubit>(context).userRole =
                              "guest";
                          await CacheHelper.setData(
                              key: Constant.kUserRole, value: "guest");
                          Navigator.of(context).pushAndRemoveUntil(
                              CupertinoPageRoute(
                                builder: (context) => HomePageView(),
                              ),
                              (route) => false);
                        },
                        child: Text(
                          S
                              .of(context)
                              .log_in_as_a_guest, // "Log in as a guest",
                          style: AppStyles.textStyle12w500Grey(context),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
