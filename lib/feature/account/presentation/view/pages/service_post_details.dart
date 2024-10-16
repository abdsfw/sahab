import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:sahab_project/core/enums/type_post_enum.dart';
import 'package:sahab_project/core/theme/app_color.dart';
import 'package:sahab_project/core/theme/app_textsyle.dart';
import 'package:sahab_project/core/utils/functions/function.dart';
import 'package:sahab_project/core/utils/widgets/circular_progress_indicator.dart';
import 'package:sahab_project/core/utils/widgets/custom_no_internet_and_error_view.dart';
import 'package:sahab_project/core/utils/widgets/custom_scroll_photo_widget.dart';
import 'package:sahab_project/core/utils/widgets/custom_simple_app_bar_widget.dart';
import 'package:sahab_project/core/utils/widgets/custom_two_button.dart';
import 'package:sahab_project/core/utils/widgets/details_title.dart';
import 'package:sahab_project/feature/account/data/model/service_model/service_model.dart';
import 'package:sahab_project/feature/account/presentation/manager/details_delete_cubit/details_delete_cubit.dart';
import 'package:sahab_project/feature/account/presentation/manager/details_vendor_post_cubit/details_vendor_post_cubit.dart';
import 'package:sahab_project/feature/account/presentation/view/pages/place_post_details.dart';
import 'package:sahab_project/feature/add_edit_post/presentation/views/add_post_home_page.dart';
import 'package:sahab_project/feature/places/presentation/widgets/description_widget.dart';
import 'package:sahab_project/generated/l10n.dart';

class ServicePostDetails extends StatelessWidget {
  const ServicePostDetails({super.key, required this.postId});
  final int postId;
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => DetailsVendorPostCubit()
            ..getDetailsServicePost(context, serviceId: postId),
        ),
        BlocProvider(
          create: (context) => DetailsDeleteCubit(),
        ),
      ],
      child: BlocConsumer<DetailsDeleteCubit, DetailsDeleteState>(
        listener: (context, state) {
          // TODO: implement listener
          if (state is SuccessDeletePostState) {
            Navigator.of(context).pop("success");
          } else if (state is FailureDeletePostState) {
            AppFunction.confirmDialog(
              context,
              title: S.of(context).an_error_occurred_while_deleting,
              onYesTap: () {
                Navigator.of(context).pop();
              },
            );
          }
        },
        builder: (context, state) {
          return ModalProgressHUD(
            inAsyncCall: state is LoadingDeletePostState,
            progressIndicator: CustomCircularProgressIndicator(),
            child: Scaffold(
              body: Column(
                children: [
                  CustomSimpleAppBarWidget(
                    appBarTitle: S.of(context).service_details,
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  BlocBuilder<DetailsVendorPostCubit, DetailsVendorPostState>(
                    builder: (context, state) {
                      if (state is LoadingGetDetailsPostState) {
                        return Expanded(
                          child: Center(
                            child: CustomCircularProgressIndicator(),
                          ),
                        );
                      } else if (state is FailureGetDetailsPostState) {
                        return Expanded(
                          child: CustomNoInternetAndErrorView(
                            onTryAgainButton: () {
                              BlocProvider.of<DetailsVendorPostCubit>(context)
                                  .getDetailsServicePost(context,
                                      serviceId: postId);
                            },
                          ),
                        );
                      } else if (state is SuccessGetDetailsPostServiceState) {
                        return Expanded(
                          child: ServicePostDetailsBody(
                            serviceModel: state.serviceModel,
                          ),
                        );
                      }
                      return SizedBox();
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class ServicePostDetailsBody extends StatelessWidget {
  const ServicePostDetailsBody({
    super.key,
    required this.serviceModel,
  });
  final ServiceModel serviceModel;
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        PictureAndTitleSection(
          postImageList:
              serviceModel.serviceImages?.map((e) => e.image ?? "").toList() ??
                  [],
          postTitle: serviceModel.title ?? "null",
          //? here in second title we should put title category
          secondTitle: serviceModel.title ?? "null",
          rating: serviceModel.rating,
        ),
        Divider(),
        DetailsTitle(title: S.of(context).service_duration),
        // SizedBox(
        //   height: 10.h,
        // ),
        Padding(
          padding: const EdgeInsetsDirectional.only(start: 16),
          child: Text(
            "${serviceModel.duration} ${S.of(context).hours}",
            style: AppStyles.textStyle18w500DarkBlue(context).copyWith(
              fontWeight: FontWeight.w400,
              color: Colors.black,
            ),
          ),
        ),
        SizedBox(
          height: 10.h,
        ),
        DetailsTitle(
          title: S.of(context).about_service,
        ),
        DescriptionWidget(
          content: serviceModel.description ?? "nothings",
        ),

        Padding(
          padding: EdgeInsetsDirectional.only(
            start: 16.w,
            end: 16.w,
            bottom: 30.h,
          ),
          child: CustomTwoButton(
            buttonColor1: AppColor.blueColor,
            buttonColor2: AppColor.redColor,
            onTap1: () {
              Navigator.of(context)
                  .push(
                CupertinoPageRoute(
                  builder: (context) => AddPostHomePage(
                    isEdit: true,
                    postID: serviceModel.id,
                    typeToggle: TypeToggle.service,
                  ),
                ),
              )
                  .then((value) {
                if (value != null) {
                  if (value["successMessage"] == "success")
                    BlocProvider.of<DetailsVendorPostCubit>(context)
                        .getDetailsServicePost(context,
                            serviceId: serviceModel.id ?? -1);
                }
              });
            },
            onTap2: () {
              AppFunction.deleteQuestionDialog(
                context,
                title: S.of(context).delete_post, // "Delete Post",
                text1: S
                    .of(context)
                    .first_delete_post_message, // "Are you sure want to Delete This Post",
                text2: S.of(context).second_delete_reservation_message,
                onYesTap: () async {
                  // if (typeToggle == TypeToggle.place) {
                  BlocProvider.of<DetailsDeleteCubit>(context)
                      .deleteVendorServicePost(
                          serviceId: serviceModel.id ?? -1);
                  Navigator.of(context).pop();
                  // print("place");
                  // } else {
                  //   print("service");
                  //   print(postID);
                  //   BlocProvider.of<MyPostCubit>(context)
                  //       .deleteVendorServicePost(serviceId: postID);
                  //   Navigator.of(context).pop();
                  // }
                },
                onNoTap: () {
                  Navigator.of(context).pop();
                },
                isLoading: false,
              );
            },
            text1: S.of(context).edit, //"edit",
            text2: S.of(context).delete, //"delete",
            textColor1: AppColor.whiteColor,
            textColor2: AppColor.whiteColor,
          ),
        ),
      ],
    );
  }
}
