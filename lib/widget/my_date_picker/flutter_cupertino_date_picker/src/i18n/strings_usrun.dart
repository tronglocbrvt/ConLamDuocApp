part of 'date_picker_i18n.dart';

/// USRUN language
class _StringsUSRUN extends _StringsI18n {
  const _StringsUSRUN();

  @override
  String getCancelText() {
    return 'Cancel';
  }

  @override
  String getDoneText() {
    return 'Done';
  }

  @override
  List<String> getMonths() {
    return [
      R.strings.january,
      R.strings.february,
      R.strings.march,
      R.strings.april,
      R.strings.may,
      R.strings.june,
      R.strings.july,
      R.strings.august,
      R.strings.september,
      R.strings.october,
      R.strings.november,
      R.strings.december,
    ];
  }

  @override
  List<String> getWeeksFull() {
    return [
      R.strings.monday,
      R.strings.tuesday,
      R.strings.wednesday,
      R.strings.thursday,
      R.strings.friday,
      R.strings.saturday,
      R.strings.sunday,
    ];
  }

  @override
  List<String> getWeeksShort() {
    return [
      R.strings.monday.contains("Mon") ? "Mon" : R.strings.monday,
      R.strings.tuesday.contains("Tue") ? "Tue" : R.strings.monday,
      R.strings.wednesday.contains("Wed") ? "Wed" : R.strings.monday,
      R.strings.thursday.contains("Thur") ? "Thur" : R.strings.monday,
      R.strings.friday.contains("Fri") ? "Fri" : R.strings.monday,
      R.strings.saturday.contains("Sat") ? "Sat" : R.strings.monday,
      R.strings.sunday.contains("Sun") ? "Sun" : "CN",
    ];
  }
}
