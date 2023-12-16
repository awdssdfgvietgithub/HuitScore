import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:huit_score/model/StatisticsModel.dart';
import 'package:huit_score/repo/ListStatisticsMathRepo.dart';
import 'package:huit_score/res/enums/ApiEnums.dart';

import '../data/response/ApiResponse.dart';
import '../model/PeriodModel.dart';

class ListStatisticsMatchViewModel with ChangeNotifier {
  final _myRepo = ListStatisticsMatchRepo();
  final int matchId;

  ListStatisticsMatchViewModel(this.matchId);

  ApiResponse<StatisticsModel> statisticsList = ApiResponse.loading();

  List<GroupModel> allGroupsList = [];
  List<GroupModel> oneSTGroupsList = [];
  List<GroupModel> twoNDGroupsList = [];

  setStatisticsList(ApiResponse<StatisticsModel> response) {
    statisticsList = response;
    getGroupByPeriod();
    notifyListeners();
  }

  Future<void> fetchStatisticsListApi() async {
    setStatisticsList(ApiResponse.loading());

    _myRepo.fetchListStatisticsMatch(matchId).then((value) {
      setStatisticsList(ApiResponse.success(value));
    }).onError((error, stackTrace) {
      setStatisticsList(ApiResponse.error(error.toString()));
    });
  }

  Future<void> getGroupByPeriod() async {
    allGroupsList = statisticsList.data
            ?.firstWhere((element) => element.periodName == Period.ALL.name,
                orElse: () => StatisticsModel())
            .groupsList ??
        [];
    oneSTGroupsList = statisticsList.data
            ?.firstWhere((element) => element.periodName == Period.ONE_ST.name,
                orElse: () => StatisticsModel())
            .groupsList ??
        [];
    twoNDGroupsList = statisticsList.data
            ?.firstWhere((element) => element.periodName == Period.TWO_ND.name,
                orElse: () => StatisticsModel())
            .groupsList ??
        [];
  }
}
