import 'package:flutter/material.dart';
import 'package:sahab_project/core/theme/app_textsyle.dart';
import 'package:sahab_project/feature/add_edit_post/presentation/views/widget/custom_check_box.dart';

import '../../../../../generated/l10n.dart';
import '../../manager/next_post_place_cubit/next_post_place_cubit.dart';

class AmenityItemCheckBox extends StatelessWidget {
  const AmenityItemCheckBox({
    super.key,
    required this.index,
    this.onChange,
  });
  final int index;
  final void Function(bool?)? onChange;
  @override
  Widget build(BuildContext context) {
    NextPostPlaceCubit nextPostPlaceCubit = NextPostPlaceCubit.get(context);
// todo : finish translate

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            nextPostPlaceCubit.amenityList[index].title ??
                S.of(context).error_fetch,
            style: AppStyles.textStyle16w400Black(context),
          ),
        ),
        CustomCheckBox(
          value: nextPostPlaceCubit.amenityList[index].selected!,
          onChange: onChange,
        ),
      ],
    );
  }
}
