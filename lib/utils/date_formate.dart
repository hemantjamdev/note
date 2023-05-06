import 'package:intl/intl.dart';

String formattedDate(DateTime dateTime) {
  String formattedDate =
      DateFormat("dd'${getOrdinalSuffix(dateTime.day)}' MMM yy  hh:mm")
          .format(dateTime);
  return formattedDate;
}

String getOrdinalSuffix(int day) {
  if (day >= 11 && day <= 13) {
    return "th";
  }
  switch (day % 10) {
    case 1:
      return "st";
    case 2:
      return "nd";
    case 3:
      return "rd";
    default:
      return "th";
  }
}
