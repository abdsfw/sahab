// // GENERATED CODE - DO NOT MODIFY BY HAND

// // **************************************************************************
// // AutoRouterGenerator
// // **************************************************************************

// // ignore_for_file: type=lint
// // coverage:ignore-file

// // ignore_for_file: no_leading_underscores_for_library_prefixes
// import 'package:auto_route/auto_route.dart' as _i7;
// import 'package:flutter/material.dart' as _i8;
// import 'package:sahab_project/feature/auth/presentation/pages/login/login_screen.dart'
//     as _i3;
// import 'package:sahab_project/feature/auth/presentation/pages/otp/otp_screen.dart'
//     as _i4;
// import 'package:sahab_project/feature/auth/presentation/pages/register/register_screen.dart'
//     as _i5;
// import 'package:sahab_project/feature/boarding/presentation/pages/lang_screen.dart'
//     as _i1;
// import 'package:sahab_project/feature/boarding/presentation/pages/launcher_screen.dart'
//     as _i2;
// import 'package:sahab_project/feature/boarding/presentation/pages/skip_screen.dart'
//     as _i6;

// abstract class $AppRouter extends _i7.RootStackRouter {
//   $AppRouter({super.navigatorKey});

//   @override
//   final Map<String, _i7.PageFactory> pagesMap = {
//     LangScreen.name: (routeData) {
//       return _i7.AutoRoutePage<dynamic>(
//         routeData: routeData,
//         child: const _i1.LangScreen(),
//       );
//     },
//     LauncherScreen.name: (routeData) {
//       return _i7.AutoRoutePage<dynamic>(
//         routeData: routeData,
//         child: const _i2.LauncherScreen(),
//       );
//     },
//     LoginScreen.name: (routeData) {
//       final args = routeData.argsAs<LoginScreenArgs>(
//           orElse: () => const LoginScreenArgs());
//       return _i7.AutoRoutePage<dynamic>(
//         routeData: routeData,
//         child: _i3.LoginScreen(key: args.key),
//       );
//     },
//     OTPScreen.name: (routeData) {
//       final args = routeData.argsAs<OTPScreenArgs>();
//       return _i7.AutoRoutePage<dynamic>(
//         routeData: routeData,
//         child: _i4.OTPScreen(
//           key: args.key,
//           number: args.number,
//         ),
//       );
//     },
//     RegisterScreen.name: (routeData) {
//       final args = routeData.argsAs<RegisterScreenArgs>(
//           orElse: () => const RegisterScreenArgs());
//       return _i7.AutoRoutePage<dynamic>(
//         routeData: routeData,
//         child: _i5.RegisterScreen(key: args.key),
//       );
//     },
//     SkipScreen.name: (routeData) {
//       return _i7.AutoRoutePage<dynamic>(
//         routeData: routeData,
//         child: const _i6.SkipScreen(),
//       );
//     },
//   };
// }

// /// generated route for
// /// [_i1.LangScreen]
// class LangScreen extends _i7.PageRouteInfo<void> {
//   const LangScreen({List<_i7.PageRouteInfo>? children})
//       : super(
//           LangScreen.name,
//           initialChildren: children,
//         );

//   static const String name = 'LangScreen';

//   static const _i7.PageInfo<void> page = _i7.PageInfo<void>(name);
// }

// /// generated route for
// /// [_i2.LauncherScreen]
// class LauncherScreen extends _i7.PageRouteInfo<void> {
//   const LauncherScreen({List<_i7.PageRouteInfo>? children})
//       : super(
//           LauncherScreen.name,
//           initialChildren: children,
//         );

//   static const String name = 'LauncherScreen';

//   static const _i7.PageInfo<void> page = _i7.PageInfo<void>(name);
// }

// /// generated route for
// /// [_i3.LoginScreen]
// class LoginScreen extends _i7.PageRouteInfo<LoginScreenArgs> {
//   LoginScreen({
//     _i8.Key? key,
//     List<_i7.PageRouteInfo>? children,
//   }) : super(
//           LoginScreen.name,
//           args: LoginScreenArgs(key: key),
//           initialChildren: children,
//         );

//   static const String name = 'LoginScreen';

//   static const _i7.PageInfo<LoginScreenArgs> page =
//       _i7.PageInfo<LoginScreenArgs>(name);
// }

// class LoginScreenArgs {
//   const LoginScreenArgs({this.key});

//   final _i8.Key? key;

//   @override
//   String toString() {
//     return 'LoginScreenArgs{key: $key}';
//   }
// }

// /// generated route for
// /// [_i4.OTPScreen]
// class OTPScreen extends _i7.PageRouteInfo<OTPScreenArgs> {
//   OTPScreen({
//     _i8.Key? key,
//     required String number,
//     List<_i7.PageRouteInfo>? children,
//   }) : super(
//           OTPScreen.name,
//           args: OTPScreenArgs(
//             key: key,
//             number: number,
//           ),
//           initialChildren: children,
//         );

//   static const String name = 'OTPScreen';

//   static const _i7.PageInfo<OTPScreenArgs> page =
//       _i7.PageInfo<OTPScreenArgs>(name);
// }

// class OTPScreenArgs {
//   const OTPScreenArgs({
//     this.key,
//     required this.number,
//   });

//   final _i8.Key? key;

//   final String number;

//   @override
//   String toString() {
//     return 'OTPScreenArgs{key: $key, number: $number}';
//   }
// }

// /// generated route for
// /// [_i5.RegisterScreen]
// // class RegisterScreen extends _i7.PageRouteInfo<RegisterScreenArgs> {
// //   RegisterScreen({
// //     _i8.Key? key,
// //     List<_i7.PageRouteInfo>? children,
// //   }) : super(
// //           RegisterScreen.name,
// //           args: RegisterScreenArgs(key: key),
// //           initialChildren: children,
// //         );

//   static const String name = 'RegisterScreen';

//   static const _i7.PageInfo<RegisterScreenArgs> page =
//       _i7.PageInfo<RegisterScreenArgs>(name);
// }

// class RegisterScreenArgs {
//   const RegisterScreenArgs({this.key});

//   final _i8.Key? key;

//   @override
//   String toString() {
//     return 'RegisterScreenArgs{key: $key}';
//   }
// }

// /// generated route for
// /// [_i6.SkipScreen]
// class SkipScreen extends _i7.PageRouteInfo<void> {
//   const SkipScreen({List<_i7.PageRouteInfo>? children})
//       : super(
//           SkipScreen.name,
//           initialChildren: children,
//         );

//   static const String name = 'SkipScreen';

//   static const _i7.PageInfo<void> page = _i7.PageInfo<void>(name);
// }
