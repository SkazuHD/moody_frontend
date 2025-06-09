import 'package:intl/intl.dart';

String getFullDate(DateTime date) {
  String formattedDate = DateFormat.yMd().format(date);
  String formattedTime = DateFormat.Hm().format(date);
  return '$formattedDate $formattedTime';
}
