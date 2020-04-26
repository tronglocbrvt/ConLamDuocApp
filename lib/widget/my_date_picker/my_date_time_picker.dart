import 'package:conlamduoc/core/R.dart';
import 'package:conlamduoc/widget/my_date_picker/flutter_cupertino_date_picker/flutter_cupertino_date_picker.dart';
import 'package:flutter/material.dart';

class _MyDateTimePicker extends StatefulWidget {
  final DateTime initialDate;
  final DateTime firstDate;
  final DateTime lastDate;

  _MyDateTimePicker({
    @required this.initialDate,
    @required this.firstDate,
    @required this.lastDate,
  })  : assert(initialDate != null && firstDate != null && lastDate != null),
        assert(!firstDate.isAfter(lastDate));

  @override
  _MyDateTimePickerState createState() => _MyDateTimePickerState();
}

class _MyDateTimePickerState extends State<_MyDateTimePicker> {
  DateTime _selectedDate;

  @override
  void initState() {
    _selectedDate = widget.initialDate;
    super.initState();
  }

  void _handleCancel() {
    Navigator.pop(context);
  }

  void _handleOk() {
    Navigator.pop(context, _selectedDate);
  }

  void _onChanged(value, intResultList) {
    /*
      + intResultList = [int hourIndexResult, int minuteIndexResult, int secondIndexResult]
      + But it isn't necessary to use.
    */
    setState(() {
      _selectedDate = value;
    });
  }

  Widget _pickerActions() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        FlatButton(
          highlightColor: Colors.transparent,
          splashColor: R.colors.lightGreen,
          child: Text(
            R.strings.cancel,
            style: TextStyle(
              color: R.colors.strongBlue,
              fontSize: R.appRatio.appFontSize18,
            ),
          ),
          onPressed: _handleCancel,
        ),
        FlatButton(
          highlightColor: Colors.transparent,
          splashColor: R.colors.lightGreen,
          child: Text(
            R.strings.ok,
            style: TextStyle(
              color: R.colors.strongBlue,
              fontSize: R.appRatio.appFontSize18,
            ),
          ),
          onPressed: _handleOk,
        ),
      ],
    );
  }

  Widget _renderDateTimePicker() {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            color: R.colors.green,
            height: R.appRatio.appHeight60,
            alignment: Alignment.center,
            child: Text(
              R.strings.dateTimePicker,
              style: TextStyle(
                color: R.colors.strongBlue,
                fontSize: R.appRatio.appFontSize18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            alignment: Alignment.topCenter,
            child: DateTimePickerWidget(
              minDateTime: widget.firstDate,
              maxDateTime: widget.lastDate,
              initDateTime: widget.initialDate,
              dateFormat: 'dd/MM/yyyy, H:m',
              pickerTheme: DateTimePickerTheme(
                showTitle: false,
                itemTextStyle: null,
                pickerHeight: R.appRatio.appHeight250,
              ),
              onChange: _onChanged,
            ),
          ),
          Container(
            padding: EdgeInsets.only(
              right: R.appRatio.appSpacing15,
            ),
            child: Text(
              "(dd/MM/yyyy, hh:mm)",
              textAlign: TextAlign.right,
              style: TextStyle(
                color: Colors.black,
                fontStyle: FontStyle.italic,
                fontSize: R.appRatio.appFontSize12,
              ),
            ),
          ),
          _pickerActions(),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _renderDateTimePicker();
  }
}

Future<DateTime> showMyDateTimePicker({
  @required BuildContext context,
  @required DateTime initialDate,
  @required DateTime firstDate,
  @required DateTime lastDate,
}) async {
  return await showDialog<DateTime>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          child: _MyDateTimePicker(
            firstDate: firstDate,
            initialDate: initialDate,
            lastDate: lastDate,
          ),
        );
      });
}
