import 'package:huit_score/model/foot/CategoryModel.dart';
import 'package:huit_score/model/foot/TeamDetailsModel.dart';

import '../data/network/BaseApiServices.dart';
import '../data/network/NetworkApiService.dart';
import '../model/foot/TournamentModel.dart';
import '../model/foot/VenueModel.dart';
import '../res/AppFootApiUrl.dart';

class TeamDetailsRepo {
  //X_RapidAPI_Key11
  final BaseApiServices _apiServices = NetworkApiService11();

  Future<TeamDetailsModel> fetchTeamDetails(
    int teamId,
  ) async {
    try {
      TeamDetailsModel teamDetailsModel;

      dynamic response = await _apiServices
          .getApiResponse('${AppFootApiUrl.teamDetails}/$teamId');

      String fullTeamName = response['team']?['fullName'] ?? 'N/a';
      String shortName = response['team']?['shortName'] ?? 'N/a';
      String gender = response['team']?['gender'] ?? 'N/a';
      TournamentModel tournament = TournamentModel(
          tournamentId: response['team']?['tournament']?['uniqueTournament']
                  ?['id'] ??
              'N/a',
          tournamentName: response['team']?['tournament']?['uniqueTournament']
                  ?['name'] ??
              'N/a',
          category: CategoryModel(
            categoryId: response['team']?['tournament']?['uniqueTournament']
                    ?['category']?['id'] ??
                'N/a',
            categoryName: response['team']?['tournament']?['uniqueTournament']
                    ?['category']?['name'] ??
                'N/a',
          ));
      String managerName = response['team']?['manager']?['name'] ?? 'N/a';
      VenueModel venue = VenueModel(
        cityName: response['team']?['venue']?['city']?['name'] ?? 'N/a',
        stadiumName: response['team']?['venue']?['stadium']?['name'] ?? 'N/a',
        countryName: response['team']?['venue']?['country']?['name'] ?? 'N/a',
        capacity: response['team']?['venue']?['stadium']?['capacity'] ?? -1,
      );
      int id = response['team']?['id'] ?? -1;
      int foundationDateTimestamp =
          response['team']?['foundationDateTimestamp'] ?? -1;

      teamDetailsModel = TeamDetailsModel(
          fullTeamName: fullTeamName,
          shortName: shortName,
          gender: gender,
          tournament: tournament,
          managerName: managerName,
          venue: venue,
          id: id,
          foundationDateTimestamp: foundationDateTimestamp);
      return teamDetailsModel;
    } catch (e) {
      rethrow;
    }
  }
}
