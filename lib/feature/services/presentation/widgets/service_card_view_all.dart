import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sahab_project/core/const.dart';
import 'package:sahab_project/core/utils/icons/app_icons.dart';
import 'package:sahab_project/core/utils/widgets/circular_progress_indicator.dart';
import 'package:sahab_project/core/utils/widgets/custom_filter_widget.dart';
import 'package:sahab_project/core/utils/widgets/custom_no_internet_and_error_view.dart';
import 'package:sahab_project/core/utils/widgets/custom_simple_app_bar_widget.dart';
import 'package:sahab_project/core/utils/widgets/no_result.dart';
import 'package:sahab_project/feature/services/data/model/service.dart';
import 'package:sahab_project/feature/services/presentation/manager/service_cubit/service_cubit.dart';
import 'package:sahab_project/feature/services/presentation/manager/service_category_cubit/services_category_cubit.dart';
import 'package:sahab_project/generated/l10n.dart';
import '../pages/flitter_page.dart';
import 'service_card_view.dart';

class ServiceDetails extends StatefulWidget {
  const ServiceDetails({
    super.key,
    required this.title,
    required this.categoryID,
  });

  final String title;
  final int categoryID;

  @override
  State<ServiceDetails> createState() => _ServiceDetailsState();
}

class _ServiceDetailsState extends State<ServiceDetails> {
  late final ScrollController _scrollController;
  var nextPage = 2;
  List<Services> services = [];
  var isLoading = false;
  String? query;

  @override
  void initState() {
    BlocProvider.of<ServicesCategoryCubit>(context).fetchServicesForOneCategory(
        categoryId: widget.categoryID, query: query);
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
    // TODO: implement initState
    super.initState();
  }

  void _scrollListener() async {
    var currentPositions = _scrollController.position.pixels;
    var maxScrollLength = _scrollController.position.maxScrollExtent;
    if (currentPositions >= 0.7 * maxScrollLength) {
      if (!isLoading) {
        isLoading = true;
        await BlocProvider.of<ServicesCategoryCubit>(context)
            .fetchServicesForOneCategory(
          pageNumber: nextPage++,
          categoryId: widget.categoryID,
          query: query,
        );
        isLoading = false;
      }
      print(nextPage);
    }
  }

  @override
  Widget build(BuildContext context) {
    ServicesCategoryCubit servicesCategoryCubit =
        ServicesCategoryCubit().get(context);
    return Scaffold(
      body: WillPopScope(
        onWillPop: () async {
          servicesCategoryCubit.total = 0;
          servicesCategoryCubit.query = null;
          return true;
        },
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: CustomSimpleAppBarWidget(
                appBarTitle: widget.title,
                iconPath: AppIcons.backArrow,
                onIconTap: () {
                  Navigator.of(context).pop();
                  servicesCategoryCubit.total = 0;
                  servicesCategoryCubit.query = null;
                },
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 29.h,
              ),
            ),
            //! flitter widget to flittering the services
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsetsDirectional.only(start: 20.5.w, end: 15.5.w),
                child:
                    BlocBuilder<ServicesCategoryCubit, ServicesCategoryState>(
                  builder: (context, state) {
                    if (servicesCategoryCubit.query == null &&
                        services.isEmpty) {
                      return SizedBox();
                    } else {
                      return CustomFilterWidget(
                        isFilter: servicesCategoryCubit.query != null,
                        title: state is ServicesCategoryLoading
                            ? ""
                            : servicesCategoryCubit.total.toString(),
                        isVisibleAll: false,
                        onTap: () {
                          Navigator.of(context)
                              .push(
                            MaterialPageRoute(
                              builder: (context) => FlitterServicePage(
                                endValue:
                                    BlocProvider.of<ServicesCategoryCubit>(
                                            context)
                                        .maxPrice
                                        .toDouble(),
                              ),
                            ),
                          )
                              .then(
                            (value) {
                              // if (value != null) {
                              services = [];
                              nextPage = 2;
                              servicesCategoryCubit.query = value;
                              query = value;

                              print("after return :$query");

                              servicesCategoryCubit.fetchServicesForOneCategory(
                                  categoryId: widget.categoryID, query: query);
                              // }
                            },
                          );
                        },
                      );
                    }
                  },
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 18.h,
              ),
            ),
            //! here All service
            BlocConsumer<ServicesCategoryCubit, ServicesCategoryState>(
              listener: (context, state) {
                if (state is ServicesCategoryLoadMore) {
                  services.addAll(servicesCategoryCubit.fetchServicesList);
                }
              },
              builder: (context, state) {
                if (state is ServicesCategoryLoadSuccess ||
                    state is ServicesCategoryLoadMore) {
                  if (services.isEmpty) {
                    return SliverFillRemaining(
                      child: Center(
                          child: NoResult(
                        title: S.of(context).no_result,
                      )),
                    );
                  } else {
                    return SliverFillRemaining(
                      child: Column(
                        children: [
                          Expanded(
                            child: ListView.builder(
                              controller: _scrollController,
                              itemCount: state is ServicesCategoryLoadMore
                                  ? services.length + 1
                                  : services.length,
                              itemBuilder: (context, index) {
                                if (index < services.length) {
                                  return Padding(
                                    padding: EdgeInsetsDirectional.only(
                                        start: 16.5.w,
                                        end: 15.5.w,
                                        bottom: 30.h),
                                    child: ServiceCardView(
                                      service: services[index],
                                    ),
                                  );
                                } else {
                                  return const Center(
                                      child: CustomCircularProgressIndicator());
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                } else if (state is ServicesCategoryPaginationFailure) {
                  // if (state.statusCode == 606) {
                  return SliverFillRemaining(
                    child: CustomNoInternetAndErrorView(
                      onTryAgainButton: () {
                        BlocProvider.of<ServicesCategoryCubit>(context)
                            .fetchServicesForOneCategory(
                                categoryId: widget.categoryID, query: query);
                      },
                    ),
                  );
                  // } else {
                  //   return SliverFillRemaining(
                  //     child: CustomNoInternetAndErrorView(
                  //       errorMessage: state.errorMessage,
                  //       onTryAgainButton: () {
                  //         BlocProvider.of<ServicesCategoryCubit>(context)
                  //             .fetchServicesForOneCategory(
                  //                 categoryId: widget.categoryID, query: query);
                  //       },
                  //     ),
                  //   );
                  // }
                } else if (state is ServicesCategoryLoading) {
                  return SliverFillRemaining(
                    child: Center(
                      child: CustomCircularProgressIndicator(),
                    ),
                  );
                } else {
                  return SliverFillRemaining(child: SizedBox());
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
