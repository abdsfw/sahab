import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sahab_project/core/theme/app_color.dart';
import 'package:sahab_project/core/theme/app_textsyle.dart';
import 'package:sahab_project/core/utils/functions/function.dart';
import 'package:sahab_project/core/utils/icons/app_icons.dart';
import 'package:sahab_project/core/utils/widgets/app_button.dart';
import 'package:sahab_project/core/utils/widgets/circular_progress_indicator.dart';
import 'package:sahab_project/core/utils/widgets/custom_input_field.dart';
import 'package:sahab_project/core/utils/widgets/custom_simple_app_bar_widget.dart';
import 'package:sahab_project/feature/account/presentation/manager/contact_cubit/contact_cubit.dart';
import 'package:sahab_project/feature/account/presentation/manager/static_page_cubit/static_page_cubit.dart';

import '../../../../../generated/l10n.dart';
import '../widgets/custom_text_faield.dart';

// ignore: must_be_immutable
class ContactScreen extends StatelessWidget {
  const ContactScreen({super.key});
// todo : finish translate
  @override
  Widget build(BuildContext context) {
    ContactCubit contactCubit = ContactCubit.get(context);
    StaticPageCubit staticPageCubit = StaticPageCubit.get(context);

    // staticPageCubit.getInstagramLink();
    // staticPageCubit.getWhatsAppLink();
    // staticPageCubit.getXLink();
    return WillPopScope(
      onWillPop: () async {
        contactCubit.disposeControllers();
        return true;
      },
      child: Scaffold(
        backgroundColor: AppColor.pageBackGround,
        body: Column(
          children: [
            CustomSimpleAppBarWidget(
              appBarTitle: S.of(context).contact_us,
              onIconTap: () {
                Navigator.of(context).pop();
                contactCubit.disposeControllers();
              },
            ),
            Form(
              key: contactCubit.contactForm,
              child: BlocConsumer<StaticPageCubit, StaticPageState>(
                listener: (context, state) {},
                builder: (context, state) {
                  if (state is StaticPageLoading) {
                    return Expanded(
                      child: Center(
                        child: CustomCircularProgressIndicator(),
                      ),
                    );
                  } else {
                    return Expanded(
                      child: ListView(
                        padding: EdgeInsets.zero,
                        // crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 42.h,
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.symmetric(
                                horizontal: 15.w),
                            child: TextForEditScreen(text: S.of(context).name_),
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 15.w),
                            child: CustomInputField(
                              hintText: S.of(context).enter_here,
                              controller: contactCubit.nameController,
                              validator: (nameValue) {
                                if (nameValue!.isEmpty) {
                                  return S
                                      .of(context)
                                      .please_enter_a_name; //'Please enter a name';
                                }
                                return null;
                              },
                            ),
                          ),
                          SizedBox(
                            height: 21.h,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 15.w),
                            child: TextForEditScreen(
                                text: S.of(context).phone_number_),
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 15.w),
                            child: CustomInputField(
                              hintText: S.of(context).enter_here,
                              keyboardType: TextInputType.phone,
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                    RegExp(r'[0-9+]'))
                              ],
                              controller: contactCubit.phoneController,
                              validator: (phoneValue) {
                                if (phoneValue!.isEmpty) {
                                  return S
                                      .of(context)
                                      .please_enter_a_phone_number; // 'Please enter a phone number';
                                } else if (phoneValue.length != 8) {
                                  return S
                                      .of(context)
                                      .the_mobile_must_be_8_digits; //"The Mobile must be 8 digits";
                                }
                                return null; // Return null if the validation succeeds
                              },
                            ),
                          ),
                          SizedBox(
                            height: 21.h,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 15.w),
                            child:
                                TextForEditScreen(text: S.of(context).email_),
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 15.w),
                            child: CustomInputField(
                              hintText: S.of(context).enter_here,
                              controller: contactCubit.emailController,
                              validator: (emailValue) {
                                if (emailValue!.isEmpty) {
                                  return S
                                      .of(context)
                                      .please_enter_an_email_address; //'Please enter an email address'; // Return an error message if the field is empty
                                } else if (!emailValue.contains('@')) {
                                  return S
                                      .of(context)
                                      .e_mail_must_contains_; //"E-mail must contains @";
                                }

                                return null; // Return null if the validation succeeds
                              },
                            ),
                          ),
                          SizedBox(
                            height: 21.h,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 15.w),
                            child: CustomInputField(
                              hintText: S.of(context).enter_here,
                              controller: contactCubit.messageController,
                              minLine: 4,
                              maxLine: 4,
                              validator: (messageValue) {
                                if (messageValue!.isEmpty) {
                                  return S
                                      .of(context)
                                      .please_enter_a_message; //'Please enter a message'; // Return an error message if the field is empty
                                }

                                return null; // Return null if the validation succeeds
                              },
                            ),
                          ),
                          SizedBox(height: 30.h),
                          BlocConsumer<ContactCubit, ContactState>(
                            listener: (context, state) {
                              if (state is ContactSuccess) {
                                AppFunction.confirmDialog(
                                  context,
                                  title: S.of(context).success,
                                  text1:
                                      S.of(context).the_message_be_send_success,
                                  onYesTap: () {
                                    Navigator.of(context).pop();
                                  },
                                );
                                contactCubit.messageController.clear();
                              } else if (state is ContactFailure) {
                                AppFunction.confirmDialog(
                                  context,
                                  title: S.of(context).general_error,
                                  onYesTap: () {
                                    Navigator.of(context).pop();
                                  },
                                );
                              }
                            },
                            builder: (context, state) {
                              if (state is ContactLoading) {
                                return Center(
                                    child: CustomCircularProgressIndicator());
                              } else {
                                return Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 15.w),
                                  child: AppButton(
                                      height: 50.h,
                                      width: double.infinity,
                                      onTap: () async {
                                        await contactCubit.sendMessage();
                                      },
                                      text: S.of(context).submit,
                                      color: AppColor.blueColor,
                                      radius: 5,
                                      fontSize: 16,
                                      fontFamily:
                                          AppStyles.getFontFamily(context),
                                      textColor: Colors.white,
                                      fontWeight: FontWeight.w600),
                                );
                              }
                            },
                          ),
                          SizedBox(height: 30.h),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 15.w),
                            child: Text(
                              S.of(context).reach_out_to_us,
                              style: AppStyles.style17semibold(context),
                            ),
                          ),
                          SizedBox(height: 12.h),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 15.w),
                            child: Row(
                              children: [
                                GestureDetector(
                                    onTap: () {
                                      contactCubit.launchInWebView(
                                          staticPageCubit.whatAppLink);
                                    },
                                    child: SvgPicture.asset(AppIcons.whatsapp)),
                                SizedBox(
                                  width: 14.w,
                                ),
                                GestureDetector(
                                    onTap: () {
                                      contactCubit.launchInWebView(
                                          staticPageCubit.facebookLink);
                                    },
                                    child: SvgPicture.asset(AppIcons.facebook)),
                                SizedBox(
                                  width: 14.w,
                                ),
                                GestureDetector(
                                    onTap: () {
                                      contactCubit.launchInWebView(
                                          staticPageCubit.instagramLink);
                                    },
                                    child:
                                        SvgPicture.asset(AppIcons.instagram)),
                                SizedBox(
                                  width: 14.w,
                                ),
                                GestureDetector(
                                    onTap: () {
                                      contactCubit.launchInWebView(
                                          staticPageCubit.xLink);
                                    },
                                    child: SvgPicture.asset(AppIcons.x)),
                              ],
                            ),
                          ),
                          SizedBox(height: 40.h),
                        ],
                      ),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
