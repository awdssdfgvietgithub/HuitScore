
import 'package:huit_score/data/local/LocalJsonService.dart';
import 'package:huit_score/model/ImageUrlModel.dart';

class ListImageUrlRepo {
  final LocalJsonService _localJsonService = LocalJsonService();

  Future<List<ImageUrlModel>> fetchImageUrl() async {
    List<ImageUrlModel> _items = [];
    dynamic response =
        await _localJsonService.getLocalJsonResponse('assets/url_image.json');
    for (Map item in response['images']) {
      _items
          .add(ImageUrlModel(id: item['id'] ?? -1, url: item['url'] ?? "N/a"));
    }
    return _items;
  }
}
