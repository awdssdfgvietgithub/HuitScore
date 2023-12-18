import 'dart:developer';

import 'package:huit_score/model/foot/PeriodModel.dart';
import 'package:huit_score/model/foot/StatisticsItemsModel.dart';
import 'package:huit_score/model/foot/StatisticsModel.dart';
import 'package:huit_score/res/AppFootApiUrl.dart';

import '../data/network/BaseApiServices.dart';
import '../data/network/NetworkApiService.dart';

class ListStatisticsMatchRepo {
  //X_RapidAPI_Key8
  final BaseApiServices _apiServices = NetworkApiService8();

  Future<List<StatisticsModel>> fetchListStatisticsMatch(
    int matchId,
  ) async {
    try {
      List<StatisticsModel> statisticsList = [];

      dynamic response = await _apiServices
          .getApiResponse('${AppFootApiUrl.statisticsMatch}/$matchId/statistics');

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
