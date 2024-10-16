import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:sahab_project/core/const.dart';
import 'package:sahab_project/core/enums/type_post_enum.dart';
import 'package:sahab_project/core/theme/app_color.dart';
import 'package:sahab_project/core/theme/app_textsyle.dart';
import 'package:sahab_project/core/utils/icons/app_icons.dart';
import 'package:sahab_project/core/utils/widgets/app_button.dart';
import 'package:sahab_project/core/utils/widgets/circular_progress_indicator.dart';
import 'package:sahab_project/core/utils/widgets/custom_no_internet_and_error_view.dart';
import 'package:sahab_project/core/utils/widgets/custom_simple_app_bar_widget.dart';
// import 'package:sahab_project/feature/Bookings/presentation/views/booking_places_page.dart';
import 'package:sahab_project/core/enums/payment_way_enum.dart';
import 'package:sahab_project/feature/checkout/data/model/payment_method.dart';
import 'package:sahab_project/feature/checkout/presentation/manager/can_pay_cubit/can_pay_cubit.dart';
import 'package:sahab_project/feature/checkout/presentation/manager/checkout_cubit/checkout_cubit.dart';
import 'package:sahab_project/feature/checkout/presentation/manager/payment_cubit/payment_cubit.dart';
import 'package:sahab_project/feature/checkout/presentation/manager/promo_code_cubit/promo_code_cubit.dart';
import 'package:sahab_project/feature/checkout/presentation/views/failed_checkout_page.dart';
import 'package:sahab_project/feature/checkout/presentation/views/success_checkout_page.dart';
import 'package:sahab_project/feature/checkout/presentation/views/widget/checkout_page_body.dart';
import 'package:sahab_project/feature/checkout/presentation/views/widget/webview_page.dart';
import 'package:shimmer/shimmer.dart';
// import '../../../../core/utils/widgets/custom_app_sub_title.dart';
import '../../../../core/utils/widgets/custom_app_title.dart';
import '../../../../core/utils/widgets/custom_booking_details.dart';
import '../../../../core/utils/widgets/custom_input_field.dart';
import '../../../../core/utils/widgets/custom_title_input_field.dart';
import '../../../../core/utils/widgets/row_data_item.dart';
import '../../../../generated/l10n.dart';
// import '../../../home/presentation/widgets/search_field.dart';

class CheckOutPage extends StatelessWidget {
  const CheckOutPage({
    super.key,
    required this.typeToggle,
    required this.bookingTitle,
    required this.price,
    required this.startDate,
    required this.endDate,
    required this.id,
    this.address,
  });
// todo : finish translate
  final TypeToggle typeToggle;
  final String bookingTitle;
  final num price;
  final DateTime startDate;
  final DateTime endDate;
  final int id;
  final String? address;
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => CheckoutCubit()
            ..setImportantAttribute(
              context,
              price: price,
              endDate: endDate,
              startDate: startDate,
              id: id,
              address: address,
            ),
        ),
        BlocProvider(
          create: (context) => CanPayCubit(),
        ),
      ],
      child: BlocBuilder<PromoCodeCubit, PromoCodeState>(
        builder: (context, promoState) {
          return BlocConsumer<CheckoutCubit, CheckoutState>(
            listener: (context, state) {
              // TODO: implement listener
              if (state is FirstSuccessCheckoutState) {
                Navigator.of(context).push(
                  CupertinoPageRoute(
                    builder: (context) => WebViewScreen(
                      address: address,
                      categoryTitle: bookingTitle,
                      url: state.bookingResponse.invoiceData?.invoiceUrl ?? "",
                      typeToggle: typeToggle,
                    ),
                  ),
                );
              }
            },
            builder: (context, checkoutState) {
              if (checkoutState is FirstFailureCheckoutState) {
                return FailedCheckoutPage(
                  onTap: () {
                    BlocProvider.of<CheckoutCubit>(context)
                        .addBooking(typeToggle: typeToggle);
                  },
                );
              }
              return ModalProgressHUD(
                inAsyncCall: promoState is LoadingPromoCode ||
                    checkoutState is LoadingCheckoutState,
                progressIndicator: CustomCircularProgressIndicator(),
                child: WillPopScope(
                  onWillPop: () async {
                    // Navigator.of(context).pop();
                    // BlocProvider.of<PromoCodeCubit>(context).reset();

                    return true;
                  },
                  child: Scaffold(
                    body: Column(
                      children: [
                        CustomSimpleAppBarWidget(
                          // onIconTap: () {},
                          appBarTitle: S.of(context).checkout,
                          // onIconTap: () {
                          //   // BlocProvider.of<PromoCodeCubit>(context).reset();
                          //   Navigator.of(context).pop();
                          // },
                        ),
                        BlocBuilder<PaymentCubit, PaymentState>(
                          builder: (context, state) {
                            if (state is LoadingFetchPaymentState) {
                              return Expanded(
                                  child: Center(
                                child: CustomCircularProgressIndicator(),
                              ));
                            } else if (state is FailureFetchPaymentState) {
                              return Expanded(
                                child: CustomNoInternetAndErrorView(
                                  onTryAgainButton: () {
                                    BlocProvider.of<PaymentCubit>(context)
                                        .fetchPaymentMethod();
                                  },
                                ),
                              );
                            } else if (state is SuccessFetchPaymentState) {
                              return CheckoutPageBody(
                                typeToggle: typeToggle,
                                bookingTitle: bookingTitle,
                                serviceAddress: address,
                              );
                            }
                            return SizedBox(
                              child: Text("error"),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class CheckOutPaymentDetails extends StatelessWidget {
  const CheckOutPaymentDetails({
    super.key,
  });
// todo : finish translate
  @override
  Widget build(BuildContext context) {
    CheckoutCubit checkoutCubit = CheckoutCubit.get(context);
    return BlocBuilder<PromoCodeCubit, PromoCodeState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomAppTitle(title: S.of(context).payment_details),
            SizedBox(height: 12.h),
            RowDataItem(
              firstData: S.of(context).booking_amount,
              secondData: "${checkoutCubit.price.toStringAsFixed(3)} KD",
              textStyle: AppStyles.textStyle16w400Black(context),
            ),
            SizedBox(height: 10.h),
            RowDataItem(
              firstData: S.of(context).discount,
              secondData:
                  "${checkoutCubit.discountPrice.toStringAsFixed(3)} KD",
              textStyle: AppStyles.textStyle16w400Black(context),
            ),
            SizedBox(height: 10.h),
            RowDataItem(
              firstData: S.of(context).total,
              secondData: "${checkoutCubit.totalPrice.toStringAsFixed(3)} KD",
              textStyle: AppStyles.textStyle17w700Blue(context),
            ),
            SizedBox(height: 30.h),
          ],
        );
      },
    );
  }
}

class PaymentMethodSection extends StatelessWidget {
  const PaymentMethodSection({
    super.key,
  });
// todo : finish translate
  @override
  Widget build(BuildContext context) {
    CheckoutCubit checkoutCubit = CheckoutCubit.get(context);
    PaymentCubit paymentCubit = PaymentCubit.get(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomAppTitle(title: S.of(context).payment_method),
        SizedBox(height: 15.h),
        BlocConsumer<PaymentCubit, PaymentState>(
          listener: (context, state) {
            // TODO: implement listener
          },
          builder: (context, state) {
            if (state is SuccessFetchPaymentState) {
              return BlocBuilder<CheckoutCubit, CheckoutState>(
                builder: (context, state) {
                  return ListView.separated(
                    separatorBuilder: (context, index) => SizedBox(),
                    itemCount: paymentCubit.paymentMethodList.length,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) => ItemPaymentMethod(
                      iconPath: paymentCubit.paymentMethodList[index].photo ??
                          "", // AppIcons.kentPayment,
                      title:
                          paymentCubit.paymentMethodList[index].paymentMethod ??
                              "", //"Kent",
                      currentValue:
                          checkoutCubit.selectedPaymentMethod?.id ?? -2,
                      value: paymentCubit.paymentMethodList[index].id ?? -1,
                      onChange: (value) {
                        checkoutCubit.selectPaymentMethod(value, context);
                        print("********************************************");
                      },
                    ),
                  );
                },
              );
            } else {
              return SizedBox();
            }
          },
        ),
      ],
    );
  }
}

class ItemPaymentMethod extends StatelessWidget {
  const ItemPaymentMethod({
    super.key,
    required this.iconPath,
    required this.title,
    required this.onChange,
    required this.value,
    required this.currentValue,
  });

  final String iconPath;
  final String title;
  final int value;
  final int currentValue;
  final Function(dynamic value) onChange;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onChange(value);
      },
      child: Row(
        children: [
          SizedBox(
            height: 24,
            width: 36,
            child: CachedNetworkImage(
              fit: BoxFit.cover,
              placeholder: (context, url) {
                return Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: Container(
                    // width: 1000.w,
                    // height: 140.h,
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(5))),
                    // child: Image.asset(
                    //   Constant.kAdImage,
                    // ),
                  ),
                );
              },
              imageUrl: "${Constant.baseUrl}$iconPath",
              errorWidget: (context, url, error) {
                return Icon(Icons.error);
                // Image.asset(
                //   imagePathOnError,
                //   fit: BoxFit.cover,
                // );
              },
            ),
          ), // SvgPicture.asset(iconPath),
          SizedBox(
            width: 15.w,
          ),
          Expanded(
            child: Text(
              title,
              style: AppStyles.textStyle16w400Black(context),
            ),
          ),
          Radio(
            value: value,
            groupValue: currentValue,
            onChanged: onChange,
            activeColor: AppColor.blueColor,

            // fillColor: AppColor.blueColor,
            // focusColor: AppColor.blackColor,
          ),
        ],
      ),
    );
  }
}

class PromoCodeSection extends StatelessWidget {
  const PromoCodeSection({
    super.key,
  });
// todo : finish translate
  @override
  Widget build(BuildContext context) {
    CheckoutCubit checkoutCubit = CheckoutCubit.get(context);
    PromoCodeCubit promoCodeCubit = PromoCodeCubit.get(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomAppTitle(
          title: S.of(context).promo_code,
        ),
        SizedBox(height: 10.h),
        Container(
          decoration: BoxDecoration(
              color: AppColor.whiteColor,
              borderRadius: BorderRadius.circular(5)),
          child: Row(
            children: [
              Expanded(
                child: CustomInputField(
                  hintText: S.of(context).enter_promo_code_here,
                  controller: promoCodeCubit
                      .promoCodeController, //TextEditingController(),
                  withoutFocusedBorder: true,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: BlocBuilder<PromoCodeCubit, PromoCodeState>(
                  builder: (context, state) {
                    return AppButton(
                      width: 100.w,
                      height: MediaQuery.of(context).size.height * 0.06,
                      onTap: state is! SuccessPromoCode
                          ? () {
                              if (promoCodeCubit
                                  .promoCodeController.text.isNotEmpty) {
                                promoCodeCubit.applyPromoCode(context);
                              } else {
                                print("obs");
                              }
                            }
                          : null,
                      text: S.of(context).apply,
                      color: state is SuccessPromoCode
                          ? AppColor.stepColor
                          : AppColor.blueColor,
                      radius: 5,
                      fontSize: 14.sp,
                      fontFamily: AppStyles.getFontFamily(context),
                      textColor: AppColor.whiteColor,
                      fontWeight: FontWeight.w600,
                    );
                  },
                ),
              )
            ],
          ),
        ),
        SizedBox(height: 6.h),
        BlocBuilder<PromoCodeCubit, PromoCodeState>(
          builder: (context, state) {
            if (state is SuccessPromoCode) {
              return Text(
                S.of(context).code_applied_successfully,
                style: AppStyles.textStyle12w400green(context),
              );
            } else if (state is FailurePromoCode) {
              return Text(
                S.of(context).invalid_promo_code,
                style: AppStyles.textStyle12w400green(context).copyWith(
                  color: Colors.red,
                ),
              );
            }
            return SizedBox();
          },
        ),
        SizedBox(height: 11.h),
      ],
    );
  }
}

class CheckOutContactDetails extends StatelessWidget {
  const CheckOutContactDetails({
    super.key,
  });
// todo : finish translate
  @override
  Widget build(BuildContext context) {
    CheckoutCubit checkoutCubit = CheckoutCubit.get(context);
    CanPayCubit canPayCubit = CanPayCubit.get(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomAppTitle(title: S.of(context).contact_details),
        SizedBox(
          height: 5.h,
        ),
        CustomTitleInputField(title: S.of(context).name_),
        SizedBox(height: 6.h),
        CustomInputField(
          controller: checkoutCubit.nameController,
          hintText: S.of(context).enter_here,
          onChange: (p0) {
            // canPayCubit.canPay(context);
          },
        ),
        SizedBox(height: 20.h),
        CustomTitleInputField(title: S.of(context).phone_number_),
        SizedBox(height: 6.h),
        CustomInputField(
          onChange: (p0) {
            // canPayCubit.canPay(context);
          },
          controller: checkoutCubit.phoneController,
          hintText: S.of(context).enter_here,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
          ],
        ),
      ],
    );
  }
}
