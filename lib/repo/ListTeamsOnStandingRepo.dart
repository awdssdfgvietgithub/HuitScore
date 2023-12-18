import 'dart:developer';

import 'package:huit_score/model/foot/ShortTeamModel.dart';
import 'package:huit_score/model/foot/TeamOnStandingModel.dart';
import 'package:huit_score/res/AppFootApiUrl.dart';

import '../data/network/BaseApiServices.dart';
import '../data/network/NetworkApiService.dart';

class ListTeamsOnStandingRepo {
  //X_RapidAPI_Key5
  final BaseApiServices _apiServices = NetworkApiService5();

  Future<List<TeamOnStandingModel>> fetchTeamOnStanding(
    int tournamentId,
    int seasonId,
  ) async {
    try {
      List<TeamOnStandingModel> listTeamOnStanding = [];

      dynamic response = await _apiServices.getApiResponse(
          '${AppFootApiUrl.leagueTotalStandings}/$tournamentId/season/$seasonId/standings/total');

      for (Map standing in response['standings']) {
        for (Map row in standing['rows']) {
          int position = row['position'] ?? -1;
          log("position: $position");
          ShortTeamModel team = ShortTeamModel(
              id: row['team']?['id'] ?? 'N/a',
              name: row['team']?['name'] ?? 'N/a',
              shortName: row['team']?['shortName'] ?? 'N/a');
          log("shortName: ${team.shortName}");
          log("id: ${team.id}");
          int matches = row['matches'] ?? -1;
          int wins = row['wins'] ?? -1;
          int draws = row['draws'] ?? -1;
          int losses = row['losses'] ?? -1;
          int scoresFor = row['scoresFor'] ?? -1;
          int scoresAgainst = row['scoresAgainst'] ?? -1;
          int points = row['points'] ?? -1;
          int promotionId = row['promotion']?['id'] ?? -1;

          TeamOnStandingModel teamOnStandingModel = TeamOnStandingModel(
              position: position,
              team: team,
              matches: matches,
              wins: wins,
              draws: draws,
              losses: losses,
              scoresFor: scoresFor,
              scoresAgainst: scoresAgainst,
              points: points,
              promotionId: promotionId);
          listTeamOnStanding.add(teamOnStandingModel);
        }
      }
      return listTeamOnStanding;
    } catch (e) {
      rethrow;
    }
  }
}
