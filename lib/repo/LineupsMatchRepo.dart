import 'package:huit_score/model/foot/LineupsModel.dart';
import 'package:huit_score/res/AppFootApiUrl.dart';

import '../data/network/BaseApiServices.dart';
import '../data/network/NetworkApiService.dart';
import '../model/foot/PlayerColorModel.dart';
import '../model/foot/PlayerModel.dart';

class LineupsMatchRepo {
  //X_RapidAPI_Key7
  final BaseApiServices _apiServices = NetworkApiService7();

  Future<LineupsModel> fetchLineupsMatch(int matchId) async {
    try {
      LineupsModel lineups;

      dynamic response = await _apiServices
          .getApiResponse('${AppFootApiUrl.lineupsMatch}/$matchId/lineups');

      List<PlayerModel> homePlayers = [];
      for (Map player in response['home']['players']) {
        String name = player['player']?['name'] ?? 'N/a';
        String shortName = player['player']?['shortName'] ?? 'N/a';
        String position = player['position'] ?? 'N/a';
        int shirtNumber = player['shirtNumber'] ?? -1;
        bool captain = player['captain'] ?? false;

        PlayerModel homePlayer = PlayerModel(
            name: name,
            shortName: shortName,
            position: position,
            shirtNumber: shirtNumber,
            captain: captain);

        homePlayers.add(homePlayer);
      }

      List<PlayerModel> awayPlayers = [];
      for (Map player in response['away']['players']) {
        String name = player['player']?['name'] ?? 'N/a';
        String shortName = player['player']?['shortName'] ?? 'N/a';
        String position = player['position'] ?? 'N/a';
        int shirtNumber = player['shirtNumber'] ?? -1;
        bool captain = player['captain'] ?? false;

        PlayerModel awayPlayer = PlayerModel(
            name: name,
            shortName: shortName,
            position: position,
            shirtNumber: shirtNumber,
            captain: captain);

        awayPlayers.add(awayPlayer);
      }

      String homeFormation = response['home']?['formation'] ?? 'N/a';
      String awayFormation = response['away']?['formation'] ?? 'N/a';

      PlayerColorModel homePlayerColor = PlayerColorModel(
          primary: response['home']?['playerColor']?['primary'] ?? 'N/a',
          number: response['home']?['playerColor']?['number'] ?? 'N/a',
          outline: response['home']?['playerColor']?['outline'] ?? 'N/a');
      PlayerColorModel awayPlayerColor = PlayerColorModel(
          primary: response['away']?['playerColor']?['primary'] ?? 'N/a',
          number: response['away']?['playerColor']?['number'] ?? 'N/a',
          outline: response['away']?['playerColor']?['outline'] ?? 'N/a');

      PlayerColorModel homeGoalkeeperColor = PlayerColorModel(
          primary: response['away']?['goalkeeperColor']?['primary'] ?? 'N/a',
          number: response['away']?['goalkeeperColor']?['number'] ?? 'N/a',
          outline: response['away']?['goalkeeperColor']?['outline'] ?? 'N/a');
      PlayerColorModel awayGoalkeeperColor = PlayerColorModel(
          primary: response['away']?['goalkeeperColor']?['primary'] ?? 'N/a',
          number: response['away']?['goalkeeperColor']?['number'] ?? 'N/a',
          outline: response['away']?['goalkeeperColor']?['outline'] ?? 'N/a');

      lineups = LineupsModel(
          homePlayers: homePlayers,
          awayPlayers: awayPlayers,
          homeFormation: homeFormation,
          awayFormation: awayFormation,
          homePlayerColor: homePlayerColor,
          awayPlayerColor: awayPlayerColor,
          homeGoalkeeperColor: homeGoalkeeperColor,
          awayGoalkeeperColor: awayGoalkeeperColor);
      return lineups;
    } catch (e) {
      rethrow;
    }
  }
}
