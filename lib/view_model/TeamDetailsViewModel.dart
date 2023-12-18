import 'package:flutter/cupertino.dart';
import 'package:huit_score/model/foot/TeamDetailsModel.dart';
import 'package:huit_score/repo/TeamDetailsRepo.dart';

import '../data/response/ApiResponse.dart';

class TeamDetailsViewModel with ChangeNotifier {
  final _myRepo = TeamDetailsRepo();
  final int teamId;

  TeamDetailsViewModel(this.teamId);

  ApiResponse2<TeamDetailsModel> teamDetails = ApiResponse2.loading();

  setTeamDetails(ApiResponse2<TeamDetailsModel> response) {
    teamDetails = response;
    notifyListeners();
  }

  Future<void> fetchTeamDetailsApi() async {
    setTeamDetails(ApiResponse2.loading());

    _myRepo.fetchTeamDetails(teamId).then((value) {
      setTeamDetails(ApiResponse2.success(value));
    }).onError((error, stackTrace) {
      setTeamDetails(ApiResponse2.error(error.toString()));
    });
  }
}
