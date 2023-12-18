import 'dart:developer';

import 'package:huit_score/data/network/BaseApiServices.dart';
import 'package:huit_score/data/network/NetworkApiService.dart';
import 'package:huit_score/model/foot/CategoryModel.dart';
import 'package:huit_score/model/foot/MatchScheduleModel.dart';
import 'package:huit_score/model/foot/ShortTeamModel.dart';
import 'package:huit_score/model/foot/StatusMatchModel.dart';
import 'package:huit_score/model/foot/TournamentModel.dart';
import 'package:huit_score/res/AppFootApiUrl.dart';

class HomeRepo {
  //X_RapidAPI_Key1 || X_RapidAPI_Key2
  final BaseApiServices _apiServices = NetworkApiService2();

  Future<List<MatchScheduleModel>> fetchMatchSchedules() async {
    try {
      List<MatchScheduleModel> dataList = [];
      dynamic response =
          await _apiServices.getApiResponse(AppFootApiUrl.matchSchedulesUrl);
      for (Map event in response['events']) {
        // if (tournamentIds
        //     .contains(event['tournament']?['uniqueTournament']?['id'] ?? -1)) {
          int id = event['id'] ?? -1;
          TournamentModel tournament = TournamentModel(
              tournamentId:
                  event['tournament']?['uniqueTournament']?['id'] ?? -1,
              tournamentName: event['tournament']?['name'] ?? 'N/a',
              category: CategoryModel(
                  id: event['tournament']?['category']?['id'] ?? -1,
                  name: event['tournament']?['category']?['name'] ?? 'N/a'));
          int roundNumber = event['roundInfo']?['round'] ?? -1;
          StatusMatchModel statusMatch = StatusMatchModel(
              code: event['status']?['code'] ?? -1,
              description: event['status']?['description'] ?? 'N/a',
              type: event['status']?['type'] ?? "N/a");
          int winnerCode = event['winnerCode'] ?? -1;
          ShortTeamModel homeTeam = ShortTeamModel(
              id: event['homeTeam']?['id'] ?? -1,
              name: event['homeTeam']?['name'] ?? 'N/a',
              shortName: event['homeTeam']?['shortName'] ?? 'N/a');
          ShortTeamModel awayTeam = ShortTeamModel(
              id: event['awayTeam']?['id'] ?? -1,
              name: event['awayTeam']?['name'] ?? 'N/a',
              shortName: event['awayTeam']?['shortName'] ?? 'N/a');
          int homeScore = event['homeScore']?['display'] ?? -1;
          int awayScore = event['awayScore']?['display'] ?? -1;
          int matchTimestamp = event['changes']?['changeTimestamp'] ?? -1;
          int startTimestamp = event['startTimestamp'] ?? -1;
          int extra = event['time']?['extra'] ?? 780;
          String slug = event['slug'] ?? 'N/a';

          MatchScheduleModel matchSchedule = MatchScheduleModel(
              id: id,
              tournament: tournament,
              roundNumber: roundNumber,
              statusMatch: statusMatch,
              winnerCode: winnerCode,
              homeTeam: homeTeam,
              awayTeam: awayTeam,
              homeScore: homeScore,
              awayScore: awayScore,
              matchTimestamp: matchTimestamp,
              startTimestamp: startTimestamp,
              extra: extra,
              slug: slug);
          dataList.add(matchSchedule);
        }
      // }
      return dataList;
    } catch (e) {
      rethrow;
    }
  }
}
