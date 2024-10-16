import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sahab_project/core/enums/type_post_enum.dart';
import 'package:sahab_project/feature/add_edit_post/presentation/views/widget/show_image.dart';
import '../../../../../core/theme/app_textsyle.dart';
import '../../../../../core/utils/widgets/custom_title_input_field.dart';
import '../../../../../generated/l10n.dart';
import '../../manager/select_photo_cubit/select_photo_cubit.dart';
import 'add_image_widget.dart';

class UploadImagesSection extends StatelessWidget {
  const UploadImagesSection({
    super.key,
    required this.typePost,
  });
  // todo : finish translate

  final TypeToggle typePost;
  @override
  Widget build(BuildContext context) {
    SelectPhotoCubit selectPhotoCubit = SelectPhotoCubit.get(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomTitleInputField(
          title: S.of(context).upload_images,
          textStyle: AppStyles.textStyle17w400Brown(context).copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 7.h),
        Text(
          //? -- Max 5 Photos ,jpg, jpeg, png format only --
          S.of(context).note_about_images,
          //? ----------------------------------------------
          style: AppStyles.textStyle14w400GreyHint(context),
        ),
        SizedBox(height: 16.h),
        SizedBox(
          // height: 150.h,
          child: BlocBuilder<SelectPhotoCubit, SelectPhotoState>(
            builder: (context, state) {
              return GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 115.w / 62.h,
                  mainAxisSpacing: 5,
                  crossAxisSpacing: 5,
                ),
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: selectPhotoCubit.selectedImagePathList.length,
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return AddImageWidget(
                      index: selectPhotoCubit.selectedImagePathList.length,
                      typePost: typePost,
                    );
                  } else {
                    print('index: $index');

                    return ShowImage(
                      index: index,
                      typePost: typePost,
                    );
                  }
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
