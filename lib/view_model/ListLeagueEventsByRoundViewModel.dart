import 'package:flutter/cupertino.dart';
import 'package:huit_score/model/foot/MatchScheduleModel.dart';
import 'package:huit_score/repo/ListLeagueEventsByRoundRepo.dart';

import '../data/response/ApiResponse.dart';

class ListLeagueEventsByRoundViewModel with ChangeNotifier {
  final _myRepo = ListLeagueEventsByRoundRepo();

  // final int tournamentId;
  // final int seasonId;
  // final int round;
  //
  // ListLeagueEventsByRoundViewModel(
  //     this.tournamentId, this.seasonId, this.round);

  ApiResponse<MatchScheduleModel> matchSchedules = ApiResponse.loading();

  // ApiResponse<MatchScheduleModel> round1 = ApiResponse.loading();
  // ApiResponse<MatchScheduleModel> round2 = ApiResponse.loading();
  // ApiResponse<MatchScheduleModel> round3 = ApiResponse.loading();
  // ApiResponse<MatchScheduleModel> round4 = ApiResponse.loading();
  // ApiResponse<MatchScheduleModel> round5 = ApiResponse.loading();
  // ApiResponse<MatchScheduleModel> round6 = ApiResponse.loading();
  // ApiResponse<MatchScheduleModel> round7 = ApiResponse.loading();
  // ApiResponse<MatchScheduleModel> round8 = ApiResponse.loading();
  // ApiResponse<MatchScheduleModel> round9 = ApiResponse.loading();
  // ApiResponse<MatchScheduleModel> round10 = ApiResponse.loading();
  // ApiResponse<MatchScheduleModel> round11 = ApiResponse.loading();
  // ApiResponse<MatchScheduleModel> round12 = ApiResponse.loading();
  // ApiResponse<MatchScheduleModel> round13 = ApiResponse.loading();
  // ApiResponse<MatchScheduleModel> round14 = ApiResponse.loading();
  // ApiResponse<MatchScheduleModel> round15 = ApiResponse.loading();
  // ApiResponse<MatchScheduleModel> round16 = ApiResponse.loading();
  // ApiResponse<MatchScheduleModel> round17 = ApiResponse.loading();
  // ApiResponse<MatchScheduleModel> round18 = ApiResponse.loading();
  // ApiResponse<MatchScheduleModel> round19 = ApiResponse.loading();
  // ApiResponse<MatchScheduleModel> round20 = ApiResponse.loading();
  // ApiResponse<MatchScheduleModel> round21 = ApiResponse.loading();
  // ApiResponse<MatchScheduleModel> round22 = ApiResponse.loading();
  // ApiResponse<MatchScheduleModel> round23 = ApiResponse.loading();
  // ApiResponse<MatchScheduleModel> round24 = ApiResponse.loading();
  // ApiResponse<MatchScheduleModel> round25 = ApiResponse.loading();
  // ApiResponse<MatchScheduleModel> round26 = ApiResponse.loading();
  // ApiResponse<MatchScheduleModel> round27 = ApiResponse.loading();
  // ApiResponse<MatchScheduleModel> round28 = ApiResponse.loading();
  // ApiResponse<MatchScheduleModel> round29 = ApiResponse.loading();
  // ApiResponse<MatchScheduleModel> round30 = ApiResponse.loading();
  // ApiResponse<MatchScheduleModel> round31 = ApiResponse.loading();
  // ApiResponse<MatchScheduleModel> round32 = ApiResponse.loading();
  // ApiResponse<MatchScheduleModel> round33 = ApiResponse.loading();
  // ApiResponse<MatchScheduleModel> round34 = ApiResponse.loading();
  // ApiResponse<MatchScheduleModel> round35 = ApiResponse.loading();
  // ApiResponse<MatchScheduleModel> round36 = ApiResponse.loading();
  // ApiResponse<MatchScheduleModel> round37 = ApiResponse.loading();
  // ApiResponse<MatchScheduleModel> round38 = ApiResponse.loading();
  // ApiResponse<MatchScheduleModel> round39 = ApiResponse.loading();
  // ApiResponse<MatchScheduleModel> round40 = ApiResponse.loading();

  setMatchSchedules(ApiResponse<MatchScheduleModel> response) {
    // switch (round) {
    //   case 1:
    //     round1 = response;
    //   case 2:
    //     round2 = response;
    //   case 3:
    //     round3 = response;
    //   case 4:
    //     round4 = response;
    //   case 5:
    //     round5 = response;
    //   case 6:
    //     round6 = response;
    //   case 7:
    //     round7 = response;
    //   case 8:
    //     round8 = response;
    //   case 9:
    //     round9 = response;
    //   case 10:
    //     round10 = response;
    //   case 11:
    //     round11 = response;
    //   case 12:
    //     round12 = response;
    //   case 13:
    //     round13 = response;
    //   case 14:
    //     round14 = response;
    //   case 15:
    //     round15 = response;
    //   case 16:
    //     round16 = response;
    //   case 17:
    //     round17 = response;
    //   case 18:
    //     round18 = response;
    //   case 19:
    //     round19 = response;
    //   case 20:
    //     round20 = response;
    //   case 21:
    //     round21 = response;
    //   case 22:
    //     round22 = response;
    //   case 23:
    //     round23 = response;
    //   case 24:
    //     round24 = response;
    //   case 25:
    //     round25 = response;
    //   case 26:
    //     round26 = response;
    //   case 27:
    //     round27 = response;
    //   case 28:
    //     round28 = response;
    //   case 29:
    //     round29 = response;
    //   case 30:
    //     round30 = response;
    //   case 31:
    //     round31 = response;
    //   case 32:
    //     round32 = response;
    //   case 33:
    //     round33 = response;
    //   case 34:
    //     round34 = response;
    //   case 35:
    //     round35 = response;
    //   case 36:
    //     round36 = response;
    //   case 37:
    //     round37 = response;
    //   case 38:
    //     round38 = response;
    //   case 39:
    //     round39 = response;
    //   case 40:
    //     round40 = response;
    // }
    matchSchedules = response;
    notifyListeners();
  }

  Future<void> fetchMatchSchedules(
      int tournamentId, int seasonId, int round) async {
    setMatchSchedules(ApiResponse.loading());

    _myRepo.fetchMatchSchedules(tournamentId, seasonId, round).then((value) {
      setMatchSchedules(ApiResponse.success(value));
    }).onError((error, stackTrace) {
      setMatchSchedules(ApiResponse.error(error.toString()));
    });
  }
}
