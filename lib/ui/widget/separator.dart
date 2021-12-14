import 'package:bima_finance/core/constant/app_color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SeparatorWidget extends StatelessWidget {
  double? height;

  SeparatorWidget({
    Key? key,
    this.height = 16
});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: height!),
      height: 1,
      color: Colors.grey[300],
    );
  }
}