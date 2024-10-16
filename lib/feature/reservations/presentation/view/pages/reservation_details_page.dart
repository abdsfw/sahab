import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:sahab_project/core/enums/type_post_enum.dart';
import 'package:sahab_project/core/theme/app_color.dart';
import 'package:sahab_project/core/theme/app_textsyle.dart';
import 'package:sahab_project/core/utils/functions/function.dart';
import 'package:sahab_project/core/utils/widgets/app_button.dart';
import 'package:sahab_project/core/utils/widgets/circular_progress_indicator.dart';
import 'package:sahab_project/core/utils/widgets/custom_app_title.dart';
import 'package:sahab_project/core/utils/widgets/custom_booking_details.dart';
import 'package:sahab_project/core/utils/widgets/custom_no_internet_and_error_view.dart';
import 'package:sahab_project/core/utils/widgets/custom_simple_app_bar_widget.dart';
import 'package:sahab_project/core/utils/widgets/row_data_item.dart';
import 'package:sahab_project/feature/reservations/presentation/manager/cancel_reservation_cubit/cancel_reservation_cubit.dart';
import 'package:sahab_project/feature/reservations/presentation/manager/details_reservation_cubit/details_reservation_cubit.dart';
import 'package:sahab_project/feature/reservations/presentation/view/widgets/custom_reservation_booking_details.dart';
import 'package:sahab_project/feature/reservations/presentation/view/widgets/reservation_card_image.dart';
import 'package:sahab_project/feature/reservations/presentation/view/widgets/reservation_details_place.dart';
import 'package:sahab_project/feature/reservations/presentation/view/widgets/reservation_details_service.dart';
import 'package:sahab_project/feature/reservations/presentation/view/widgets/reservation_payment_details.dart';

import '../../../../../generated/l10n.dart';

class ReservationDetailsPage extends StatelessWidget {
  const ReservationDetailsPage(
      {super.key, required this.id, required this.typeToggle});
  final int id;
  final TypeToggle typeToggle;
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => DetailsReservationCubit()
            ..getReservationDetails(context, id: id, typeToggle: typeToggle),
        ),
        BlocProvider(
          create: (context) => CancelReservationCubit(),
        ),
      ],
      child: BlocConsumer<CancelReservationCubit, CancelReservationState>(
        listener: (context, state) {
          if (state is SuccessCancelReservationState) {
            /* 
                  ! here must be try to call `getAllBookingPlaceData` 
                  ! but i think there is an problem
                  ! because this context not doesn't access to `PlaceReservationCubit`
                  */
            //? one from dialog and second from details page
            // Navigator.of(context).pop();
            Navigator.of(context).pop("success");
          } else if (state is FailureCancelReservationState) {
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
          return ModalProgressHUD(
            inAsyncCall: state is LoadingCancelReservationState,
            progressIndicator: CustomCircularProgressIndicator(),
            child: Scaffold(
              body: ReservationDetailsPageBody(
                id: id,
                typeToggle: typeToggle,
              ),
            ),
          );
        },
      ),
    );
  }
}

class ReservationDetailsPageBody extends StatelessWidget {
  const ReservationDetailsPageBody(
      {super.key, required this.id, required this.typeToggle});
  final int id;
  final TypeToggle typeToggle;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DetailsReservationCubit, DetailsReservationState>(
      builder: (context, state) {
        if (state is LoadingFetchServiceDetails ||
            state is LoadingFetchPlaceDetails) {
          return const Center(
            child: CustomCircularProgressIndicator(),
          );
        } else if (state is FailureFetchServiceDetails ||
            state is FailureFetchPlaceDetails) {
          return CustomNoInternetAndErrorView(
            onTryAgainButton: () {
              BlocProvider.of<DetailsReservationCubit>(context)
                  .getReservationDetails(context,
                      id: id, typeToggle: typeToggle);
            },
          );
        } else if (state is SuccessFetchServiceDetails) {
          return ReservationDetailsService(
            serviceModel: state.serviceDetail,
          );
        } else if (state is SuccessFetchPlaceDetails) {
          return ReservationDetailsPlace(
            placeModel: state.placeDetail,
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }
}

class UserDetailsSection extends StatelessWidget {
  const UserDetailsSection({
    super.key,
    required this.name,
    required this.phone,
  });
  final String name;
  final String phone;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomAppTitle(title: S.of(context).user_details),
          SizedBox(
            height: 7.h,
          ),
          CustomBrownText(
            text: name, //"Mohammed Hussain",
          ),
          SizedBox(height: 11.h),
          CustomBrownText(
            text: phone, //"+965 98989898",
          ),
        ],
      ),
    );
  }
}

class CustomBrownText extends StatelessWidget {
  const CustomBrownText({
    super.key,
    required this.text,
  });
  final String text;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: AppStyles.textstyle16w400Brown(context),
    );
  }
}

class AddressSection extends StatelessWidget {
  const AddressSection({
    super.key,
    required this.typeToggle,
    required this.address,
  });
  final TypeToggle typeToggle;
  final String address;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 26.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomAppTitle(
            title: typeToggle == TypeToggle.place
                ? S.of(context).address
                : S.of(context).user_address,
          ),
          Text(
            address, //"Muntazah Al Khairan road 278 zone 3, An Nami, Al Khiran, Kuwait",
            style: AppStyles.textStyle14w400GreyHint(context).copyWith(
              color: AppColor.greyColorWithOpacity,
            ),
          ),
        ],
      ),
    );
  }
}

class ImageContainer extends StatelessWidget {
  const ImageContainer({
    super.key,
    required this.title,
    required this.secondTitle,
    this.tag,
    required this.typeToggle,
    required this.imagePath,
  });
  final String title;
  final String secondTitle;
  final String? tag;
  final String imagePath;
  final TypeToggle typeToggle;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: ReservationCardImage(
        imagePath: imagePath,
        title: title, //"location name",
        secondTitle: secondTitle, //"Place: Rest House",
        tag: tag, //"Girl Only",
        typeToggle: typeToggle, //TypeToggle.place,
      ),
    );
  }
}

class FirstContainer extends StatelessWidget {
  const FirstContainer({
    super.key,
    required this.bookingId,
    required this.status,
  });
  final String bookingId;
  final String status;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsetsDirectional.only(
        top: 35.h,
        start: 20.w,
        end: 20.w,
        bottom: 28.h,
      ),
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Column(
        children: [
          RowDataItem(
            firstData: S.of(context).booking_ID,
            secondData: S.of(context).status,
            textStyle: AppStyles.textstyle16w500Brown(context)
                .copyWith(fontWeight: FontWeight.w700),
          ),
          SizedBox(
            height: 4.h,
          ),
          RowDataItem(
            firstData: bookingId, //"#SA9899",
            secondData: status, //"Booked",
            textStyle: AppStyles.textStyle16w400DarkBlue(context),
          ),
        ],
      ),
    );
  }
}

class CustomDivider extends StatelessWidget {
  const CustomDivider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Divider(
      color: AppColor.dividerColor,
      height: 0,
    );
  }
}
