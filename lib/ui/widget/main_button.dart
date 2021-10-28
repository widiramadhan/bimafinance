import 'package:flutter/material.dart';

class MainButton extends StatelessWidget {
  final String? text;
  final Function? onPressed;
  final Color? color;
  final Color? textColor;
  final Color? borderColor;
  final double? radius;
  final double? height;
  final double? width;

  const MainButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.color,
    this.textColor,
    this.borderColor,
    this.radius = 0,
    this.height = 40,
    this.width = double.infinity
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      decoration: borderColor != null ? BoxDecoration(
        borderRadius: BorderRadius.circular(radius!),
        border: Border.all(width: 1, color: borderColor!)
      ) : BoxDecoration(),
      child:ClipRRect(
        borderRadius: BorderRadius.circular(radius!),
        child: MaterialButton(
          onPressed: () {
            FocusScope.of(context).requestFocus(FocusNode());
            if (onPressed != null) {
              onPressed!();
            }
          },
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          color: color != null ? color : Colors.grey[300],
          elevation: 0,
          padding: EdgeInsets.all(0),
          height: height,
          minWidth: width,
          child: Center(
            child: Text(
              text!,
              style: TextStyle(
                  color: textColor
              ),
            ),
          ),
        ),
      ) ,
    );
  }
}
