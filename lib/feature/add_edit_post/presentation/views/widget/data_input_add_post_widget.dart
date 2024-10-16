import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahab_project/feature/add_edit_post/presentation/manager/next_post_place_cubit/next_post_place_cubit.dart';
import 'package:sahab_project/feature/add_edit_post/presentation/views/widget/step_one_add_service_post.dart';

import 'package:sahab_project/feature/add_edit_post/presentation/views/widget/step_two_add_place_post.dart';
import 'package:sahab_project/feature/add_edit_post/presentation/views/widget/step_two_add_service_post.dart';

import '../../manager/next_post_service_cubit/next_post_service_cubit.dart';
import '../../manager/toggle_cubit/toggle_cubit.dart';
import 'step_one_add_place_post.dart';

class DataInputAddPostWidget extends StatelessWidget {
  const DataInputAddPostWidget({
    super.key,
    required this.isEdit,
    this.postID,
  });
  final bool isEdit;
  final int? postID;
// todo : finish translate

  @override
  Widget build(BuildContext context) {
    NextPostPlaceCubit nextPostPlaceCubit = NextPostPlaceCubit.get(context);
    NextPostServiceCubit nextPostServiceCubit =
        NextPostServiceCubit.get(context);
    return BlocBuilder<ToggleCubit, ToggleState>(
      builder: (context, state) {
        if (state is AddPlacePostState) {
          return Expanded(
            child: PageView(
              controller: nextPostPlaceCubit.placePageController,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                const StepOneAddPlacePost(),
                StepTwoAddPlacePost(
                  isEdit: isEdit,
                  postID: postID,
                ),
              ],
            ),
          );
        } else if (state is AddServicesPostState) {
          return Expanded(
            child: PageView(
              controller: nextPostServiceCubit.servicePageController,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                const StepOneAddServicePost(),
                StepTwoAddServicePost(
                  postId: postID,
                  isEdit: isEdit,
                ),
              ],
            ),
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
