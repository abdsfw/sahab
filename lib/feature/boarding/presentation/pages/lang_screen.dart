import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahab_project/core/const.dart';
import 'package:sahab_project/core/utils/cache/cache_helper.dart';
import 'package:sahab_project/feature/auth/presentation/pages/login/login_screen.dart';
import 'package:sahab_project/feature/boarding/presentation/manager/lang_cubit/lang_cubit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../core/utils/icons/app_icons.dart';
import '../../../auth/presentation/pages/register/register_screen.dart';
import '../widgets/choose_lang_widget.dart';
import '../widgets/text_lang_widget.dart';

// @RoutePage()
class LangScreen extends StatelessWidget {
  const LangScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LangCubit, LangState>(
      listener: (context, state) async {
        await CacheHelper.setData(key: Constant.kIsFirstTime, value: false);
        if (state is FirstChooseLangScreenState) {
          if (context.mounted) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (_) => LoginScreen(),
              ),
              (route) {
                return false;
              },
            );
          }
        }
      },
      builder: (context, state) {
        // var appBloc = AppBloc.get(context);
        return Scaffold(
          body:
              // s//   widget:
              SingleChildScrollView(
            child: Center(
              child: Column(
                // crossAxisAlignment: CrossAxisAlignment.center,
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // const Expanded(
                  //   flex: 2,
                  //   child: SizedBox(
                  //       // height: 180.h,
                  //       ),
                  // ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.15,
                  ),
                  SvgPicture.asset(
                    AppIcons.group,
                    // height: 100,
                    // width: 100,
                  ),
                  const TextLanWidget(),
                  ChooseLangWidget(
                    englishOnTap: () {
                      // print(BlocProvider.of<LangCubit>(context).lang);
                      BlocProvider.of<LangCubit>(context)
                          .firstChooseLang(language: 'en');
                      // appBloc.add(const ChooseLangEvent(lang: 'en'));
                    },
                    arabicOnTap: () {
                      BlocProvider.of<LangCubit>(context)
                          .firstChooseLang(language: 'ar');
                      // appBloc.add(const ChooseLangEvent(lang: 'ar'));
                    },
                  ),
                  // const Expanded(
                  //   flex: 1,
                  //   child: SizedBox(),
                  // )
                ],
              ),
            ),
          ),
          // ),
        );
      },
    );
  }
}
