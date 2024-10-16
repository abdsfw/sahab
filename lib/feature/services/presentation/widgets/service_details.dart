// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:sahab_project/core/const.dart';
// import 'package:sahab_project/core/utils/icons/app_icons.dart';
// import 'package:sahab_project/core/utils/widgets/custom_filter_widget.dart';
// import 'package:sahab_project/core/utils/widgets/custom_simple_app_bar_widget.dart';
// import 'package:sahab_project/feature/home/presentation/widgets/places_card.dart';
// import 'package:sahab_project/feature/services/data/model/service_model.dart';
// import 'package:sahab_project/feature/services/presentation/manager/cubit/service_cubit.dart';

// import '../pages/flitter_page.dart';

// class ServiceDetails extends StatelessWidget {
//   const ServiceDetails({super.key, required this.service});
//   final ServicesModel service;

//   @override
//   Widget build(BuildContext context) {
//     ServiceCubit serviceCubit = ServiceCubit.get(context);
//     return Scaffold(
//       body: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 16),
//         child: ListView(
//           children: [
//             Padding(
//               padding: EdgeInsets.only(top: 45.h),
//               child: CustomSimpleAppBarWidget(
//                 appBarTitle: service.title,
//                 iconPath: AppIcons.backArrow,
//                 onIconTap: () {
//                   Navigator.of(context).pop();
//                 },
//               ),
//             ),
//             SizedBox(
//               height: 32.h,
//             ),
//             //! flitter widget to flittering the services
//             CustomFilterWidget(
//               title: "102 Service Providers",
//               isVisibleAll: false,
//               onTap: () {
//                 Navigator.of(context).push(MaterialPageRoute(
//                   builder: (context) => const FlitterServicePage(),
//                 ));
//               },
//             ),
//             SizedBox(
//               height: 18.h,
//             ),
//             BlocConsumer<ServiceCubit, ServiceState>(
//               listener: (context, state) {},
//               builder: (context, state) {
//                 return ListView.builder(
//                   shrinkWrap: true,
//                   itemCount: serviceCubit.filteredList.length,
//                   physics: const NeverScrollableScrollPhysics(),
//                   itemBuilder: (context, index) {
//                     return Padding(
//                       padding: EdgeInsets.only(bottom: 30.h),
//                       child: PlacesCard(
//                         imagePath: Constant.kPartyImage,
//                         dicVisibly: false,
//                         rate:
//                             serviceCubit.filteredList[index].rating.toString(),
//                         locationName: "unknown place",
//                         price: "unknown place",
//                         tag: "unknown place",
//                       ),
//                     );
//                   },
//                 );
//               },
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
