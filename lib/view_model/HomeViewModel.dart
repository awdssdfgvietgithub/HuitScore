import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:huit_score/data/response/ApiResponse.dart';
import 'package:huit_score/model/ImageUrlModel.dart';
import 'package:huit_score/repo/HomeRepo.dart';
import 'package:huit_score/res/enums/ApiEnums.dart';

import '../model/MatchScheduleModel.dart';

class HomeViewModel with ChangeNotifier {
  final _myRepo = HomeRepo();

  ApiResponse<MatchScheduleModel> matchSchedules = ApiResponse.loading();

  List<MatchScheduleModel> premierLeagueMatches = [];
  List<MatchScheduleModel> laligaMatches = [];
  List<MatchScheduleModel> seriaAMatches = [];
  List<MatchScheduleModel> ligue1Matches = [];
  List<MatchScheduleModel> bundesligaMatches = [];
  List<MatchScheduleModel> liveMatches = [];

  setMatchSchedules(ApiResponse<MatchScheduleModel> response) {
    matchSchedules = response;
    filterLists();
    notifyListeners();
  }

  Future<void> fetchMoviesListApi() async {
    setMatchSchedules(ApiResponse.loading());

    _myRepo.fetchMatchSchedules().then((value) {
      setMatchSchedules(ApiResponse.success(value));
    }).onError((error, stackTrace) {
      setMatchSchedules(ApiResponse.error(error.toString()));
    });
  }

  Future<void> filterLists() async {
    premierLeagueMatches = matchSchedules.data
            ?.where((item) =>
                item.tournament?.tournamentId == TournamentId.PREMIER_LEAGUE.id)
            .toList() ??
        [];
    log("premierLeagueMatches ${premierLeagueMatches.length}");

    laligaMatches = matchSchedules.data
            ?.where((item) =>
                item.tournament?.tournamentId == TournamentId.LALIGA.id)
            .toList() ??
        [];
    log("laligaMatches ${laligaMatches.length}");

    seriaAMatches = matchSchedules.data
            ?.where((item) =>
                item.tournament?.tournamentId == TournamentId.SERIA_A.id)
            .toList() ??
        [];
    log("seriaAMatches ${seriaAMatches.length}");

    ligue1Matches = matchSchedules.data
            ?.where((item) =>
                item.tournament?.tournamentId == TournamentId.LIGUE_1.id)
            .toList() ??
        [];
    log("ligue1Matches ${ligue1Matches.length}");

    bundesligaMatches = matchSchedules.data
            ?.where((item) =>
                item.tournament?.tournamentId == TournamentId.BUNDESLIGA.id)
            .toList() ??
        [];
    log("bundesligaMatches ${bundesligaMatches.length}");

    liveMatches = matchSchedules.data
            ?.where((item) =>
                item.statusMatch?.code == 6 || item.statusMatch?.code == 7)
            .toList() ??
        [];
    log("liveMatches ${liveMatches.length}");
  }

  Future<void> refresh() async {
    await fetchMoviesListApi();
  }
}
