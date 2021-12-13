import 'package:bima_finance/core/constant/field_style.dart';
import 'package:flutter/material.dart';

class OTPTextField extends StatefulWidget {
   int? length;
   double? width;
   double? fieldWidth;
  TextInputType? keyboardType;
   TextStyle? style;
   MainAxisAlignment? textFieldAlignment;
   bool? obscureText;
   FieldStyle? fieldStyle;
   ValueChanged<String>? onChanged;
   ValueChanged<String>? onCompleted;

  OTPTextField(
      {Key? key,
        this.length = 4,
        this.width = 10,
        this.fieldWidth = 30,
        this.keyboardType = TextInputType.number,
        this.style = const TextStyle(),
        this.textFieldAlignment = MainAxisAlignment.spaceBetween,
        this.obscureText = false,
        this.fieldStyle = FieldStyle.underline,
        this.onChanged,
        this.onCompleted})
      : assert(length! > 1);

  @override
  _OTPTextFieldState createState() => _OTPTextFieldState();
}

class _OTPTextFieldState extends State<OTPTextField> {
  List<FocusNode>? _focusNodes;
  List<TextEditingController>? _textControllers;

  List<Widget>? _textFields;
  List<String>? _pin;

  @override
  void initState() {
    super.initState();
    // _focusNodes = List<FocusNode>(widget.length!);
    // _textControllers = List<TextEditingController>(widget.length!);

    _pin = List.generate(widget.length!, (int i) {
      return '';
    });
    _textFields = List.generate(widget.length!, (int i) {
      return buildTextField(context, i);
    });
  }

  @override
  void dispose() {
    _textControllers!
        .forEach((TextEditingController controller) => controller.dispose());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      child: Row(
        mainAxisAlignment: widget.textFieldAlignment!,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: _textFields!,
      ),
    );
  }

  /// This function Build and returns individual TextField item.
  ///
  /// * Requires a build context
  /// * Requires Int position of the field
  Widget buildTextField(BuildContext context, int i) {
    if (_focusNodes![i] == null) _focusNodes![i] = new FocusNode();

    if (_textControllers![i] == null)
      _textControllers![i] = new TextEditingController();

    return Container(
      width: widget.fieldWidth,
      child: TextField(
        controller: _textControllers![i],
        keyboardType: widget.keyboardType,
        textAlign: TextAlign.center,
        maxLength: 1,
        style: widget.style,
        focusNode: _focusNodes![i],
        obscureText: widget.obscureText!,
        decoration: InputDecoration(
            counterText: "",
            border: widget.fieldStyle == FieldStyle.box
                ? OutlineInputBorder(borderSide: BorderSide(width: widget.fieldWidth!))
                : UnderlineInputBorder(borderSide: BorderSide(width: widget.fieldWidth!))),
        onChanged: (String str) {
          // Check if the current value at this position is empty
          // If it is move focus to previous text field.
          if (str.isEmpty) {
            if (i == 0) return;
            _focusNodes![i].unfocus();
            _focusNodes![i - 1].requestFocus();
          }

          // Update the current pin
          setState(() {
            _pin![i] = str;
          });

          // Remove focus
          if (str.isNotEmpty) _focusNodes![i].unfocus();
          // Set focus to the next field if available
          if (i + 1 != widget.length && str.isNotEmpty)
            FocusScope.of(context).requestFocus(_focusNodes![i + 1]);

          String currentPin = "";
          _pin!.forEach((String value) {
            currentPin += value;
          });

          // if there are no null values that means otp is completed
          // Call the `onCompleted` callback function provided
          if (!_pin!.contains(null) &&
              !_pin!.contains('') &&
              currentPin.length == widget.length) {
            widget.onCompleted!(currentPin);
          }

          // Call the `onChanged` callback function
          widget.onChanged!(currentPin);
        },
      ),
    );
  }
}
