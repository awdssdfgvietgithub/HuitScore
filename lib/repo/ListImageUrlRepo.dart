import 'package:huit_score/data/local/LocalJsonService.dart';
import 'package:huit_score/model/foot/ImageUrlModel.dart';

class ListImageUrlRepo {
  final LocalJsonService _localJsonService = LocalJsonService();

  Future<List<ImageUrlModel>> fetchImageUrl() async {
    List<ImageUrlModel> imageUrls = [];
    dynamic response =
        await _localJsonService.getLocalJsonResponse('assets/url_image.json');
    for (Map item in response['images']) {
      ImageUrlModel imageUrl =
          ImageUrlModel(id: item['id'] ?? "-1", url: item['url'] ?? "N/a");
      imageUrls.add(imageUrl);
    }
    return imageUrls;
  }
}
