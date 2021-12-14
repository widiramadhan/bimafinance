import 'package:bima_finance/core/constant/app_color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StepWizardWidget extends StatelessWidget {
  final String? title;
 final bool active;

  const StepWizardWidget({
    Key? key,
    this.title,
    this.active = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            width: double.infinity,
            child: Text(
              "$title",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 12
              ),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          SizedBox(height: 5,),
          Container(
            width: double.infinity,
            height: 3,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(2),
                color: active == true ? colorPrimary : Color(0xffe5e5e5)
            ),
          )
        ],
      ),
    );
  }
}