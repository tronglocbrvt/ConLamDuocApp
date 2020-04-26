import 'package:flutter/material.dart';
import 'package:conlamduoc/core/R.dart';
import 'package:conlamduoc/widget/my_date_picker/flutter_cupertino_date_picker/flutter_cupertino_date_picker.dart';

class _MyDatePicker extends StatefulWidget {
  final DateTime initialDate;
  final DateTime firstDate;
  final DateTime lastDate;

  _MyDatePicker({
    @required this.initialDate,
    @required this.firstDate,
    @required this.lastDate,
  })  : assert(initialDate != null && firstDate != null && lastDate != null),
        assert(!firstDate.isAfter(lastDate));

  @override
  _MyDatePickerState createState() => _MyDatePickerState();
}

class _MyDatePickerState extends State<_MyDatePicker> {
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
      + intResultList = [int yearIndexResult, int monthIndexResult, int dayIndexResult]
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

  Widget _renderDayPicker() {
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
              R.strings.datePicker,
              style: TextStyle(
                color: R.colors.strongBlue,
                fontSize: R.appRatio.appFontSize18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            alignment: Alignment.topCenter,
            child: DatePickerWidget(
              null,
              minDateTime: widget.firstDate,
              maxDateTime: widget.lastDate,
              dateFormat: 'yyyy-MMMM-dd',
              initialDateTime: widget.initialDate,
              pickerTheme: DateTimePickerTheme(
                showTitle: false,
                itemTextStyle: null,
                pickerHeight: R.appRatio.appHeight250,
              ),
              onChange: _onChanged,
            ),
          ),
          _pickerActions(),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _renderDayPicker();
  }
}

Future<DateTime> showMyDatePicker({
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
          child: _MyDatePicker(
            firstDate: firstDate,
            initialDate: initialDate,
            lastDate: lastDate,
          ),
        );
      });
}
