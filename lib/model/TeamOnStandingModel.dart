import 'ShortTeamModel.dart';

class TeamOnStandingModel {
  int? position;
  ShortTeamModel? team;
  int? matches;
  int? wins;
  int? draws;
  int? losses;
  int? scoresFor;
  int? scoresAgainst;
  int? points;
  int? promotionId;

  TeamOnStandingModel(
      {this.position,
      this.team,
      this.matches,
      this.wins,
      this.draws,
      this.losses,
      this.scoresFor,
      this.scoresAgainst,
      this.points,
      this.promotionId});
}
