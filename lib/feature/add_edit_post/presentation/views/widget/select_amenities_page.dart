import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sahab_project/core/utils/icons/app_icons.dart';
import 'package:sahab_project/core/utils/widgets/custom_simple_app_bar_widget.dart';
import 'package:sahab_project/feature/add_edit_post/presentation/views/widget/list_view_amenity_item.dart';

import '../../../../../generated/l10n.dart';
import '../../manager/next_post_place_cubit/next_post_place_cubit.dart';

class SelectAmenitiesPage extends StatelessWidget {
  const SelectAmenitiesPage({
    super.key,
  });
  // todo: finish translate
  @override
  Widget build(BuildContext context) {
    NextPostPlaceCubit nextPostPlaceCubit = NextPostPlaceCubit.get(context);

    return WillPopScope(
      onWillPop: () async {
        nextPostPlaceCubit.checkIfCanMove(context);
        // Navigator.of(context).pop();
        return true;
      },
      child: Builder(builder: (context) {
        return Scaffold(
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomSimpleAppBarWidget(
                onIconTap: () {
                  nextPostPlaceCubit.checkIfCanMove(context);
                  Navigator.of(context).pop();
                },
                iconPath: AppIcons.backArrow,
                appBarTitle: S.of(context).amenities,
              ),
              SizedBox(
                height: 16.h,
              ),
              // const AmenityItemCheckBox(),
              const ListViewAmenityItem(),
            ],
          ),
        );
      }),
    );
  }
}
