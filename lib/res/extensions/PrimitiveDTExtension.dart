import 'dart:developer';

import 'package:intl/intl.dart';

extension IntParsing on int {
  DateTime parseToDate() {
    log("this: $this");
    DateTime dateTime =
        DateTime.fromMillisecondsSinceEpoch(this * 1000, isUtc: true);

    dateTime = dateTime.add(const Duration(hours: 7));

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
