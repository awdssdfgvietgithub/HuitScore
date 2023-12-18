import 'dart:developer';

import 'package:huit_score/model/foot/LeagueRoundModel.dart';
import 'package:huit_score/res/AppFootApiUrl.dart';

import '../data/network/BaseApiServices.dart';
import '../data/network/NetworkApiService.dart';

class ListLeagueRoundsRepo {
  final BaseApiServices _apiServices = NetworkApiService4();

  Future<LeagueRoundModel> fetchLeagueRounds(
    int tournamentId,
    int seasonId,
  ) async {
    try {
      LeagueRoundModel leagueRound;
      dynamic response = await _apiServices.getApiResponse(
          '${AppFootApiUrl.leagueRounds}/$tournamentId/season/$seasonId/rounds');

      int currentRound = response['currentRound']?['round'] ?? -1;
      log("currentRound: $currentRound");
      List<int> rounds = [];
      for (Map event in response['rounds']) {
        int round = event['round'] ?? -1;
        log("round: $round");

        rounds.add(round);
      }
      leagueRound =
          LeagueRoundModel(currentRound: currentRound, rounds: rounds);
      return leagueRound;
    } catch (e) {
      rethrow;
    }
  }
}
