import 'dart:developer';
import 'dart:ffi';

import 'package:huit_score/data/local/LocalJsonService.dart';
import 'package:huit_score/data/network/BaseApiServices.dart';
import 'package:huit_score/data/network/NetworkApiService.dart';
import 'package:huit_score/model/CategoryModel.dart';
import 'package:huit_score/model/MatchScheduleModel.dart';
import 'package:huit_score/model/ShortTeamModel.dart';
import 'package:huit_score/model/StatusMatchModel.dart';
import 'package:huit_score/model/TournamentModel.dart';
import 'package:huit_score/res/AppUrl.dart';
import 'package:huit_score/res/enums/ApiEnums.dart';

class HomeRepo {
  final BaseApiServices _apiServices = NetworkApiService();

  Future<List<MatchScheduleModel>> fetchMatchSchedules() async {
    try {
      List<MatchScheduleModel> dataList = [];
      dynamic response =
          await _apiServices.getApiResponse(AppUrl.matchSchedulesUrl);
      for (Map event in response['events']) {
        // if (tournamentIds.contains(event['tournament']?['id'])) {
        int id = event['id'] ?? -1;
        log("id: ${id}");
        TournamentModel tournament = TournamentModel(
            tournamentId: event['tournament']?['id'] ?? -1,
            tournamentName: event['tournament']?['name'] ?? 'N/a',
            category: CategoryModel(
                id: event['tournament']?['category']?['id'] ?? -1,
                name: event['tournament']?['category']?['name'] ?? 'N/a'));
        log("${tournament.tournamentName} ${tournament.tournamentId}\n${tournament.category?.name} ${tournament.category?.id}");
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
        int startTimestamp = event['startTimestamp'] ?? -1;
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
            startTimestamp: startTimestamp,
            slug: slug);
        dataList.add(matchSchedule);
        // }
      }
      return dataList;
    } catch (e) {
      rethrow;
    }
  }
}
