

import 'package:huit_score/model/foot/PlayerColorModel.dart';
import 'package:huit_score/model/foot/PlayerModel.dart';

class LineupsModel {
  List<PlayerModel>? homePlayers;
  List<PlayerModel>? awayPlayers;
  String? homeFormation;
  String? awayFormation;
  PlayerColorModel? homePlayerColor;
  PlayerColorModel? awayPlayerColor;
  PlayerColorModel? homeGoalkeeperColor;
  PlayerColorModel? awayGoalkeeperColor;

  LineupsModel(
      {this.homePlayers,
      this.awayPlayers,
      this.homeFormation,
      this.awayFormation,
      this.homePlayerColor,
      this.awayPlayerColor,
      this.homeGoalkeeperColor,
      this.awayGoalkeeperColor});
}
