import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sahab_project/core/utils/icons/app_icons.dart';
import 'package:shimmer/shimmer.dart';

class AmenitiesShimmerItem extends StatelessWidget {
  const AmenitiesShimmerItem({
    Key? key,
    this.title,
    this.imageUrl,
  }) : super(key: key);

  final String? title;
  final String? imageUrl;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.white,
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: SvgPicture.asset(AppIcons.wifi),
              ),
            ),
            const SizedBox(
              width: 15,
            ),
            Container(
              width: 80,
              height: 24,
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
