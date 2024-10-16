import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sahab_project/core/const.dart';
import 'package:sahab_project/core/theme/app_color.dart';
import 'package:sahab_project/core/utils/cache/cache_helper.dart';
import 'package:sahab_project/core/utils/icons/app_icons.dart';
import 'package:sahab_project/feature/account/presentation/manager/account_cubit/account_cubit.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shimmer/shimmer.dart';

class ProfilePhotoPicker extends StatelessWidget {
  const ProfilePhotoPicker({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    AccountCubit accountCubit = AccountCubit.get(context);
    accountCubit.setUserInfo();
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 27.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BlocConsumer<AccountCubit, AccountState>(
            listener: (context, state) {},
            builder: (context, state) {
              return GestureDetector(
                onTap: () {
                  if (state is! AccountEditLoading) {
                    accountCubit.getImage();
                  }
                },
                child: Stack(
                  alignment: Alignment.topRight,
                  clipBehavior: Clip.none,
                  children: [
                    BlocConsumer<AccountCubit, AccountState>(
                        listener: (context, state) {
                      if (state is AccountEditSuccess) {
                      } else if (state is AccountEditLoading) {
                        accountCubit.isLoading = true;
                      }
                    }, builder: (context, state) {
                      if (state is AccountImageLoaded &&
                          accountCubit.selectedImage != null) {
                        return CircleAvatar(
                          radius: 48,
                          backgroundColor: AppColor.greyCircleAvatar,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(48),
                            child: Image.file(
                              state.image,
                              width: 96,
                              height: 96,
                              fit: BoxFit.cover,
                            ),
                          ),
                        );
                      } else if (state is AccountEditSuccess) {
                        return CircleAvatar(
                          radius: 48,
                          backgroundColor: AppColor.greyCircleAvatar,
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(48),
                              child: CachedNetworkImage(
                                  imageUrl:
                                      "${Constant.baseUrl}${state.newImagePath}",
                                  fit: BoxFit.cover,
                                  width: 96,
                                  height: 96,
                                  errorWidget: (context, url, error) {
                                    return Padding(
                                      padding: const EdgeInsets.all(27),
                                      child: SvgPicture.asset(
                                        AppIcons.person,
                                        clipBehavior: Clip.none,
                                        width: 96,
                                        height: 96,
                                      ),
                                    );
                                  })),
                        );
                      } else if (state is StarEditAccount) {
                        return CircleAvatar(
                          radius: 48,
                          backgroundColor: AppColor.greyCircleAvatar,
                          child: ClipRRect(
                              // clipBehavior: Clip.none,
                              borderRadius: BorderRadius.circular(48),
                              child: CachedNetworkImage(
                                  fit: BoxFit.cover,
                                  width: 96,
                                  height: 96,
                                  imageUrl:
                                      "${Constant.baseUrl}${CacheHelper.getData(key: Constant.kUserImage)}",
                                  errorWidget: (context, url, error) {
                                    return Padding(
                                      padding: const EdgeInsets.all(27.0),
                                      child: SvgPicture.asset(
                                          clipBehavior: Clip.none,
                                          AppIcons.person,
                                          fit: BoxFit.cover,
                                          width: 96,
                                          height: 96),
                                    );
                                  })),
                        );
                      } else {
                        return Shimmer.fromColors(
                          baseColor: Colors.grey[300]!,
                          highlightColor: Colors.grey[100]!,
                          child: CircleAvatar(
                            radius: 50.sp,
                            backgroundColor: AppColor.greyCircleAvatar,
                            child: SvgPicture.asset(AppIcons.person),
                          ),
                        );
                      }
                    }),
                    Positioned(
                      top: -2,
                      right: 0,
                      child: CircleAvatar(
                        radius: 16,
                        backgroundColor:
                            AppColor.blueColor, // Add background color to icon
                        child: SvgPicture.asset(AppIcons.editPic),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
