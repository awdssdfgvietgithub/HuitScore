import 'dart:developer';

import 'package:intl/intl.dart';

extension IntParsing on int {
  DateTime parseToDate() {
    log("this: $this");
    DateTime dateTime =
        DateTime.fromMillisecondsSinceEpoch(this * 1000, isUtc: true);
    log("dateTime: $dateTime");

    dateTime = dateTime.add(const Duration(hours: 7));
    log("dateTime +7: $dateTime");


    return dateTime;
  }

  String parseToDateHM() {
    DateTime dateTime =
        DateTime.fromMillisecondsSinceEpoch(this * 1000, isUtc: true);

    dateTime = dateTime.add(const Duration(hours: 7));

    String formattedDateTime = DateFormat('HH:mm').format(dateTime);
    return formattedDateTime;
  }
}
