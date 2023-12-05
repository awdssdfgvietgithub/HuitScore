import 'CategoryModel.dart';

class TournamentModel {
  int? tournamentId; //1: premier league
  String? tournamentName;
  CategoryModel? category;

  TournamentModel({this.tournamentId, this.tournamentName, this.category});
}
