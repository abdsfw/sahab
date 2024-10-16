import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sahab_project/core/theme/app_color.dart';
import 'package:sahab_project/core/utils/icons/app_icons.dart';
import 'package:sahab_project/core/utils/widgets/custom_simple_app_bar_widget.dart';
import 'package:sahab_project/feature/services/presentation/manager/service_cubit/service_cubit.dart';
import '../../../../generated/l10n.dart';
import '../widgets/service_card.dart';
import '../widgets/shimmer_services_card.dart';

class ServicesView extends StatelessWidget {
  const ServicesView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: ServicesViewBody(),
    );
  }
}

class ServicesViewBody extends StatelessWidget {
  const ServicesViewBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ServiceCubit serviceCubit = ServiceCubit.get(context);

    return Column(
      children: [
        CustomSimpleAppBarWidget(
          // onIconTap: () {
          //   Navigator.of(context).pop();
          // },
          iconPath: AppIcons.backArrow,
          appBarTitle: S.of(context).services,
        ),
        SizedBox(
          height: 45.h,
        ),
        Expanded(
          child: BlocConsumer<ServiceCubit, ServiceState>(
            listener: (context, state) {},
            builder: (context, state) {
              return RefreshIndicator(
                color: AppColor.blueColor,
                onRefresh: () async {
                  await serviceCubit.fetchServices(context);
                },
                child: state is ServiceLoadFailure
                    ? const SizedBox()
                    //! loading state show shimmer widget
                    : state is ServiceLoading
                        ? ListView.builder(
                            itemCount: 5,
                            itemBuilder: (context, index) {
                              return const ShimmerServicesCard();
                            },
                          )
                        : ListView.builder(
                            itemCount: serviceCubit.fetchServiceList.length,
                            itemBuilder: (context, index) {
                              return ServicesCard(
                                sized: 50,
                                category: serviceCubit.fetchServiceList[index],
                              );
                            },
                          ),
              );
            },
          ),
        ),
      ],
    );
  }
}
