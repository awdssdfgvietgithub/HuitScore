import 'package:intl/intl.dart';

class AppUrl {
  static var baseUrl = 'https://footapi7.p.rapidapi.com';
  static const String X_RapidAPI_Host = 'footapi7.p.rapidapi.com';
  static String formatter =
      DateFormat('dd/MM/yyyy').format(DateTime.now().toUtc());


  static var matchSchedulesUrl = '$baseUrl/api/matches/$formatter';

  static const String X_RapidAPI_Key1 =
      '9262372523mshf1a0506aee46c7fp1568b3jsnbdcd9b47a46b';

  static const String X_RapidAPI_Key2 =
      '46b26cd8bdmsh1e2f3b75d56aeb7p19e9d4jsndb6e4d8ab80d';
}
