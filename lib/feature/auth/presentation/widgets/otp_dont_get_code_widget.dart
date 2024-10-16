import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sahab_project/feature/auth/presentation/manager/cubit/otp_cubit/otp_cubit.dart';

import '../../../../core/utils/widgets/app_text.dart';
import '../../../../generated/l10n.dart';

class OTPDoNotGetCodeWidget extends StatelessWidget {
  const OTPDoNotGetCodeWidget({
    Key? key,
    // required this.en,
    // required this.h,
    required this.onTap,
  }) : super(key: key);

  // bool en;
  // double h;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AppText(
            text: S.of(context).Did_not_get_the_code,
            fontSize: 16.sp,
            fontWeight: FontWeight.w400,
            color: Color(0xff000000)),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.02,
        ),
        BlocBuilder<OtpCubit, OtpState>(
          builder: (context, state) {
            return AbsorbPointer(
              absorbing: state is ResendOtpLoading,
              child: InkWell(
                focusColor: Colors.transparent,
                highlightColor: Colors.transparent,
                hoverColor: Colors.transparent,
                onTap: onTap,
                child: AppText(
                    text: S.of(context).resend_code,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700,
                    decoration: TextDecoration.underline,
                    color: Color(0xff07183B)),
              ),
            );
          },
        ),
      ],
    );
  }
}
