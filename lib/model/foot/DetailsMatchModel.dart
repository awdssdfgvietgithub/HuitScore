import 'package:huit_score/model/foot/ShortTeamModel.dart';
import 'package:huit_score/model/foot/StatusMatchModel.dart';
import 'package:huit_score/model/foot/TournamentModel.dart';

import 'VenueModel.dart';

class DetailsMatchModel {
  ShortTeamModel? homeTeam;
  ShortTeamModel? awayTeam;
  TournamentModel? tournament;
  int? seasonId;
  int? round;
  StatusMatchModel? statusMatch;
  int? homeScore;
  int? awayScore;
  int? matchTimestamp;
  int? startTimestamp;
  int? extra;
  VenueModel? venue;

  DetailsMatchModel(
      {this.homeTeam,
      this.awayTeam,
      this.tournament,
      this.seasonId,
      this.round,
      this.statusMatch,
      this.homeScore,
      this.awayScore,
      this.matchTimestamp,
      this.startTimestamp,
      this.extra,
      this.venue});
}
