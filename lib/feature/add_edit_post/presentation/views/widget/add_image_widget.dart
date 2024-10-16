import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sahab_project/core/enums/type_post_enum.dart';
import 'package:sahab_project/core/theme/app_color.dart';
import 'package:sahab_project/core/utils/icons/app_icons.dart';
import '../../manager/select_photo_cubit/select_photo_cubit.dart';

class AddImageWidget extends StatelessWidget {
  const AddImageWidget({
    super.key,
    required this.index,
    required this.typePost,
  });
  final int index;
  final TypeToggle typePost;
  // todo : finish translate

  @override
  Widget build(BuildContext context) {
    SelectPhotoCubit selectPhotoCubit = SelectPhotoCubit.get(context);
    return Material(
      borderRadius: BorderRadius.circular(5),
      color: AppColor.imageContainerColor,
      child: InkWell(
        borderRadius: BorderRadius.circular(5),
        onTap: () async {
          //! here the maximum count of image is 5
          if (index < 5) {
            selectPhotoCubit.addSelectedImage(context, typePost: typePost);
          }
        },
        child: Container(
          decoration: BoxDecoration(
            // color: AppColor.imageContainerColor,
            borderRadius: BorderRadius.circular(5),
          ),
          child: Center(child: SvgPicture.asset(AppIcons.addImageIcon)),
        ),
      ),
    );
  }
}
