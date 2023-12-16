import 'package:huit_score/model/CategoryModel.dart';
import 'package:huit_score/model/DetailsMatchModel.dart';
import 'package:huit_score/model/TournamentModel.dart';
import 'package:huit_score/model/VenueModel.dart';

import '../data/network/BaseApiServices.dart';
import '../data/network/NetworkApiService.dart';
import '../model/ShortTeamModel.dart';
import '../model/StatusMatchModel.dart';
import '../res/AppUrl.dart';

class DetailsMatchRepo {
  //X_RapidAPI_Key6
  final BaseApiServices _apiServices = NetworkApiService6();

  Future<DetailsMatchModel> fetchDetailsMatch(
    int matchId,
  ) async {
    try {
      DetailsMatchModel detailsMatchModel;

      dynamic response =
          await _apiServices.getApiResponse('${AppUrl.detailsMatch}/$matchId');

      ShortTeamModel homeTeam = ShortTeamModel(
          id: response['event']?['homeTeam']?['id'] ?? -1,
          name: response['event']?['homeTeam']?['name'] ?? 'N/a',
          shortName: response['event']?['homeTeam']?['shortName'] ?? 'N/a',
          shortNameManager: response['event']?['homeTeam']?['manager']
                  ?['shortName'] ??
              'N/a');
      ShortTeamModel awayTeam = ShortTeamModel(
          id: response['event']?['awayTeam']?['id'] ?? -1,
          name: response['event']?['awayTeam']?['name'] ?? 'N/a',
          shortName: response['event']?['awayTeam']?['shortName'] ?? 'N/a',
          shortNameManager: response['event']?['awayTeam']?['manager']
                  ?['shortName'] ??
              'N/a');
      TournamentModel tournament = TournamentModel(
        tournamentId:
            response['event']?['tournament']?['uniqueTournament']?['id'] ?? -1,
        tournamentName: response['event']?['tournament']?['uniqueTournament']
                ?['name'] ??
            'N/a',
        category: CategoryModel(
          id: response['event']?['tournament']?['uniqueTournament']?['category']
                  ?['id'] ??
              -1,
          name: response['event']?['tournament']?['uniqueTournament']
                  ?['category']?['name'] ??
              'N/a',
        ),
      );
      int seasonId = response['event']?['season']?['id'] ?? -1;
      int round = response['event']?['roundInfo']?['round'] ?? -1;
      StatusMatchModel statusMatch = StatusMatchModel(
          code: response['event']?['status']?['code'] ?? -1,
          description: response['event']?['status']?['description'] ?? 'N/a',
          type: response['event']?['status']?['type'] ?? 'N/a');
      int homeScore = response['event']?['homeScore']?['display'] ?? -1;
      int awayScore = response['event']?['awayScore']?['display'] ?? -1;
      int matchTimestamp =
          response['event']?['changes']?['changeTimestamp'] ?? -1;
      int startTimestamp = response['event']?['startTimestamp'] ?? -1;
      int extra = response['event']?['time']?['extra'] ?? 780;
      VenueModel venue = VenueModel(
          cityName: response['event']?['venue']?['city']?['name'] ?? 'N/a',
          stadiumName:
              response['event']?['venue']?['stadium']?['name'] ?? 'N/a',
          countryName:
              response['event']?['venue']?['country']?['name'] ?? 'N/a');

      detailsMatchModel = DetailsMatchModel(
          homeTeam: homeTeam,
          awayTeam: awayTeam,
          tournament: tournament,
          seasonId: seasonId,
          round: round,
          statusMatch: statusMatch,
          homeScore: homeScore,
          awayScore: awayScore,
          matchTimestamp: matchTimestamp,
          startTimestamp: startTimestamp,
          extra: extra,
          venue: venue);
      return detailsMatchModel;
    } catch (e) {
      rethrow;
    }
  }
}
