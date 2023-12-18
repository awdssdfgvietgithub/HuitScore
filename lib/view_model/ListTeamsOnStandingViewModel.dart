
import 'package:flutter/cupertino.dart';
import 'package:huit_score/model/foot/TeamOnStandingModel.dart';
import 'package:huit_score/repo/ListTeamsOnStandingRepo.dart';

import '../data/response/ApiResponse.dart';

class ListTeamsOnStandingViewModel with ChangeNotifier {
  final _myRepo = ListTeamsOnStandingRepo();
  final int tournamentId;
  final int seasonId;

  ListTeamsOnStandingViewModel(this.tournamentId, this.seasonId);

  ApiResponse<TeamOnStandingModel> teamsOnStanding = ApiResponse.loading();

  setTeamsOnStanding(ApiResponse<TeamOnStandingModel> response) {
    teamsOnStanding = response;
    notifyListeners();
  }

  Future<void> fetchTeamsOnStandingApi() async {
    setTeamsOnStanding(ApiResponse.loading());
    _myRepo.fetchTeamOnStanding(tournamentId, seasonId).then((value) {
      setTeamsOnStanding(ApiResponse.success(value));
    }).onError((error, stackTrace) {
      setTeamsOnStanding(ApiResponse.error(error.toString()));
    });
  }
}
