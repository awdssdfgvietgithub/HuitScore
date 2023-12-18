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

  String parseToDateDMY() {
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(this * 1000, isUtc: true);
    String formattedDate = "${dateTime.day}-${dateTime.month}-${dateTime.year}";
    return formattedDate;
  }
}

extension DateParsing on String {
  String parseDateTime() {
    DateTime dateTime = DateTime.parse(this);
    String formattedDateTime = '${dateTime.day.toString().padLeft(2, '0')}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.year} ${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}:${dateTime.second.toString().padLeft(2, '0')}';
    return formattedDateTime;
  }
}

extension HtmlTagRemoval on String {
  String removeHtmlTagsAndNbsp() {
    // Loại bỏ thẻ HTML
    RegExp exp = RegExp(r"<[^>]*>", multiLine: true, caseSensitive: true);
    String withoutHtmlTags = replaceAll(exp, '');

    // Loại bỏ ký tự &nbsp;
    String withoutNbsp = withoutHtmlTags.replaceAll('\u00A0', ' ');

    return withoutNbsp;
  }
}
