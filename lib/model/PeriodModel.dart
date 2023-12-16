import 'StatisticsItemsModel.dart';

class PeriodModel {
  String? periodName = 'N/a';
  List<GroupModel>? groupsList = [];

  // StatisticsItemsModel? ballPossession;
  // StatisticsItemsModel? totalShots;
  // StatisticsItemsModel? cornerKicks;
  // StatisticsItemsModel? bigChances;
  // StatisticsItemsModel? passes;
  // StatisticsItemsModel? dribbles;
  // StatisticsItemsModel? tackles;

  // PeriodModel(
  //     {this.name,
  //     this.ballPossession,
  //     this.totalShots,
  //     this.cornerKicks,
  //     this.bigChances,
  //     this.passes,
  //     this.dribbles,
  //     this.tackles});
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
