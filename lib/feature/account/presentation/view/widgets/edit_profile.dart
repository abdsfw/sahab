import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sahab_project/core/const.dart';
import 'package:sahab_project/core/theme/app_color.dart';
import 'package:sahab_project/core/theme/app_textsyle.dart';
import 'package:sahab_project/core/utils/cache/cache_helper.dart';
import 'package:sahab_project/core/utils/icons/app_icons.dart';
import 'package:sahab_project/core/utils/widgets/app_button.dart';
import 'package:sahab_project/core/utils/widgets/circular_progress_indicator.dart';
import 'package:sahab_project/core/utils/widgets/custom_simple_app_bar_widget.dart';
import 'package:sahab_project/feature/account/presentation/manager/account_cubit/account_cubit.dart';
import 'package:sahab_project/feature/account/presentation/view/widgets/custom_text_faield.dart';
import 'package:sahab_project/feature/account/presentation/view/widgets/edit_pic.dart';

import '../../../../../generated/l10n.dart';
import 'terminate_button.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  // todo : finish translate
  @override
  Widget build(BuildContext context) {
    AccountCubit accountCubit = AccountCubit.get(context);
    accountCubit.getControllerValue();

    // accountCubit.startEdit();
    return WillPopScope(
      onWillPop: () async {
        accountCubit.setUserInfo();

        return true;
      },
      child: Scaffold(
        backgroundColor: AppColor.pageBackGround,
        body: SafeArea(
          child: ListView(
            padding: const EdgeInsets.all(0),
            children: [
              CustomSimpleAppBarWidget(
                onIconTap: () {
                  Navigator.of(context).pop();
                  accountCubit.setUserInfo();
                },
                iconPath: AppIcons.backArrow,
                appBarTitle: S.of(context).edit_profile,
              ),
              SizedBox(
                height: 20.h,
              ),
              Padding(
                padding: EdgeInsetsDirectional.only(start: 16.w),
                child: Text(
                  S.of(context).profile_photo,
                  style: AppStyles.style14(context).copyWith(
                      fontWeight: FontWeight.w500, color: AppColor.brownColor),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 16.w),
                child: const ProfilePhotoPicker(),
              ),
              SizedBox(
                height: 26.h,
              ),
              TextForEditScreen(text: S.of(context).name_),
              SizedBox(
                height: 10.h,
              ),
              CustomTextInput(
                hintText: "",
                textEditingController: accountCubit.userNameController,
              ),
              SizedBox(
                height: 30.h,
              ),
              TextForEditScreen(text: S.of(context).email_),
              SizedBox(
                height: 10.h,
              ),
              CustomTextInput(
                hintText: "",
                textEditingController: accountCubit.userEmailController,
              ),
              SizedBox(
                height: 30.h,
              ),
              TextForEditScreen(text: S.of(context).phone_number_),
              SizedBox(
                height: 10.h,
              ),
              CustomTextInput(
                hintText: "",
                textEditingController: accountCubit.userPhoneController,
              ),
              SizedBox(height: 54.h),
              //? this blue button to edit account
              BlocConsumer<AccountCubit, AccountState>(
                listener: (context, state) async {
                  if (state is AccountEditSuccess) {
                    await CacheHelper.setData(
                        key: Constant.kUserImage, value: state.newImagePath);
                    await CacheHelper.setData(
                      key: Constant.kUserPhoneNumber,
                      value: accountCubit.userPhoneController.text,
                    );
                    await CacheHelper.setData(
                      key: Constant.kUserName,
                      value: accountCubit.userNameController.text,
                    );
                    await CacheHelper.setData(
                      key: Constant.kUserEmail,
                      value: accountCubit.userEmailController.text,
                    );
                    accountCubit.setAllUserInfo();
                    showDialog(
                      context: context,
                      builder: (context) {
                        return SuccessFailureDialog(
                          title: S.of(context).success, //'Success',
                          body: S
                              .of(context)
                              .account_updated_successfully, //"Account Updated Successfully!",
                          // لقد تم تعديل حسابك بنجاح
                        );
                      },
                    );
                  } else if (state is AccountEditFailure) {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return SuccessFailureDialog(
                          title: S
                              .of(context)
                              .error_in_edit_account, //'Error in edit account',
                          body: state.errorMessage,
                        );
                      },
                    );
                    accountCubit.getControllerValue();
                  }
                },
                builder: (context, state) {
                  print(state);
                  if (state is AccountEditLoading) {
                    return Center(
                      child: CustomCircularProgressIndicator(),
                    );
                  } else {
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: AppButton(
                          width: double.infinity,
                          height: 50.h,
                          onTap: () async {
                            await accountCubit.editAccount(
                                phone: accountCubit.userPhoneController.text,
                                name: accountCubit.userNameController.text,
                                email: accountCubit.userEmailController.text,
                                imagePath: accountCubit.imagePath ?? "");
                          },
                          text: S.of(context).update,
                          color: AppColor.blueColor,
                          radius: 5,
                          fontSize: 16,
                          fontFamily: AppStyles.getFontFamily(context),
                          textColor: Colors.white,
                          fontWeight: FontWeight.w600),
                    );
                  }
                },
              ),
              SizedBox(height: 90.h),
              //? this red button to terminate account
              const TerminateButton(),
              SizedBox(
                height: 34.h,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SuccessFailureDialog extends StatelessWidget {
  const SuccessFailureDialog({
    super.key,
    required this.title,
    required this.body,
  });
  final String title, body;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColor.whiteColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      title: Text(
        title,
        style: AppStyles.style16(context).copyWith(
            color: AppColor.darkBlueColor, fontWeight: FontWeight.w600),
      ),
      content: Text(
        body,
        style: AppStyles.style14(context).copyWith(color: AppColor.brownColor),
      ),
      actions: [
        Row(
          children: [
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop();
              },
              child: Container(
                width: 73.w,
                height: 40.h,
                decoration: ShapeDecoration(
                  color: const Color(0xFF567AB8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                child: Center(
                  child: Text(
                    "Ok",
                    style: AppStyles.style16(context).copyWith(
                      fontWeight: FontWeight.w600,
                      color: AppColor.whiteColor,
                    ),
                  ),
                ),
              ),
            )
          ],
        )
      ],
    );
  }
}
// Widget _buildImageWidget(AccountState state, AccountCubit accountCubit) {
//     if (state is StarEditAccount) {
//       // Display image from URL
//       return Image.network(
//         "",
//         width: 96,
//         height: 96,
//         fit: BoxFit.cover,
//       );
//     } else if (state is AccountAnotherImage || state is AccountEditFailure) {
//       // Display image from file or placeholder if image loading failed
//       return state is AccountAnotherImage
//           ? Image.file(
//               state.image,
//               width: 96,
//               height: 96,
//               fit: BoxFit.cover,
//             )
//           : SvgPicture.asset(AppIcons.person);
//     } else {
//       return SvgPicture.asset(AppIcons.person);
//     }
//   }
// }
