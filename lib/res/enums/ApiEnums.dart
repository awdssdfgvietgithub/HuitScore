// ignore_for_file: constant_identifier_names

enum TournamentId {
  PREMIER_LEAGUE(1, 'assets/premier_league.png'),
  LALIGA(36, 'assets/laliga.png'),
  SERIA_A(33, 'assets/seria_a.png'),
  LIGUE_1(4, 'assets/ligue_1.png'),
  BUNDESLIGA(42, 'assets/bundesliga.png');

  const TournamentId(this.id, this.resString);

  final int id;
  final String resString;
}

List<int> tournamentIds = [
  TournamentId.PREMIER_LEAGUE.id,
  TournamentId.LALIGA.id,
  TournamentId.SERIA_A.id,
  TournamentId.LIGUE_1.id,
  TournamentId.BUNDESLIGA.id
];
