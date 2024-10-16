// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:sahab_project/core/theme/app_color.dart';
// import 'package:sahab_project/core/theme/app_textsyle.dart';
// import 'package:sahab_project/core/utils/icons/app_icons.dart';
// import 'package:sahab_project/core/utils/widgets/app_bar.dart';
// import 'package:sahab_project/core/utils/widgets/custom_simple_app_bar_widget.dart';
// import 'package:sahab_project/feature/Bookings/presentation/views/widgets/test.dart';
// import 'package:sahab_project/feature/places/presentation/pages/book_now.dart';

// import '../../../../generated/l10n.dart';

// class PlaceDetails extends StatelessWidget {
//   const PlaceDetails({super.key});
// // todo : finish translate
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: ListView(padding: const EdgeInsets.all(0), children: [
//         CustomSimpleAppBarWidget(
//           onIconTap: () {},
//           iconPath: AppIcons.backArrow,
//           appBarTitle: S.of(context).service_details,
//         ),
//         const Padding(
//           padding: EdgeInsets.all(16.0),
//           child: PlacesCardTest(
//             borderRadius: BorderRadius.zero,
//             color: Colors.transparent,
//             boxShadow: [],
//           ),
//         ),
//         const Divider(),
//         // const DetailsTitle(title: "Amenities"),
//         // ListView.builder(
//         //   itemCount: 5,
//         //   shrinkWrap: true,
//         //   physics: const NeverScrollableScrollPhysics(),
//         //   itemBuilder: (context, index) {
//         //     return const AmenitiesItem();
//         //   },
//         // ),
//         // const Divider(),
//         // const DetailsTitle(title: "Address"),
//         Padding(
//           padding: EdgeInsets.only(left: 16.w, top: 3.h, bottom: 36.h),
//           child: Text(
//             "Muntazah Al Khairan road 278 zone 3, An Nami, Al Khiran, Kuwait",
//             style: AppStyles.style14(context)
//                 .copyWith(color: AppColor.greyColorWithOpacity),
//           ),
//         ),
//         const Divider(),
//         //! here we may be put dynamic title
//         const DetailsTitle(title: "About Chalet"),
//         Padding(
//           padding:
//               EdgeInsets.only(left: 16.w, top: 3.h, bottom: 36.h, right: 34.w),
//           child: Text(
//             "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
//             style: AppStyles.style14(context)
//                 .copyWith(color: AppColor.greyColorWithOpacity),
//           ),
//         ),
//         // const Expanded(child: SizedBox()),
//         GestureDetector(
//           onTap: () {
//             // Navigator.push(
//             //     context,
//             //     MaterialPageRoute(
//             //       builder: (context) =>  BookNow(),
//             //     ));
//           },
//           child: Container(
//             margin: EdgeInsets.only(right: 16.w, bottom: 20.h, left: 16.w),
//             height: MediaQuery.of(context).size.height * 0.07,
//             decoration: const BoxDecoration(
//                 borderRadius: BorderRadius.all(Radius.circular(10)),
//                 color: AppColor.blueColor),
//             child: Center(
//                 child: Text(
//               S.of(context).book_now,
//               style: AppStyles.style16(context)
//                   .copyWith(fontWeight: FontWeight.w600, color: Colors.white),
//             )),
//           ),
//         ),
//       ]),
//     );
//   }
// }

// class DetailsTitle extends StatelessWidget {
//   const DetailsTitle({
//     super.key,
//     required this.title,
//   });
//   final String title;

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(16.0),
//       child: Text(
//         title,
//         style: AppStyles.style18semibold(context),
//       ),
//     );
//   }
// }

// // class AmenitiesItem extends StatelessWidget {
// //   const AmenitiesItem({
// //     super.key,
// //   });
// //   @override
// //   Widget build(BuildContext context) {
// //     return Padding(
// //       padding: const EdgeInsets.all(16.0),
// //       child: Row(
// //         mainAxisSize: MainAxisSize.min,
// //         crossAxisAlignment: CrossAxisAlignment.center,
// //         children: [
// //           Container(
// //             width: 50.w,
// //             height: 50.h,
// //             decoration: BoxDecoration(
// //                 borderRadius: BorderRadius.circular(5), color: Colors.white),
// //             child: Padding(
// //               padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
// //               child: SvgPicture.asset(AppIcons.wifi),
// //             ),
// //           ),
// //           const SizedBox(
// //             width: 15,
// //           ),
// //           Text(
// //             "Wifi",
// //             style: AppStyles.style16(context),
// //           )
// //         ],
// //       ),
// //     );
// //   }
// // }
