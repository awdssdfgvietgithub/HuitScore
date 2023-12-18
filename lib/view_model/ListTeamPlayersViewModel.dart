import 'package:flutter/cupertino.dart';
import 'package:huit_score/model/foot/TeamPlayersModel.dart';
import 'package:huit_score/repo/ListTeamPlayerRepo.dart';

import '../data/response/ApiResponse.dart';

class ListTeamPlayersViewModel with ChangeNotifier {
  final _myRepo = ListTeamPlayerRepo();
  final int teamId;

  ListTeamPlayersViewModel(this.teamId);

  ApiResponse<TeamPlayerModel> listTeamPlayers = ApiResponse.loading();

  setListTeamPlayers(ApiResponse<TeamPlayerModel> response) {
    listTeamPlayers = response;
    notifyListeners();
  }

  Future<void> fetchTeamPlayersApi() async {
    setListTeamPlayers(ApiResponse.loading());

    _myRepo.fetchListTeamPlayers(teamId).then((value) {
      setListTeamPlayers(ApiResponse.success(value));
    }).onError((error, stackTrace) {
      setListTeamPlayers(ApiResponse.error(error.toString()));
    });
  }
}
