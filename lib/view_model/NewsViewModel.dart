import 'package:flutter/cupertino.dart';
import 'package:huit_score/data/response/ApiResponse.dart';
import 'package:huit_score/model/livescore/NewsModel.dart';
import 'package:huit_score/repo/NewsRepo.dart';

class NewsViewModel with ChangeNotifier {
  final _myRepo = NewsRepo();

  ApiResponse<NewsModel> newsList = ApiResponse.loading();

  setNewsList(ApiResponse<NewsModel> response) {
    newsList = response;
    notifyListeners();
  }

  Future<void> fetchNewsListApi() async {
    setNewsList(ApiResponse.loading());

    _myRepo.fetchNews().then((value) {
      setNewsList(ApiResponse.success(value));
    }).onError((error, stackTrace) {
      setNewsList(ApiResponse.error(error.toString()));
    });
  }

  Future<void> refresh() async {
    await fetchNewsListApi();
  }
}
