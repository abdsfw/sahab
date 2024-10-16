import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../core/enums/type_post_enum.dart';
import '../../../../../core/theme/app_color.dart';
import '../../../../../core/utils/icons/app_icons.dart';
import '../../manager/select_photo_cubit/select_photo_cubit.dart';

class ShowImage extends StatelessWidget {
  const ShowImage({
    super.key,
    required this.index,
    required this.typePost,
  });
// todo : finish translate

  final int index;
  final TypeToggle typePost;
  @override
  Widget build(BuildContext context) {
    SelectPhotoCubit selectPhotoCubit = SelectPhotoCubit.get(context);

    return ClipRRect(
      borderRadius: BorderRadius.circular(5),
      child: InkWell(
        onTap: () {
          //? to remove the `delete` state on photo
          selectPhotoCubit.removeDeleteMode();
        },
        onDoubleTap: () {
          print('double Tap');
          selectPhotoCubit.selectPhotoIndex(index);
        },
        child: Stack(
          alignment: Alignment.center,
          children: [
            AspectRatio(
              aspectRatio: 115.w / 62.h,
              child: Image.file(
                selectPhotoCubit.imageFile[index - 1],
                fit: BoxFit.cover,
              ),
            ),
            if (index == selectPhotoCubit.selectedDeleteIndex)
              Container(
                color: AppColor.blackColor.withOpacity(0.5),
              ),
            if (index == selectPhotoCubit.selectedDeleteIndex)
              InkWell(
                onTap: () {
                  print('delete image');
                  selectPhotoCubit.deleteSelectedImage(index, context,
                      typePost: typePost);
                },
                child: SvgPicture.asset(
                  AppIcons.delete,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
