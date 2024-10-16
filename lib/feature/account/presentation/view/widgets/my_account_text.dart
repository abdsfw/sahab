import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sahab_project/core/theme/app_textsyle.dart';

import '../../../../../generated/l10n.dart';

class MyAccountText extends StatelessWidget {
  const MyAccountText({
    super.key,
  });
// todo : finish translate
  @override
  Widget build(BuildContext context) {
    return Text(
      S.of(context).my_account,
      style: AppStyles.style16(context).copyWith(
        letterSpacing: -0.16,
      ),
    );
  }
}
