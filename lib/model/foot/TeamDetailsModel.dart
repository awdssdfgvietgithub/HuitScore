import 'TournamentModel.dart';
import 'VenueModel.dart';

class TeamDetailsModel {
  String? fullTeamName;
  String? shortName;
  String? gender;
  TournamentModel? tournament;
  String? managerName;
  VenueModel? venue;
  int? id;
  int? foundationDateTimestamp;

  TeamDetailsModel(
      {this.fullTeamName,
      this.shortName,
      this.gender,
      this.tournament,
      this.managerName,
      this.venue,
      this.id,
      this.foundationDateTimestamp});
}
