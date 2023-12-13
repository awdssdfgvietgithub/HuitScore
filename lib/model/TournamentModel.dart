import 'CategoryModel.dart';

class TournamentModel {
  int? tournamentId;
  String? tournamentName;
  CategoryModel? category;

  TournamentModel({this.tournamentId, this.tournamentName, this.category});
}
