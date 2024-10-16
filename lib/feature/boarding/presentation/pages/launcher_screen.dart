import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sahab_project/core/utils/widgets/no_internet_page.dart';
import 'package:sahab_project/feature/boarding/presentation/manager/internet_cubit/connectivity_cubit.dart';
import 'package:sahab_project/feature/boarding/presentation/manager/skip_cubit/skip_cubit.dart';
import 'package:sahab_project/feature/boarding/presentation/pages/skip_screen.dart';
import '../../../../core/utils/images/app_images_path.dart';
import '../../../../core/utils/logo/logos_app.dart';
import '../../../../core/utils/widgets/background_app.dart';

// @RoutePage()
class LauncherScreen extends StatefulWidget {
  const LauncherScreen({Key? key}) : super(key: key);

  @override
  _LauncherScreenState createState() => _LauncherScreenState();
}

class _LauncherScreenState extends State<LauncherScreen> {
  @override
  void initState() {
    BlocProvider.of<SkipCubit>(context).getSkipPhoto(context);
    super.initState();
    Future.delayed(Duration(seconds: 2), () {
      BlocProvider.of<ConnectivityCubit>(context).checkInternetStatus();
    });
  }

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    return Scaffold(
      body: BlocConsumer<ConnectivityCubit, ConnectivityStatus>(
        listener: (context, state) {
          if (state == ConnectivityStatus.disconnected) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (_) => NoInternetView(),
              ),
              (route) {
                return false;
              },
            );
          } else if (state == ConnectivityStatus.connected) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (_) => SkipScreen(),
              ),
              (route) {
                return false;
              },
            );
          }
        },
        builder: (context, state) {
          return Stack(
            children: [
              BackgroundApp(
                widget: Center(
                  child: Image.asset(
                    LogoApp.layer1,
                    width: 186.w,
                    height: 202.72.h,
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                child: Image.asset(
                  AppImagesPath.boardingLogo,
                  width: w,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
