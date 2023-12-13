import 'package:intl/intl.dart';

class AppUrl {
  static const String X_RapidAPI_Key1 =
      '9262372523mshf1a0506aee46c7fp1568b3jsnbdcd9b47a46b';

  static const String X_RapidAPI_Key2 =
      '46b26cd8bdmsh1e2f3b75d56aeb7p19e9d4jsndb6e4d8ab80d';

  static const String X_RapidAPI_Key3 =
      'dc7c209217mshe8b8e539a18693bp18bfeajsn104b336cfa5b';

  static const String X_RapidAPI_Key4 =
      'f0ee741178mshf46917ca8463cb2p11555cjsn2409e3d2794b';

  static const String X_RapidAPI_Key5 =
      '69d6da4dd6msh00fd0aa3839b2dep162af6jsned796bd9e71a';

  static const String X_RapidAPI_Key6 =
      '6d638ef74amsh7bf2e6e9b1934bbp1cc314jsnd2e048482356';

  static const String X_RapidAPI_Key7 =
      '02102079a2msh842de6a4cedd42ep1c3500jsnaa9180147ea2';

  static var baseUrl = 'https://footapi7.p.rapidapi.com';

  static const String X_RapidAPI_Host = 'footapi7.p.rapidapi.com';

  //================================================================================//
  //get currently top match schedules
  static String formatter =
      DateFormat('dd/MM/yyyy').format(DateTime.now().toUtc());

  static var matchSchedulesUrl = '$baseUrl/api/matches/top/$formatter';

  //get all schedules in round
  // https://footapi7.p.rapidapi.com/api/tournament/23/season/52186/matches/round/10
  static var leagueEventsByRound = '$baseUrl/api/tournament';

  //get all season in league
  // https://footapi7.p.rapidapi.com/api/tournament/17/seasons
  static var leagueSeasons = '$baseUrl/api/tournament';

  //get all rounds in league
  // https://footapi7.p.rapidapi.com/api/tournament/7/season/36886/rounds
  static var leagueRounds = '$baseUrl/api/tournament';

  //get top media (url youtube)
  //https://footapi7.p.rapidapi.com/api/tournament/17/media,
  static var leagueMedia = '$baseUrl/api/tournament';

  //get league total standings
  //https://footapi7.p.rapidapi.com/api/tournament/7/season/36886/standings/total
  static var leagueTotalStandings = '$baseUrl/api/tournament';
}
