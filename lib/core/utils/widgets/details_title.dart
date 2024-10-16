import 'package:flutter/material.dart';
import 'package:sahab_project/core/theme/app_textsyle.dart';

class DetailsTitle extends StatelessWidget {
  const DetailsTitle({
    super.key,
    required this.title,
  });
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Text(
        title,
        style: AppStyles.style18semibold(context),
      ),
    );
  }
}
