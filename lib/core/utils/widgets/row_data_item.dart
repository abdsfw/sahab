import 'package:flutter/material.dart';

class RowDataItem extends StatelessWidget {
  const RowDataItem({
    super.key,
    required this.firstData,
    required this.secondData,
    required this.textStyle,
  });

  final String firstData;
  final String secondData;
  final TextStyle textStyle;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Text(
            firstData,
            style: textStyle,
          ),
        ),
        Expanded(
          child: Text(
            secondData,
            textAlign: TextAlign.end,
            style: textStyle,
          ),
        ),
      ],
    );
  }
}
