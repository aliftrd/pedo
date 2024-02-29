import 'package:intl/intl.dart';

class EpochDate {
  static DateTime fromEpoch(int epoch) {
    return DateTime.fromMicrosecondsSinceEpoch(epoch * 1000);
  }

  static int toEpoch(DateTime date) {
    return date.millisecondsSinceEpoch ~/ 1000;
  }

  static String toDate(String format, int epoch) {
    final DateTime time = EpochDate.fromEpoch(epoch);
    final DateFormat formatter = DateFormat(format);
    final String formatted = formatter.format(time);
    return formatted;
  }
}
