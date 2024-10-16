import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sahab_project/core/theme/app_textsyle.dart';
import 'package:sahab_project/feature/boarding/presentation/manager/lang_cubit/lang_cubit.dart';

import '../../../../generated/l10n.dart';

Widget buildTitleRow(
    String firstText,
    TextStyle firstTextStyle,
    String secondText,
    TextStyle secondTextStyle,
    void Function()? onPressed,
    context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Expanded(
        child: Row(
          children: [
            Text(
              (BlocProvider.of<LangCubit>(context).lang == 'ar')
                  ? '$secondText '
                  : '$firstText ',
              style: firstTextStyle,
              textAlign: TextAlign.start,
            ),
            Expanded(
              child: Text(
                (BlocProvider.of<LangCubit>(context).lang == 'ar')
                    ? firstText
                    : secondText,
                style: secondTextStyle,
                textAlign: TextAlign.start,
              ),
            ),
          ],
        ),
      ),
      TextButton(
        onPressed: onPressed,
        child: Text(
          S.of(context).view_all,
          style: AppStyles.style14(context),
        ),
      )
    ],
  );
}
