import 'package:intl/intl.dart';

class AppFootApiUrl {
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

  static const String X_RapidAPI_Key8 =
      '1d673b8767msh8b88befb9fd7420p1015e8jsn7d3557c4fbce';

  static const String X_RapidAPI_Key9 =
      '3bf423085cmshea459e44d9f4af6p10a3aajsnd8cda79c9b4e';

  static const String X_RapidAPI_Key10 =
      '687572078fmshacec1c13cf3337ep1455c5jsn98a6e94aad14';

  static const String X_RapidAPI_Key11 =
      '608f770307mshcabba2645ea8426p1882edjsncfb89072083f';

  static var baseUrl = 'https://footapi7.p.rapidapi.com';

  static const String X_RapidAPI_Host = 'footapi7.p.rapidapi.com';

  //=======================================USING=========================================//
  //get currently top match schedules X_RapidAPI_Key1 || X_RapidAPI_Key2
  static String formatter =
      DateFormat('dd/MM/yyyy').format(DateTime.now().toUtc());

  static var matchSchedulesUrl = '$baseUrl/api/matches/top/$formatter';

  //get all schedules in round X_RapidAPI_Key3 || X_RapidAPI_Key4
  // https://footapi7.p.rapidapi.com/api/tournament/23/season/52186/matches/round/10
  static var leagueEventsByRound = '$baseUrl/api/tournament';

  //get league total standings X_RapidAPI_Key5
  //https://footapi7.p.rapidapi.com/api/tournament/7/season/36886/standings/total
  static var leagueTotalStandings = '$baseUrl/api/tournament';

  //get details match X_RapidAPI_Key6
  //https://footapi7.p.rapidapi.com/api/match/mã trận đấu
  static var detailsMatch = '$baseUrl/api/match';

  //get lineups match X_RapidAPI_Key7
  //https://footapi7.p.rapidapi.com/api/match/mã trận đấu/lineups
  static var lineupsMatch = '$baseUrl/api/match';

  //get statistics match X_RapidAPI_Key8
  //https://footapi7.p.rapidapi.com/api/match/mã trận đấu/statistics
  static var statisticsMatch = '$baseUrl/api/match';

  //get team players X_RapidAPI_Key10
  //https://footapi7.p.rapidapi.com/api/team/2672/players
  static var teamPlayers = '$baseUrl/api/team';

  //get team details X_RapidAPI_Key11
  //https://footapi7.p.rapidapi.com/api/team/2672
  static var teamDetails = '$baseUrl/api/team';

  //=======================================LATER=========================================//
  //get all season in league
  // https://footapi7.p.rapidapi.com/api/tournament/17/seasons
  static var leagueSeasons = '$baseUrl/api/tournament';

  //get all rounds in league
  // https://footapi7.p.rapidapi.com/api/tournament/7/season/36886/rounds
  static var leagueRounds = '$baseUrl/api/tournament';

  //get top media (url youtube)
  //https://footapi7.p.rapidapi.com/api/tournament/17/media,
  static var leagueMedia = '$baseUrl/api/tournament';
}
