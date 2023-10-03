import 'package:timeago/timeago.dart' as timeago;

class DateFormatter {
  DateFormatter._();

  /// Returns the time between two dates.
  ///
  /// * If the [from] parameter is not passed, it takes the value DateTime.now
  static String difference({DateTime? from, required DateTime to}) {
    from ??= DateTime.now();
    return timeago.format(from.subtract(DateTime.now().difference(to)));
  }
}
