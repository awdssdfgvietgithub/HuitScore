// ignore_for_file: constant_identifier_names

enum TournamentId {
  PREMIER_LEAGUE(17, 'assets/premier_league.png', 52186),
  LALIGA(8, 'assets/laliga.png', 52376),
  SERIA_A(23, 'assets/seria_a.png', 52760),
  LIGUE_1(34, 'assets/ligue_1.png', 52571),
  BUNDESLIGA(35, 'assets/bundesliga.png', 52608);

  const TournamentId(this.id, this.resString, this.currentSeasonId);

  final int id;
  final String resString;
  final int currentSeasonId;
}

List<int> tournamentIds = [
  TournamentId.PREMIER_LEAGUE.id,
  TournamentId.LALIGA.id,
  TournamentId.SERIA_A.id,
  TournamentId.LIGUE_1.id,
  TournamentId.BUNDESLIGA.id
];
