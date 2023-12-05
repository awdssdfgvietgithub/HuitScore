import 'package:flutter/cupertino.dart';
import 'package:huit_score/repo/ListImageUrlRepo.dart';

import '../model/ImageUrlModel.dart';

class ListImageUrlViewModel with ChangeNotifier {
  final _myRepo = ListImageUrlRepo();

  List<ImageUrlModel> imageUrls = [];

  Future<void> fetchImageUrls() async {
    _myRepo.fetchImageUrl().then((value) => {imageUrls = value});
    notifyListeners();
  }
}
