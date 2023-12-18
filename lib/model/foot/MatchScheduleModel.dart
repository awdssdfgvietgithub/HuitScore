

import 'package:huit_score/model/foot/ShortTeamModel.dart';
import 'package:huit_score/model/foot/StatusMatchModel.dart';
import 'package:huit_score/model/foot/TournamentModel.dart';

class MatchScheduleModel {
  int? id;
  TournamentModel? tournament;
  int? roundNumber;
  StatusMatchModel? statusMatch;
  int? winnerCode; //1: hometeam winner
  ShortTeamModel? homeTeam;
  ShortTeamModel? awayTeam;
  int? homeScore;
  int? awayScore;
  int? matchTimestamp;
  int? startTimestamp;
  int? extra;
  String? slug;

  MatchScheduleModel(
      {this.id,
      this.tournament,
      this.roundNumber,
      this.statusMatch,
      this.winnerCode,
      this.homeTeam,
      this.awayTeam,
      this.homeScore,
      this.awayScore,
      this.matchTimestamp,
      this.startTimestamp,
      this.extra,
      this.slug});
}
