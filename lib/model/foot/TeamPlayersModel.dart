import 'TeamModel.dart';

class TeamPlayerModel {
  String? name;
  String? position;
  int? height;
  String? preferredFoot;
  bool? retired;
  int? id;
  String? countryName;
  int? shirtNumber;
  int? dateOfBirthTimestamp;
  int? contractUntilTimestamp;
  int? proposedMarketValue;

  TeamPlayerModel(
      {this.name,
      this.position,
      this.height,
      this.preferredFoot,
      this.retired,
      this.id,
      this.countryName,
      this.shirtNumber,
      this.dateOfBirthTimestamp,
      this.contractUntilTimestamp,
      this.proposedMarketValue});
}
