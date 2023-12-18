
import 'package:huit_score/model/foot/StatisticsItemsModel.dart';

class PeriodModel {
  String? periodName = 'N/a';
  List<GroupModel>? groupsList = [];

  PeriodModel({
    this.periodName,
    this.groupsList
  });
}

class GroupModel{
  String? groupName;
  List<StatisticsItemModel>? statisticsItemList;

  GroupModel({this.groupName, this.statisticsItemList});
}
