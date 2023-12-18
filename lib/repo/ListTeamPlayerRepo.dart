import 'package:huit_score/model/foot/TeamPlayersModel.dart';

import '../data/network/BaseApiServices.dart';
import '../data/network/NetworkApiService.dart';
import '../res/AppFootApiUrl.dart';

class ListTeamPlayerRepo {
  //X_RapidAPI_Key10
  final BaseApiServices _apiServices = NetworkApiService10();

  Future<List<TeamPlayerModel>> fetchListTeamPlayers(
    int teamId,
  ) async {
    try {
      List<TeamPlayerModel> teamPlayerList = [];

      dynamic response = await _apiServices
          .getApiResponse('${AppFootApiUrl.teamPlayers}/$teamId/players');

      for (Map player in response['players']) {
        String name = player['player']?['name'] ?? 'N/a';
        String position = player['player']?['position'] ?? 'N/a';
        int height = player['player']?['height'] ?? -1;
        String preferredFoot = player['player']?['preferredFoot'] ?? 'N/a';
        bool retired = player['player']?['retired'] ?? false;
        int id = player['player']?['id'] ?? -1;
        String countryName = player['player']?['country']?['name'] ?? 'N/a';
        int shirtNumber = player['player']?['shirtNumber'] ?? -1;
        int dateOfBirthTimestamp =
            player['player']?['dateOfBirthTimestamp'] ?? -1;
        int contractUntilTimestamp =
            player['player']?['contractUntilTimestamp'] ?? -1;
        int proposedMarketValue =
            player['player']?['proposedMarketValue'] ?? -1;

        TeamPlayerModel teamPlayerModel = TeamPlayerModel(
            name: name,
            position: position,
            height: height,
            preferredFoot: preferredFoot,
            retired: retired,
            id: id,
            countryName: countryName,
            shirtNumber: shirtNumber,
            dateOfBirthTimestamp: dateOfBirthTimestamp,
            contractUntilTimestamp: contractUntilTimestamp,
            proposedMarketValue: proposedMarketValue);

        teamPlayerList.add(teamPlayerModel);
      }

      return teamPlayerList;
    } catch (e) {
      rethrow;
    }
  }
}
