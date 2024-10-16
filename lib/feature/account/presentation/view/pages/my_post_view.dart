import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:sahab_project/core/utils/functions/function.dart';
import 'package:sahab_project/core/utils/widgets/circular_progress_indicator.dart';
import 'package:sahab_project/feature/account/presentation/manager/my_post_cubit/my_post_cubit.dart';
import 'package:sahab_project/feature/account/presentation/manager/place_post_vendor_cubit/place_post_vendor_cubit.dart';
import 'package:sahab_project/feature/account/presentation/manager/service_post_vendor_cubit/service_post_vendor_cubit.dart';
import 'package:sahab_project/feature/account/presentation/manager/toggle_place_service_cubit/toggle_place_service_cubit.dart';

import '../../../../../generated/l10n.dart';
import '../widgets/my_post_body.dart';

class MyPostView extends StatelessWidget {
  const MyPostView({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => MyPostCubit(),
        ),
        BlocProvider(
          create: (context) => TogglePlaceServiceCubit(),
        ),
        BlocProvider(
          create: (context) =>
              PlacePostVendorCubit()..getVendorPlacePosts(context),
        ),
        BlocProvider(
          create: (context) =>
              ServicePostVendorCubit()..getVendorServicePosts(context),
        ),
      ],
      child: WillPopScope(
        onWillPop: () async {
          return true;
        },
        child: BlocConsumer<MyPostCubit, MyPostState>(
          listener: (context, state) {
            if (state is ManageAndDeletePlaceSuccessState) {
              BlocProvider.of<PlacePostVendorCubit>(context)
                  .getVendorPlacePosts(context);
            } else if (state is ManageAndDeleteServiceSuccessState) {
              BlocProvider.of<ServicePostVendorCubit>(context)
                  .getVendorServicePosts(context);
            } else if (state is ManageAndDeleteFailureState) {
              AppFunction.confirmDialog(
                context,
                title: S
                    .of(context)
                    .an_error_occurred_while_deleting, // "An error occurred while deleting",
                onYesTap: () {
                  Navigator.of(context).pop();
                },
              );
            }
          },
          builder: (context, state) {
            return ModalProgressHUD(
              inAsyncCall: state is ManageAndDeleteLoadingState,
              progressIndicator: CustomCircularProgressIndicator(),
              child: const Scaffold(
                body: MyPostBody(),
              ),
            );
          },
        ),
      ),
    );
  }
}
