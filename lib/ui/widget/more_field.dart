import 'package:flutter/material.dart';

class MoreField<T> extends StatefulWidget {
  final String? labelText;
  final Widget? hint;
  final List<DropdownMenuItem<T>>? items;
  final T? value;
  final Function(T)? onChanged;
  final String Function(dynamic)? validator;
  final Widget? icon;
  final String? errorText;
  final autovalidateMode;
  final bool? withBorder;
  final Color? iconColor;

  const MoreField(
      {Key? key,
      this.labelText,
      this.hint,
      required this.items,
      this.value,
      required this.onChanged,
      this.validator,
      this.icon,
      this.errorText,
      this.autovalidateMode,
      this.withBorder = true,
      this.iconColor = const Color(0xff524e51)})
      : super(key: key);

  @override
  _MoreFieldState createState() => _MoreFieldState();
}

class _MoreFieldState extends State<MoreField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (widget.labelText != null)
          Text(
            widget.labelText!,
            style: TextStyle(color: Colors.grey,),
          ),
        SizedBox(height: widget.withBorder! ? 10 : 0),
        DropdownButtonFormField(
          validator: widget.validator ?? null,
          autovalidateMode: widget.autovalidateMode ?? null,
          items: widget.items,
          isExpanded: true,
          hint: widget.hint,
          value: widget.value,
          onChanged: widget.onChanged,
          decoration: widget.errorText != null
              ? InputDecoration(
                  filled: true,
                  fillColor: Color(0xfff5f6f8),
                  border: widget.withBorder == true ? OutlineInputBorder(
                    borderSide: BorderSide(width: 1, color: Color(0xffdedede),),
                  ) : UnderlineInputBorder(
                    borderSide: BorderSide(width: 1, color: Color(0xffdedede),
                    ),
                  ),
                  enabledBorder: widget.withBorder == true ? OutlineInputBorder(
                    borderSide: BorderSide(width: 1, color: Color(0xffdedede)),
                  ) : UnderlineInputBorder(
                    borderSide: BorderSide(width: 1, color: Color(0xffdedede))
                  ),
                  errorBorder: widget.withBorder == true ? OutlineInputBorder(
                    borderSide: BorderSide(width: 1, color: Color(0xffdedede)),
                  ) : UnderlineInputBorder(
                      borderSide: BorderSide(width: 1, color: Color(0xffdedede))
                  ),
                  focusedErrorBorder: widget.withBorder == true ? OutlineInputBorder(
                    borderSide: BorderSide(width: 1, color: Color(0xffdedede)),
                  ) : UnderlineInputBorder(
                      borderSide: BorderSide(width: 1, color: Color(0xffdedede))
                  ),
                  errorText: widget.errorText)
              : InputDecoration(
                  filled: widget.withBorder == true ? true : false,
                  fillColor: Color(0xfff5f6f8),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 1,
                      color: Color(0xffdedede),
                    ),
                  ),
                  enabledBorder: widget.withBorder == true ? OutlineInputBorder(
                    borderSide: BorderSide(width: 1, color: Color(0xffdedede)),
                  ) : UnderlineInputBorder(
                    borderSide: BorderSide(width: 1, color: Color(0xffdedede)),
                  ),
                  errorBorder: widget.withBorder == true ? OutlineInputBorder(
                    borderSide: BorderSide(width: 1, color: Color(0xffdedede)),
                  ) : UnderlineInputBorder(
                      borderSide: BorderSide(width: 1, color: Color(0xffdedede))
                  ),
                  focusedErrorBorder: widget.withBorder == true ? OutlineInputBorder(
                    borderSide: BorderSide(width: 1, color: Color(0xffdedede)),
                  ) : UnderlineInputBorder(
                      borderSide: BorderSide(width: 1, color: Color(0xffdedede))
                  ),
                ),
          icon: widget.icon == null
              ? Icon(
                  Icons.keyboard_arrow_down,
                  color: widget.iconColor,
                  size: 20,
                )
              : widget.icon,
        )
      ],
    );
  }
}
