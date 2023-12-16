import 'package:flutter/cupertino.dart';
import 'package:huit_score/model/DetailsMatchModel.dart';
import 'package:huit_score/repo/DetailsMatchRepo.dart';

import '../data/response/ApiResponse.dart';

class DetailsMatchViewModel with ChangeNotifier {
  final _myRepo = DetailsMatchRepo();
  final int matchId;

  DetailsMatchViewModel(this.matchId);

  ApiResponse2<DetailsMatchModel> detailsMatch = ApiResponse2.loading();

  setDetailsMatch(ApiResponse2<DetailsMatchModel> response) {
    detailsMatch = response;
    notifyListeners();
  }

  Future<void> fetchDetailsMatchApi() async {
    setDetailsMatch(ApiResponse2.loading());

    _myRepo.fetchDetailsMatch(matchId).then((value) {
      setDetailsMatch(ApiResponse2.success(value));
    }).onError((error, stackTrace) {
      setDetailsMatch(ApiResponse2.error(error.toString()));
    });
  }
}