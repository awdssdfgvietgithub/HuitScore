import 'dart:developer';

import 'package:huit_score/model/PeriodModel.dart';
import 'package:huit_score/model/StatisticsModel.dart';

import '../data/network/BaseApiServices.dart';
import '../data/network/NetworkApiService.dart';
import '../model/StatisticsItemsModel.dart';
import '../res/AppUrl.dart';

class ListStatisticsMatchRepo {
  //X_RapidAPI_Key8
  final BaseApiServices _apiServices = NetworkApiService8();

  Future<List<StatisticsModel>> fetchListStatisticsMatch(
    int matchId,
  ) async {
    try {
      List<StatisticsModel> statisticsList = [];

      dynamic response = await _apiServices
          .getApiResponse('${AppUrl.statisticsMatch}/$matchId/statistics');

      log("matchId: $matchId");
      for (Map statistic in response['statistics']) {
        String periodName = statistic['period'] ?? 'N/a';
        log("periodName: $periodName");
        List<GroupModel> groupsList = [];
        for (Map group in statistic['groups']) {
          String groupName = group['groupName'] ?? 'N/a';
          log("groupName: $groupName");
          List<StatisticsItemModel> statisticsItemList = [];
          for (Map statisticsItem in group['statisticsItems']) {
            String name = statisticsItem['name'] ?? 'N/a';
            String home = statisticsItem['home'];
            String away = statisticsItem['away'];
            log("staticName: $name - home: $home - away - $away");
            StatisticsItemModel statisticsItemModel = StatisticsItemModel(
              name: name,
              home: home,
              away: away,
            );
            statisticsItemList.add(statisticsItemModel);
          }
          GroupModel groupModel = GroupModel(
              groupName:groupName,
              statisticsItemList: statisticsItemList
          );
          groupsList.add(groupModel);
        }
        StatisticsModel statisticsModel = StatisticsModel(
          periodName: periodName,
          groupsList: groupsList,
        );
        log("statisticsModel: ${statisticsModel.groupsList?.length}");
        statisticsList.add(statisticsModel);
      }

      return statisticsList;
    } catch (e) {
      rethrow;
    }
  }
}
