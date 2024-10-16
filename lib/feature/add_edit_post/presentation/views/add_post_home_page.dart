import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:sahab_project/core/enums/type_adv_enum.dart';
import 'package:sahab_project/core/enums/type_post_enum.dart';
import 'package:sahab_project/core/theme/app_color.dart';
import 'package:sahab_project/core/theme/app_textsyle.dart';
import 'package:sahab_project/core/utils/functions/function.dart';
import 'package:sahab_project/core/utils/icons/app_icons.dart';
import 'package:sahab_project/core/utils/widgets/app_button.dart';
import 'package:sahab_project/core/utils/widgets/circular_progress_indicator.dart';
import 'package:sahab_project/core/utils/widgets/custom_no_internet_and_error_view.dart';
import 'package:sahab_project/core/utils/widgets/custom_simple_app_bar_widget.dart';
import 'package:sahab_project/feature/account/presentation/manager/place_post_vendor_cubit/place_post_vendor_cubit.dart';
import 'package:sahab_project/feature/account/presentation/manager/service_post_vendor_cubit/service_post_vendor_cubit.dart';
import 'package:sahab_project/feature/add_edit_post/presentation/manager/main_post_page_cubit/main_post_page_cubit.dart';
import 'package:sahab_project/feature/add_edit_post/presentation/manager/next_post_place_cubit/next_post_place_cubit.dart';
import 'package:sahab_project/feature/add_edit_post/presentation/manager/next_post_service_cubit/next_post_service_cubit.dart';
import 'package:sahab_project/feature/add_edit_post/presentation/manager/page_view_cubit/page_view_cubit.dart';
import 'package:sahab_project/feature/add_edit_post/presentation/manager/select_photo_cubit/select_photo_cubit.dart';
import 'package:sahab_project/feature/add_edit_post/presentation/manager/special_date_cubit/special_date_cubit.dart';
import 'package:sahab_project/feature/add_edit_post/presentation/manager/special_days_view_cubit/special_days_view_cubit.dart';
import '../../../../generated/l10n.dart';
import '../manager/add_post_cubit/add_post_cubit.dart';
import '../manager/toggle_cubit/toggle_cubit.dart';
import 'widget/data_input_add_post_widget.dart';
import 'widget/top_section_widget.dart';

class AddPostHomePage extends StatelessWidget {
  const AddPostHomePage({
    super.key,
    required this.isEdit,
    this.postID,
    this.typeToggle = TypeToggle.place,
  });
  final bool isEdit;
  final int? postID;
  final TypeToggle typeToggle;
  // todo : finish translate
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ToggleCubit()..changeAddPostTo(typeToggle),
        ),
        BlocProvider(
          create: (context) => SelectPhotoCubit(),
        ),
        BlocProvider(
          create: (context) => AddPostCubit(),
        ),
        BlocProvider(
          create: (context) => NextPostServiceCubit(),
        ),
        BlocProvider(
          create: (context) => PageViewCubit(),
        ),
        BlocProvider(
          create: (context) => SpecialDaysViewCubit(),
        ),
        BlocProvider(
          create: (context) => MainPostPageCubit()
            ..fetchAllDropDownListsData(
              context,
              isEdit: isEdit,
              postId: postID,
              typeToggle: typeToggle,
            ),
        ),
      ],
      child: WillPopScope(
        onWillPop: () async {
          //? this clear line is necessary because the cubit defined in material app
          BlocProvider.of<NextPostPlaceCubit>(context).clearControllers();
          //? -----------------------------------------------------------------------
          //! this clear line is not necessary because the cubit will close after pop.
          // BlocProvider.of<NextPostServiceCubit>(context).clearControllers();
          //! ------------------------------------------------------------------------
          Navigator.of(context).pop();
          return false;
        },
        child: Scaffold(
          body: BlocBuilder<MainPostPageCubit, MainPostPageState>(
            builder: (context, state) {
              if (state is GetAllDropDownListLoadingState) {
                return const Center(
                  child: CustomCircularProgressIndicator(),
                );
              } else if (state is GetAllDropDownListFailureState) {
                return CustomNoInternetAndErrorView(
                  onTryAgainButton: () {
                    BlocProvider.of<MainPostPageCubit>(context)
                        .fetchAllDropDownListsData(
                      context,
                      isEdit: isEdit,
                      postId: postID,
                      typeToggle: typeToggle,
                    );
                  },
                  withReturn: true,
                );
              } else if (state is GetAllDropDownListSuccessState) {
                //? this for manage add - edit state
                return BlocConsumer<AddPostCubit, AddPostState>(
                  listener: (context, state) {
                    if (state is SuccessAddEditPostState) {
                      AppFunction.questionDialog(
                        context,
                        title: S.of(context).success, //"Success",
                        // "Thank you,  we have successfully posted your ad",
                        text1: S.of(context).add_post_success_message,
                        onYesTap: () {
                          // PlacePostVendorCubit()..getVendorPlacePosts()
                          Navigator.of(context).pop();
                          Navigator.of(context).pop({
                            "successMessage": "success",
                            "typeToggle": typeToggle
                          });
                        },
                      );
                    } else if (state is FailureAddEditPostState) {
                      AppFunction.confirmDialog(
                        context,
                        title: S
                            .of(context)
                            .general_error, //"there was an error please try later",
                        onYesTap: () {
                          Navigator.of(context).pop();
                        },
                      );
                    }
                  },
                  builder: (context, state) {
                    return ModalProgressHUD(
                      inAsyncCall: state is LoadingAddEditPostState,
                      progressIndicator:
                          const CustomCircularProgressIndicator(),
                      child: Column(
                        // mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //? Custom App Bar widget
                          CustomSimpleAppBarWidget(
                            onIconTap: () {
                              //? this clear line is necessary because the cubit defined in material app
                              BlocProvider.of<NextPostPlaceCubit>(context)
                                  .clearControllers();

                              //! this clear line is not necessary because the cubit will close after pop.
                              // BlocProvider.of<NextPostServiceCubit>(context).clearControllers();
                              Navigator.of(context).pop();
                            },
                            iconPath: AppIcons.backArrow,
                            appBarTitle: isEdit
                                ? S.of(context).edit_post
                                : S.of(context).add_post, //"Add Post",
                          ),
                          //? ----------------------------------------------------
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16.w),
                              child: Column(
                                children: [
                                  SizedBox(height: 24.h),

                                  //? step widget and choosing button ( place - services )
                                  TopSectionWidget(
                                    isEdit: isEdit,
                                  ),
                                  //? ----------------------------------------------------

                                  SizedBox(height: 35.h),

                                  //? fields that should entered like title, select category , etc...
                                  DataInputAddPostWidget(
                                    isEdit: isEdit,
                                    postID: postID,
                                  ),
                                  //? ----------------------------------------------------
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              }
              return const SizedBox();
            },
          ),
        ),
        /*
        BlocBuilder<MainPostPageCubit, MainPostPageState>(
          builder: (context, state) {
            if (state is GetAllDropDownListLoadingState) {
              return const Center(
                child: CustomCircularProgressIndicator(),
              );
            } else if (state is GetAllDropDownListFailureState) {
              return CustomNoInternetView(
                onTryAgainButton: () {
                  BlocProvider.of<MainPostPageCubit>(context)
                      .fetchAllDropDownListsData(context);
                },
              );
            } else if (state is GetAllDropDownListSuccessState) {
              return Scaffold(
                body: Column(
                  // mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //? Custom App Bar widget
                    CustomSimpleAppBarWidget(
                      onIconTap: () {
                        //? this clear line is necessary because the cubit defined in material app
                        BlocProvider.of<NextPostPlaceCubit>(context)
                            .clearControllers();

                        //! this clear line is not necessary because the cubit will close after pop.
                        // BlocProvider.of<NextPostServiceCubit>(context).clearControllers();
                        Navigator.of(context).pop();
                      },
                      iconPath: AppIcons.backArrow,
                      appBarTitle: "Add Post",
                    ),
                    //? ----------------------------------------------------
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        child: Column(
                          children: [
                            SizedBox(height: 24.h),

                            //? step widget and choosing button ( place - services )
                            TopSectionWidget(
                              isEdit: isEdit,
                            ),
                            //? ----------------------------------------------------

                            SizedBox(height: 35.h),

                            //? fields that should entered like title, select category , etc...
                            DataInputAddPostWidget(
                              isEdit: isEdit,
                            ),
                            //? ----------------------------------------------------
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return const SizedBox();
            }
          },
        ),
        */
      ),
    );
  }
}
