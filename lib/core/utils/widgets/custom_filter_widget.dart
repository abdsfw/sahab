import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sahab_project/core/theme/app_textsyle.dart';
import 'package:sahab_project/core/utils/icons/app_icons.dart';
import 'package:sahab_project/feature/places/presentation/pages/flitter_page.dart';

class CustomFilterWidget extends StatelessWidget {
  const CustomFilterWidget(
      {super.key,
      required this.title,
      required this.isVisibleAll,
      required this.onTap,
      required this.isFilter});
  final String title;
  final bool isVisibleAll;
  final bool isFilter;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: AppStyles.style20semibold(context),
        ),
        InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SvgPicture.asset(
              (isFilter) ? AppIcons.filter_icon2 : AppIcons.flitter,
            ),
          ),
        )
      ],
    );
  }
}
