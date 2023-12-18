import 'package:flutter/cupertino.dart';
import 'package:huit_score/model/foot/LineupsModel.dart';
import 'package:huit_score/repo/LineupsMatchRepo.dart';

import '../data/response/ApiResponse.dart';

class LineupsMatchViewModel with ChangeNotifier {
  final _myRepo = LineupsMatchRepo();
  final int matchId;

  LineupsMatchViewModel(this.matchId);

  ApiResponse2<LineupsModel> lineupsMatch = ApiResponse2.loading();

  setLineupsMatch(ApiResponse2<LineupsModel> response) {
    lineupsMatch = response;
    notifyListeners();
  }

  Future<void> fetchLineupsMatchApi() async {
    setLineupsMatch(ApiResponse2.loading());

    _myRepo.fetchLineupsMatch(matchId).then((value) {
      setLineupsMatch(ApiResponse2.success(value));
    }).onError((error, stackTrace) {
      setLineupsMatch(ApiResponse2.error(error.toString()));
    });
  }
}
