import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sahab_project/core/const.dart';
import 'package:sahab_project/core/theme/app_color.dart';
import 'package:sahab_project/core/theme/app_textsyle.dart';
import 'package:sahab_project/core/utils/cache/cache_helper.dart';
import 'package:sahab_project/core/utils/icons/app_icons.dart';
import 'package:sahab_project/feature/account/presentation/manager/account_cubit/account_cubit.dart';

class MyAccount extends StatelessWidget {
  const MyAccount({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    AccountCubit accountCubit = AccountCubit.get(context);
    return Row(
      children: [
        BlocBuilder<AccountCubit, AccountState>(
          builder: (context, state) {
            if (state is StarEditAccount) {
              return CircleAvatar(
                radius: 48,
                backgroundColor: AppColor.greyCircleAvatar,
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(48),
                    child: CachedNetworkImage(
                        fit: BoxFit.cover,
                        width: 96,
                        height: 96,
                        imageUrl:
                            "${Constant.baseUrl}${CacheHelper.getData(key: Constant.kUserImage)}",
                        errorWidget: (context, url, error) {
                          return Padding(
                            padding: const EdgeInsetsDirectional.symmetric(
                                vertical: 30, horizontal: 10),
                            child: SvgPicture.asset(
                              width: 45,
                              height: 45,
                              AppIcons.person,
                              clipBehavior: Clip.none,
                            ),
                          );
                        })),
              );
            } else {
              return CircleAvatar(
                radius: 48,
                backgroundColor: AppColor.greyCircleAvatar,
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(48),
                    child: CachedNetworkImage(
                        fit: BoxFit.cover,
                        width: 96,
                        height: 96,
                        imageUrl:
                            "${Constant.baseUrl}${CacheHelper.getData(key: Constant.kUserImage)}",
                        errorWidget: (context, url, error) {
                          return Padding(
                            padding: const EdgeInsetsDirectional.symmetric(
                                vertical: 30, horizontal: 10),
                            child: SvgPicture.asset(
                              width: 45,
                              height: 45,
                              AppIcons.person,
                              clipBehavior: Clip.none,
                            ),
                          );
                        })),
              );
            }
          },
        ),
        SizedBox(
          width: 13.w,
        ),
        Padding(
          padding: const EdgeInsetsDirectional.only(
              bottom: 20.0), // Adjust this value as needed
          child: BlocConsumer<AccountCubit, AccountState>(
            listener: (context, state) {},
            builder: (context, state) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    accountCubit.userName ?? "N/A",
                    style: TextStyle(
                      fontFamily: AppStyles.getFontFamily(context),
                      fontWeight: FontWeight.w600,
                      color: AppColor.darkBlueColor,
                      fontSize: 17.sp,
                    ),
                  ),
                  Text(
                    accountCubit.userEmail ?? "N/A",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontFamily: AppStyles.getFontFamily(context),
                      fontWeight: FontWeight.w400,
                      fontSize: 14.sp,
                      color: AppColor.greyHintColor,
                    ),
                  ),
                  Text(
                    accountCubit.userPhone ?? "N/A",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontFamily: AppStyles.getFontFamily(context),
                      fontWeight: FontWeight.w400,
                      fontSize: 14.sp,
                      color: AppColor.greyHintColor,
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}
