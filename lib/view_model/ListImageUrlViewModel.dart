import 'package:flutter/cupertino.dart';
import 'package:huit_score/repo/ListImageUrlRepo.dart';

import '../model/ImageUrlModel.dart';

class ListImageUrlViewModel with ChangeNotifier {
  final _myRepo = ListImageUrlRepo();

  List<ImageUrlModel> imageUrls = [];

  setImageUrls(List<ImageUrlModel> response) {
    imageUrls = response;
    notifyListeners();
  }

  Future<void> fetchImageUrls() async {
    _myRepo.fetchImageUrl().then((value) => {setImageUrls(value)});
  }
}
