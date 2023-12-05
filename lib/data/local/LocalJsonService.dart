import 'dart:convert';

import 'package:flutter/services.dart';

class LocalJsonService  {
  Future getLocalJsonResponse(String resString) async {
      final response = await rootBundle.loadString(resString);
      final data = await jsonDecode(response);
      return data;
  }
}