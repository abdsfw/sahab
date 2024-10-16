import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahab_project/core/theme/app_color.dart';
import 'package:sahab_project/core/utils/images/app_images_path.dart';
import 'package:sahab_project/feature/Bookings/presentation/manager/rating_cubit/rating_cubit.dart';
import 'package:sahab_project/feature/Bookings/presentation/views/widgets/custom_rating_button.dart';
import '../../../../../core/enums/rating_enum.dart';
import '../../../../../generated/l10n.dart';

class RatingSmileButtons extends StatelessWidget {
  const RatingSmileButtons({
    super.key,
  });
// todo : finish translate
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RatingCubit, RatingState>(
      builder: (context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomRatingButton(
              path: state is RatingExcellentState
                  ? AppImagesPath.excellent
                  : AppImagesPath.nonExcellent,
              color: state is RatingExcellentState
                  ? AppColor.excellentColor
                  : AppColor.greyExcellentColor,
              topStart: const Radius.circular(9),
              bottomStart: const Radius.circular(9),
              title: S.of(context).excellent,
              onTap: () {
                BlocProvider.of<RatingCubit>(context)
                    .chooseBookingRating(Rating.excellent);
              },
            ),
            CustomRatingButton(
              path: state is RatingGoodState
                  ? AppImagesPath.good
                  : AppImagesPath.nonGood,
              color: state is RatingGoodState
                  ? AppColor.goodColor
                  : AppColor.greyGoodColor,
              title: S.of(context).good,
              onTap: () {
                BlocProvider.of<RatingCubit>(context)
                    .chooseBookingRating(Rating.good);
              },
            ),
            CustomRatingButton(
              path: state is RatingBadState
                  ? AppImagesPath.bad
                  : AppImagesPath.nonBad,
              color: state is RatingBadState
                  ? AppColor.badColor
                  : AppColor.greyBadColor,
              topEnd: const Radius.circular(9),
              bottomEnd: const Radius.circular(9),
              title: S.of(context).bad,
              onTap: () {
                BlocProvider.of<RatingCubit>(context)
                    .chooseBookingRating(Rating.bad);
              },
            ),
          ],
        );
      },
    );
  }
}
