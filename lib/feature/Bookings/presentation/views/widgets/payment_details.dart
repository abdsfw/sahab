import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sahab_project/core/theme/app_textsyle.dart';
import 'package:sahab_project/core/utils/widgets/row_data_item.dart';

import '../../../../../generated/l10n.dart';

class PaymentDetails extends StatelessWidget {
  const PaymentDetails({
    super.key,
    required this.paymentMethod,
    required this.transactionId,
    required this.referenceId,
    required this.invoiceReference,
    required this.bookingAmount,
    required this.discount,
    required this.total,
  });
  final String paymentMethod;
  final String transactionId;
  final String referenceId;
  final String invoiceReference;
  final String bookingAmount;
  final String discount;
  final String total;
// todo : finish translate
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          S.of(context).payment_details,
          style: AppStyles.textStyle18w600Black(context),
        ),
        SizedBox(height: 11.h),
        RowDataItem(
          firstData: S.of(context).payment_method,
          secondData: paymentMethod,
          textStyle: AppStyles.textStyle16w400Black(context),
        ),
        SizedBox(height: 12.h),
        RowDataItem(
          firstData: S.of(context).transaction_id,
          secondData: transactionId,
          textStyle: AppStyles.textStyle16w400Black(context),
        ),
        SizedBox(height: 12.h),
        RowDataItem(
          firstData: S.of(context).reference_id,
          secondData: referenceId,
          textStyle: AppStyles.textStyle16w400Black(context),
        ),
        SizedBox(height: 12.h),
        RowDataItem(
          firstData: S.of(context).invoice_reference,
          secondData: invoiceReference,
          textStyle: AppStyles.textStyle16w400Black(context),
        ),
        SizedBox(height: 12.h),
        RowDataItem(
          firstData: S.of(context).booking_amount,
          secondData: "${bookingAmount} KD",
          textStyle: AppStyles.textStyle16w400Black(context),
        ),
        SizedBox(height: 12.h),
        RowDataItem(
          firstData: S.of(context).discount,
          secondData: "$discount KD",
          textStyle: AppStyles.textStyle16w400Black(context),
        ),
        SizedBox(height: 12.h),
        SizedBox(
          height: 17.h,
        ),
        RowDataItem(
          firstData: S.of(context).total,
          secondData: "$total KD",
          textStyle: AppStyles.textStyle17w700Blue(context),
        ),
      ],
    );
  }
}
