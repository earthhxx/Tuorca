import 'package:intl/intl.dart';

class StringFormatUtil {
  DateFormat _format;

  String getTimeFormat(DateTime dateTime) {
    if (dateTime == null) return "--:--";

    _format = DateFormat('HH:mm');

    return _format.format(dateTime);
  }

  String getDateInForm(DateTime dateTime) {
    _format = DateFormat('dd/MM/yyyy');

    return _format.format(dateTime);
  }

  String getDateForParse(DateTime dateTime) {
    _format = DateFormat('yyyy-MM-dd');

    return _format.format(dateTime);
  }

  String getTimeForParse(DateTime dateTime) {
    if (dateTime == null) return "--:--";

    _format = DateFormat('HH:mm:ss');

    return _format.format(dateTime);
  }

  String getMonthHeaderCalendar(DateTime dateTime) {
    _format = DateFormat('MMM');

    return _format.format(dateTime);
  }
}
