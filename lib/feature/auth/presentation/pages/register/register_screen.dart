import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:sahab_project/feature/auth/presentation/pages/login/login_screen.dart';
import '../../../../../core/utils/logo/logos_app.dart';
import '../../../../../generated/l10n.dart';
import '../../widgets/login_form_widget.dart';
import '../../widgets/login_logo_text_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

@RoutePage()
class RegisterScreen extends StatelessWidget {
  RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // String lang = BlocProvider.of<LangCubit>(context).lang;
    // RegisterCubit registerCubit = RegisterCubit.get(context);
    // bool en = lang == 'en';
    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).pop();
        Navigator.of(context).pop();
        return false;
      },
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsetsDirectional.symmetric(horizontal: 16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 100.h,
                ),
                LoginLogoTextWidget(
                  imagePath: LogoApp.group,
                  firstText: S.of(context).Welcome,
                  secondText: S.of(context).lets_get_you_registered,
                ),
                RegisterFormWidget(
                  // en: en,
                  // lang: lang,
                  hintText: S.of(context).enter_here,
                  validatorName: (value) {
                    if (value!.isEmpty) {
                      return S.of(context).empty_field_message;
                    }
                    return null;
                  },
                  validatorEmail: (value) {
                    if (value!.isEmpty) {
                      return S.of(context).empty_field_message;
                    } else if (!value.contains('@')) {
                      return "E-mail must contains @";
                    }

                    return null;
                  },
                  buttonWidth: 1000.w,
                  buttonText: S.of(context).Register,
                ),
              ],
            ),
            // ),
          ),
        ),
      ),
    );
  }
}
