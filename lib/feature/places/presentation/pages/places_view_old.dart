// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:sahab_project/core/const.dart';
// import 'package:sahab_project/core/utils/icons/app_icons.dart';
// import 'package:sahab_project/core/utils/widgets/circular_progress_indicator.dart';
// import 'package:sahab_project/core/utils/widgets/custom_filter_widget.dart';
// import 'package:sahab_project/core/utils/widgets/custom_simple_app_bar_widget.dart';
// import 'package:sahab_project/core/utils/widgets/no_result.dart';
// import 'package:sahab_project/feature/home/presentation/widgets/places_card.dart';
// import 'package:sahab_project/feature/places/data/model/place_model.dart';
// import 'package:sahab_project/feature/places/presentation/manager/place_cubit/place_cubit.dart';

// import '../../../../generated/l10n.dart';
// import 'flitter_page.dart';

// class PlacesView extends StatelessWidget {
//   const PlacesView({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const Scaffold(
//       body: PlacesViewBody(),
//     );
//   }
// }

// class PlacesViewBody extends StatefulWidget {
//   const PlacesViewBody({super.key});

//   @override
//   State<PlacesViewBody> createState() => _PlacesViewBodyState();
// }

// class _PlacesViewBodyState extends State<PlacesViewBody> {
//   // PlaceCubit placeCubit = PlaceCubit.get(context);
//   late final ScrollController _scrollController;
//   late final ScrollController _listScrollController;

//   List<PlaceModel> places = [];
//   var isLoading = false;

//   // todo : finish translate

//   @override
//   void initState() {
//     super.initState();
//     _scrollController = ScrollController();
//     _listScrollController = ScrollController();
//     BlocProvider.of<PlaceCubit>(context).fetchPlace();
//     _scrollController.addListener(() {
//       _scrollListener(BlocProvider.of<PlaceCubit>(context));
//     });
//   }

//   void _scrollListener(PlaceCubit placeCubit) async {
//     var currentPositions = _scrollController.position.pixels;

//     var maxScrollLength = _scrollController.position.maxScrollExtent;
//     print('Current position: $currentPositions');
//     print('Max scroll length: $maxScrollLength');
//     if (currentPositions >= 0.7 * maxScrollLength) {
//       if (!isLoading) {
//         isLoading = true;
//         await placeCubit.fetchPlace(pageNumber: placeCubit.nextPage++);
//         isLoading = false;
//       }
//       if (kDebugMode) {
//         print(placeCubit.nextPage);
//       }
//     }
//   }

//   @override
//   void dispose() {
//     _scrollController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     PlaceCubit placeCubit = PlaceCubit.get(context);
//     return WillPopScope(
//       onWillPop: () async {
//         placeCubit.nextPage = 2;
//         return true;
//       },
//       child: CustomScrollView(
//         controller: _listScrollController,
//         // physics: NeverScrollableScrollPhysics(),
//         slivers: [
//           SliverToBoxAdapter(
//             child: CustomSimpleAppBarWidget(
//               onIconTap: () {
//                 Navigator.of(context).pop();
//               },
//               iconPath: AppIcons.backArrow,
//               appBarTitle: S.of(context).featured_locations,
//             ),
//           ),
//           SliverToBoxAdapter(
//             child: SizedBox(
//               height: 28.h,
//             ),
//           ),
//           SliverToBoxAdapter(
//             child: Padding(
//               padding: EdgeInsets.only(left: 20.w, right: 16.w, bottom: 15.h),
//               //! here we may be put dynamic title
//               child: BlocBuilder<PlaceCubit, PlaceState>(
//                 builder: (context, state) {
//                   return CustomFilterWidget(
//                     title: placeCubit.total.toString(),
//                     isVisibleAll: true,
//                     onTap: () {
//                       Navigator.of(context).push(MaterialPageRoute(
//                         builder: (context) => const FlitterPage(),
//                       ));
//                     },
//                   );
//                 },
//               ),
//             ),
//           ),
//           BlocConsumer<PlaceCubit, PlaceState>(
//             listener: (context, state) {
//               if (state is PlaceLoadMore) {
//                 places.addAll(placeCubit.fetchPlaceList);
//               }
//             },
//             builder: (context, state) {
//               // if (state is PlaceLoading) {
//               //   // return const CircularProgressIndicator();
//               // } else
//               if (state is PlaceLoadSuccess ||
//                   state is PlaceLoadMore ||
//                   state is PlacePaginationFailure) {
//                 if (places.isEmpty) {
//                   return SliverFillRemaining(
//                     child: Center(
//                         child: NoResult(
//                       title: S.of(context).no_results_found,
//                     )),
//                   );
//                 } else {
//                   return SliverFillRemaining(
//                     child: Column(
//                       children: [
//                         Expanded(
//                           child: ListView.builder(
//                             controller: _scrollController,
//                             scrollDirection: Axis.vertical,
//                             itemCount: state is PlaceLoadMore
//                                 ? places.length + 1
//                                 : places.length,
//                             itemBuilder: (context, index) {
//                               if (index < places.length) {
//                                 return Padding(
//                                   padding:
//                                       EdgeInsets.only(left: 16.w, bottom: 20.h),
//                                   child: const PlacesCard(
//                                     imagePath: Constant.kPlaceImage,
//                                     placeId: 1,
//                                     dicVisibly: true,
//                                     rate: "4.5",
//                                     locationName: "unknown place",
//                                     price: "unknown place",
//                                     tag: "unknown place",
//                                   ),
//                                 );
//                               } else {
//                                 return Center(
//                                     child: Padding(
//                                   padding: EdgeInsets.only(bottom: 10.h),
//                                   child:
//                                       const CustomCircularProgressIndicator(),
//                                 ));
//                               }
//                             },
//                           ),
//                         ),
//                         // Visibility(
//                         //     visible: state is PlaceLoadMore,
//                         //     child: const Padding(
//                         //       padding: EdgeInsets.all(8.0),
//                         //       child: CustomCircularProgressIndicator(),
//                         //     ))
//                       ],
//                     ),
//                   );
//                 }
//               } else if (state is PlaceLoading) {
//                 return const SliverFillRemaining(
//                     child: Center(child: CustomCircularProgressIndicator()));
//               } else {
//                 return const SliverFillRemaining(child: SizedBox());
//               }
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }
