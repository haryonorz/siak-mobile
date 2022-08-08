import 'package:intl/intl.dart';

extension StringParsing on String {
  String parseDate({
    required String fromFormat,
    required String toFormat,
  }) {
    DateFormat format = DateFormat(fromFormat);
    DateTime dateTime = format.parse(this);
    return DateFormat(toFormat, "id_ID").format(dateTime);
  }
}
