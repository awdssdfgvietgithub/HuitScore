import 'package:flutter/cupertino.dart';
import 'package:huit_score/model/foot/LeagueRoundModel.dart';
import 'package:huit_score/repo/ListLeagueRoundsRepo.dart';

import '../data/response/ApiResponse.dart';

class ListLeagueRoundsViewModel with ChangeNotifier {
  final _myRepo = ListLeagueRoundsRepo();
  final int tournamentId;
  final int seasonId;

  ListLeagueRoundsViewModel(this.tournamentId, this.seasonId);

  ApiResponse2<LeagueRoundModel> leagueRounds = ApiResponse2.loading();

  setLeagueRounds(ApiResponse2<LeagueRoundModel> response) {
    leagueRounds = response;
    notifyListeners();
  }

  Future<void> fetchLeagueRoundsApi() async {
    setLeagueRounds(ApiResponse2.loading());

    _myRepo.fetchLeagueRounds(tournamentId, seasonId).then((value) {
      setLeagueRounds(ApiResponse2.success(value));
    }).onError((error, stackTrace) {
      setLeagueRounds(ApiResponse2.error(error.toString()));
    });
  }
}
