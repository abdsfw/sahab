import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sahab_project/core/const.dart';
import 'package:sahab_project/core/notifiction/notification_cubit/notification_cubit.dart';
import 'package:sahab_project/core/notifiction/notification_services.dart';
import 'package:sahab_project/core/utils/cache/cache_helper.dart';
import 'package:sahab_project/core/utils/service_locator.dart';
import 'package:sahab_project/feature/Bookings/presentation/manager/booking_cubit/booking_cubit.dart';
import 'package:sahab_project/feature/account/presentation/manager/contact_cubit/contact_cubit.dart';
import 'package:sahab_project/feature/account/presentation/manager/account_cubit/account_cubit.dart';
import 'package:sahab_project/feature/account/presentation/manager/notification_cubit/notification_cubit_switch.dart';
import 'package:sahab_project/feature/account/presentation/manager/static_page_cubit/static_page_cubit.dart';
import 'package:sahab_project/feature/account/presentation/manager/static_value_cubit/static_value_cubit.dart';
import 'package:sahab_project/feature/account/presentation/manager/terminate_account_cubit/terminal_account_cubit.dart';
import 'package:sahab_project/feature/auth/presentation/manager/cubit/login_cubit/cubit/login_cubit.dart';
import 'package:sahab_project/feature/auth/presentation/manager/cubit/otp_cubit/otp_cubit.dart';
import 'package:sahab_project/feature/auth/presentation/manager/cubit/register_cubit/register_cubit.dart';
import 'package:sahab_project/feature/boarding/presentation/manager/internet_cubit/connectivity_cubit.dart';
import 'package:sahab_project/feature/boarding/presentation/manager/lang_cubit/lang_cubit.dart';
import 'package:sahab_project/feature/boarding/presentation/manager/skip_cubit/skip_cubit.dart';
import 'package:sahab_project/feature/boarding/presentation/pages/launcher_screen.dart';
import 'package:sahab_project/feature/categories/presentation/manager/cubit/category_cubit.dart';
import 'package:sahab_project/feature/checkout/presentation/manager/payment_cubit/payment_cubit.dart';
import 'package:sahab_project/feature/checkout/presentation/manager/promo_code_cubit/promo_code_cubit.dart';
import 'package:sahab_project/feature/home/presentation/manager/area_cubit/area_cubit.dart';
import 'package:sahab_project/feature/home/presentation/manager/bottomNavBar_cubit/bottom_nav_bar_cubit.dart';
import 'package:sahab_project/feature/home/presentation/manager/image_home_cubit/image_home_cubit.dart';
import 'package:sahab_project/feature/home/presentation/manager/send_token_cubit/send_token_cubit.dart';
import 'package:sahab_project/feature/places/presentation/manager/place_cubit/place_cubit.dart';
import 'package:sahab_project/feature/places/presentation/manager/place_details_cubit/place_details_cubit.dart';
import 'package:sahab_project/feature/serach/presentation/manager/cubit/serach_cubit.dart';
import 'package:sahab_project/feature/serach/presentation/manager/cubit/services_search_cubit.dart';
import 'package:sahab_project/feature/serach/presentation/manager/cubit/tab_switch_cubit.dart';
import 'package:sahab_project/feature/services/presentation/manager/service_cubit/service_cubit.dart';
import 'package:sahab_project/feature/services/presentation/manager/service_category_cubit/services_category_cubit.dart';
import 'package:sahab_project/firebase_options.dart';
import 'core/theme/app_color.dart';
import 'core/utils/bloc_observer.dart';
import 'feature/add_edit_post/presentation/manager/next_post_place_cubit/next_post_place_cubit.dart';
import 'feature/home/presentation/manager/home_cubit/home_cubit.dart';
import 'generated/l10n.dart';

Future<void> fierbaseMessagingBackgroundHandler(RemoteMessage message) async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //? this way better than regular one , it make async function run in parallel
  await Future.wait([
    CacheHelper.cacheInit(),
    Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    ),
  ]);
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  setupServiceLocator();
  Bloc.observer = MyBlocObserver();
  NotificationServices().requestNotificationPermission();
  NotificationServices().firebaseInit();
  if (CacheHelper.getData(key: Constant.kIsNotificationActive) == null) {
    NotificationServices().getDeviceToken();
  } else {
    if (CacheHelper.getData(key: Constant.kIsNotificationActive)) {
      print('true');

      NotificationServices().getDeviceToken();
    }
  }
  FirebaseMessaging.onBackgroundMessage(fierbaseMessagingBackgroundHandler);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // final _appRouter = AppRouter();

  /// here for lan
  // String? lang;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        // BlocProvider(create: (_) => di.sl<AppBloc>()..add(GetLangAppEvent())),

        BlocProvider(
          create: (context) => LangCubit(),
        ),

        BlocProvider(
          create: (context) => BookingCubit(),
        ),
        BlocProvider(
          create: (context) => BottomNavBarCubit(),
        ),
        BlocProvider(
          create: (context) => RegisterCubit(),
        ),
        BlocProvider(
          create: (context) => LoginCubit(),
        ),
        BlocProvider(
          create: (context) => AccountCubit(),
        ),
        BlocProvider(
          create: (context) =>
              PlaceCubit()..fetchAllFuturePlaces(context, query: "limit=7"),
        ),
        BlocProvider(
          create: (context) => CategoryCubit()..fetchCategory(context),
        ),
        BlocProvider(
          create: (context) => ServiceCubit()..fetchServices(context),
        ),
        BlocProvider(
          create: (context) => ConnectivityCubit(),
        ),
        BlocProvider(
          create: (context) => NextPostPlaceCubit(),
        ),
        BlocProvider(
          create: (context) => SearchCubit(),
        ),
        BlocProvider(
          create: (context) => PlaceDetailsCubit(),
        ),
        BlocProvider(
          create: (context) => TabSwitchCubit()..placesTab(),
        ),
        BlocProvider(
          create: (context) => ServicesSearchCubit(),
        ),
        BlocProvider(
          create: (context) => ImageHomeCubit()..getHomePic(),
        ),
        BlocProvider(
          create: (context) => TerminalAccountCubit(),
        ),
        BlocProvider(
          create: (context) => StaticPageCubit(),
        ),
        BlocProvider(
          create: (context) => SendTokenCubit(),
        ),
        BlocProvider(
          create: (context) => StaticValueCubit()..fetchStaticValue(),
        ),
        BlocProvider(
          create: (context) => ServicesCategoryCubit(),
        ),
        BlocProvider(
          create: (context) => NotificationCubitSwitch(),
        ),
        BlocProvider(
          create: (context) => PaymentCubit()..fetchPaymentMethod(),
        ),
        BlocProvider(
          create: (context) => HomeCubit()..fetchUserData(context),
        ),
        BlocProvider(
          create: (context) => AreaCubit(),
        ),
        BlocProvider(
          create: (context) => PromoCodeCubit(),
        ),
        BlocProvider(
          create: (context) => NotificationCubit(),
        ),
        BlocProvider(create: (context) => ContactCubit()..initTextController()),
        BlocProvider(
          create: (context) => OtpCubit(),
        ),
        BlocProvider(
          create: (context) => SkipCubit(),
        ),
      ],
      child: BlocConsumer<LangCubit, LangState>(
        listener: (context, state) {},
        builder: (context, state) {
          return ScreenUtilInit(
            designSize: const Size(393, 852),
            minTextAdapt: true,
            splitScreenMode: true,
            builder: (context, child) {
              return MaterialApp(
                localizationsDelegates: const [
                  S.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],
                theme: ThemeData(
                    scaffoldBackgroundColor: AppColor.pageBackGround,
                    primaryColor: AppColor.blueColor,
                    useMaterial3: true),
                supportedLocales: S.delegate.supportedLocales,
                // localizationsDelegates: context.localizationDelegates,
                // supportedLocales: context.supportedLocales,
                locale: Locale(BlocProvider.of<LangCubit>(context).lang),
                debugShowCheckedModeBanner: false,
                // home: const LauncherScreen(),
                // home: const LauncherScreen(),
                home: LauncherScreen(),
                // home: const CheckOutPage(),
                // home: const BookingHomePage(),

                // home: const SuccessCheckoutPage(),
                // home: const FailedCheckoutPage(),
                // home: const BookingPlacesPage(),
                // home: const BookingLoginPage(),
                // home: const RateBookingPage(),
              );
            },
          );
        },
      ),
    );
  }
}
