import 'package:bima_finance/core/constant/app_color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MenuWidget extends StatelessWidget {
  String? title;
  VoidCallback? onTap;
  IconData? icon;

  MenuWidget({
    Key? key,
    required this.title,
    required this.onTap,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.only(right: 10),
              child: Icon(
                icon,
                color: colorPrimary,
                size: 20,
              ),
            ),
            SizedBox(width: 10,),
            Expanded(
              flex: 1,
              child: Text(
                "$title",
                style: TextStyle(
                    fontSize: 14
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 10),
              child: Icon(
                Icons.chevron_right,
                color: Colors.grey,
              ),
            ),
          ],
        )
    );
  }
}