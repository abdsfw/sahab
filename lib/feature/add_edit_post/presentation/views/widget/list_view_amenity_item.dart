import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sahab_project/feature/add_edit_post/presentation/manager/next_post_place_cubit/next_post_place_cubit.dart';
import 'package:sahab_project/feature/add_edit_post/presentation/views/widget/amenity_item_check_box.dart';
import 'package:sahab_project/feature/add_edit_post/presentation/views/widget/shimmer_amenities_loading_item.dart';
import '../../../../../core/theme/app_color.dart';
import '../../../../../core/utils/widgets/custom_no_internet_and_error_view.dart';

class ListViewAmenityItem extends StatelessWidget {
  const ListViewAmenityItem({
    super.key,
  });
// todo : finish translate
  @override
  Widget build(BuildContext context) {
    NextPostPlaceCubit nextPostPlaceCubit = NextPostPlaceCubit.get(context);

    return Expanded(
      child: BlocBuilder<NextPostPlaceCubit, NextPostPlaceState>(
        builder: (context, state) {
          if (state is GetAmenityLoadingState) {
            return ListView.separated(
              itemCount: 5,
              separatorBuilder: (context, index) => const Divider(
                color: AppColor.dividerColor,
                thickness: 1,
              ),
              itemBuilder: (context, index) =>
                  const ShimmerAmenitiesLoadingItem(),
            );
          } else if (state is GetAmenityFailureState) {
            return CustomNoInternetAndErrorView(
              onTryAgainButton: () {
                nextPostPlaceCubit.getAllAmenity(context);
              },
            );
            // Center(
            //   child: Text('data'),
            // );
          }

          return ListView.separated(
            itemCount: nextPostPlaceCubit.amenityList.length,
            separatorBuilder: (context, index) => const Divider(
              color: AppColor.dividerColor,
              thickness: 1,
            ),
            itemBuilder: (context, index) => Padding(
              padding: EdgeInsets.symmetric(vertical: 15.h),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: AmenityItemCheckBox(
                  index: index,
                  onChange: (p0) {
                    print(p0);
                    nextPostPlaceCubit.selectAmenity(
                      index: index,
                      booleanValue: p0 ?? false,
                    );
                  },
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
