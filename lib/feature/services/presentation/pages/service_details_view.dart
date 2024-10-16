import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sahab_project/core/theme/app_color.dart';
import 'package:sahab_project/core/theme/app_textsyle.dart';
import 'package:sahab_project/core/utils/icons/app_icons.dart';
import 'package:sahab_project/core/utils/widgets/circular_progress_indicator.dart';
import 'package:sahab_project/core/utils/widgets/custom_no_internet_and_error_view.dart';
import 'package:sahab_project/core/utils/widgets/custom_simple_app_bar_widget.dart';
import 'package:sahab_project/core/utils/widgets/details_title.dart';
import 'package:sahab_project/feature/places/presentation/pages/book_now.dart';
import 'package:sahab_project/feature/services/data/model/service.dart';
import 'package:sahab_project/feature/services/data/model/service_details_model/service_details_model.dart';
import 'package:sahab_project/feature/services/presentation/manager/service_details_home_cubit/service_details_home_cubit.dart';
import 'package:sahab_project/feature/services/presentation/pages/booking_service_page.dart';
import 'package:sahab_project/feature/services/presentation/widgets/service_details_card_scroll.dart';
import 'package:sahab_project/feature/services/data/model/service.dart';

import '../../../../generated/l10n.dart';

class ServiceDetailsView extends StatelessWidget {
  const ServiceDetailsView({
    super.key,
    required this.serviceId,
  });
  final int serviceId;
  // final Services service;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ServiceDetailsHomeCubit()
        ..fetchServiceDetails(context, ID: serviceId),
      child: Scaffold(
        body: Column(
          children: [
            CustomSimpleAppBarWidget(
              // iconPath: AppIcons.backArrow,
              appBarTitle: S.of(context).service_details,
            ),
            BlocBuilder<ServiceDetailsHomeCubit, ServiceDetailsHomeState>(
              builder: (context, state) {
                if (state is LoadingDetailsHomeState) {
                  return Expanded(
                    child: Center(
                      child: CustomCircularProgressIndicator(),
                    ),
                  );
                } else if (state is FailureDetailsHomeState) {
                  return Expanded(child: CustomNoInternetAndErrorView(
                    onTryAgainButton: () {
                      BlocProvider.of<ServiceDetailsHomeCubit>(context)
                          .fetchServiceDetails(context, ID: serviceId);
                    },
                  ));
                } else if (state is SuccessDetailsHomeState) {
                  return ServiceDetailsViewBody(
                    details: state.details,
                  );
                }
                return SizedBox();
              },
            ),
          ],
        ),
      ),
    );
  }
}

class ServiceDetailsViewBody extends StatelessWidget {
  const ServiceDetailsViewBody({
    super.key,
    required this.details,
  });
  final ServiceDetailsModel details;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView(
        padding: const EdgeInsets.all(0),
        children: [
          Padding(
            padding: const EdgeInsets.all(0.0),
            child: ServiceDetailsCardScroll(
              borderRadius: BorderRadius.zero,
              color: Colors.transparent,
              boxShadow: [],
              rating: details.rating ?? "0.0",
              price: details.price ?? 0,
              title: details.title ?? "null",
              serviceImages:
                  details.serviceImages?.map((e) => e.image ?? "").toList() ??
                      [],
            ),
          ),
          const Divider(),
          SizedBox(
            height: 16.h,
          ),
          DetailsTitle(
            title: S.of(context).service_duration,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Text(
              "${details.duration} ${S.of(context).hour}",
              style: AppStyles.style16(context).copyWith(
                  fontWeight: FontWeight.w500, color: AppColor.greyColor),
            ),
          ),
          SizedBox(
            height: 38.h,
          ),
          DetailsTitle(
            title: S.of(context).about_service,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Text(
              details.description ?? "null", //
              // "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type",
              style: AppStyles.style16(context)
                  .copyWith(color: AppColor.greyColor),
            ),
          ),
          // const Expanded(child: SizedBox()),
          SizedBox(
            height: 26.h,
          ),
          GestureDetector(
            onTap: () {
              // Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //       builder: (context) => const BookNow(),
              //     ));
            },
            child: GestureDetector(
              onTap: () {
                print(details.id);
                print(details.price);
                Navigator.push(
                  context,
                  CupertinoPageRoute(
                    builder: (context) => BookingServicePage(
                      serviceID: details.id ?? -1,
                      price: details.price ?? 0,
                      serviceTitle: details.title ?? "",
                    ),
                  ),
                );
              },
              child: Container(
                margin: EdgeInsets.only(right: 16.w, bottom: 20.h, left: 16.w),
                height: 50.h,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: AppColor.blueColor,
                ),
                child: Center(
                  child: Text(
                    S.of(context).book_now,
                    style: AppStyles.style16(context).copyWith(
                        fontWeight: FontWeight.w600, color: Colors.white),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
