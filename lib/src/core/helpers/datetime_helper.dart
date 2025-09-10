import 'package:intl/intl.dart';

class DatetimeHelper {
  static DateTime parse(
      {required String input, String? format = "dd-MM-yyyy"}) {
    final formatter = DateFormat(format);
    final date = formatter.parse(input);

    return date;
  }
}
