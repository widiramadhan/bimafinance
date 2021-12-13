import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';

class DatePickerField extends StatefulWidget {
  final String? labelText;
  final bool enabled;
  final Function(DateTime)? onPicked;
  final DateTime? maxTime;
  final DateTime? minTime;
  final DateTime? initialValue;
  final String? hintText;
  final Widget? suffixIcon;
  final String? dateFormat;
  final String? errorText;

  const DatePickerField({Key? key, this.enabled = true, this.onPicked, this.maxTime, this.minTime, this.initialValue, this.errorText, this.labelText, this.hintText, this.suffixIcon, this.dateFormat}) : super(key: key);

  @override
  _DatePickerFieldState createState() => _DatePickerFieldState();
}

class _DatePickerFieldState extends State<DatePickerField> {
  DateTime? _current;

  @override
  void initState() {
    if (widget.initialValue != null && _current == null) {
      _current = widget.initialValue;
    }
    super.initState();
  }

  void setDate() async {
    FocusManager.instance.primaryFocus!.unfocus();
    _current = await DatePicker.showDatePicker(context, showTitleActions: true, minTime: widget.minTime, maxTime: widget.maxTime, locale: LocaleType.id, onChanged: (date) {
      // printDebug('change $date');
    }, onConfirm: (date) {
      // printDebug('confirm $date');
    });
    setState(() {
      if (widget.onPicked != null) widget.onPicked!(_current!);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (widget.labelText != null)
          Text(
            widget.labelText!,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: Colors.grey
            ),
          ),
        SizedBox(
          height: 10,
        ),
        InkWell(
          onTap: widget.enabled ? () => setDate() : null,
          child: InputDecorator(
              decoration: InputDecoration(
                filled: true,
                fillColor: Color(0xfff5f6f8),
                hintText: widget.hintText,
                errorText: widget.errorText,
                suffixIcon: widget.suffixIcon,
                border: OutlineInputBorder(
                  borderSide: BorderSide(width: 1, color: Color(0xffdedede)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 1, color: Color(0xffdedede)),
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                      flex: 1,
                      child: _current != null
                          ? Text(
                              _current!.toFormatsString(format: widget.dateFormat),
                              maxLines: 1,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14
                              ),
                            )
                          : Text(
                              widget.hintText ?? 'Pilih tanggal',
                              style: TextStyle(
                                  color: Colors.grey,
                                fontSize: 14
                              ),
                            )),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Icon(
                      Icons.calendar_today_outlined,
                      color: Color(0xff524e51),
                      size: 20,
                    ),
                  )
                ],
              )),
        ),
      ],
    );
  }
}

extension DateTimeExtension on DateTime {
  String toFormatsString({String? format}) => DateFormat(format ?? "EEEE, MMMM dd, yyyy").format(this);
}
