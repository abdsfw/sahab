import 'package:flutter/material.dart';

class BackgroundApp extends StatelessWidget {
  BackgroundApp({Key? key, required this.widget}) : super(key: key);

  Widget widget;

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return Container(
      width: w,
      height: h,
      child: widget,
    );
  }
}
