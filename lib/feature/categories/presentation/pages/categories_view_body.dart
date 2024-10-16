import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sahab_project/core/theme/app_color.dart';
import 'package:sahab_project/core/utils/icons/app_icons.dart';
import 'package:sahab_project/core/utils/widgets/custom_simple_app_bar_widget.dart';
import 'package:sahab_project/feature/categories/presentation/manager/cubit/category_cubit.dart';
import 'package:sahab_project/feature/home/presentation/widgets/Category_card.dart';

import '../../../../generated/l10n.dart';

class CategoriesViewBody extends StatelessWidget {
  const CategoriesViewBody({super.key});
// todo : finish translate
  @override
  Widget build(BuildContext context) {
    CategoryCubit categoryCubit = CategoryCubit.get(context);
    return RefreshIndicator(
      color: AppColor.blueColor,
      onRefresh: () async {
        categoryCubit.fetchCategory(context);
      },
      child: Column(
        children: [
          // const CustomAppBar(title: "Categories"),
          CustomSimpleAppBarWidget(
            // onIconTap: () {
            //   Navigator.of(context).pop();
            // },
            iconPath: AppIcons.backArrow,
            appBarTitle: S.of(context).categories,
          ),
          SizedBox(
            height: 36.h,
          ),
          BlocConsumer<CategoryCubit, CategoryState>(
            listener: (context, state) {},
            builder: (context, state) {
              return Expanded(
                child: GridView.builder(
                  padding: EdgeInsets.zero,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1,
                    mainAxisExtent: 220.h,
                    mainAxisSpacing: 24.h,
                  ),
                  itemCount: categoryCubit.fetchCategoryList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return CategoryCard(
                      height: 172.h,
                      width: 172.w,
                      iconHeight: 68.h,
                      iconWidth: 68.w,
                      category: categoryCubit.fetchCategoryList[index],
                      fontSized: 18,
                      fontWeight: FontWeight.w500,
                      categoryId:
                          categoryCubit.fetchCategoryList[index].id ?? -1,
                    );
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
