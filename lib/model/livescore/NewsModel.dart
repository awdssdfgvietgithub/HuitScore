import 'package:huit_score/model/livescore/AuthorModel.dart';
import 'package:huit_score/model/livescore/BodyModel.dart';
import 'package:huit_score/model/livescore/ImageModel.dart';

class NewsModel {
  String? id;
  String? title;
  String? subtitle;
  String? publishedAt;
  ImageModel? image;
  List<BodyModel>? bodiesList;
  List<AuthorModel>? authorsList;

  NewsModel(
      {this.id,
      this.title,
      this.subtitle,
      this.publishedAt,
      this.image,
      this.bodiesList,
      this.authorsList});
}
