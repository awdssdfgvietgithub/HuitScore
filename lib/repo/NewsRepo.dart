import 'dart:developer';

import 'package:huit_score/model/livescore/AuthorModel.dart';
import 'package:huit_score/model/livescore/BodyModel.dart';
import 'package:huit_score/model/livescore/ImageModel.dart';
import 'package:huit_score/model/livescore/NewsModel.dart';
import 'package:huit_score/model/livescore/bodytype/EditorBlockTypeModel.dart';
import 'package:huit_score/model/livescore/bodytype/ImageTypeModel.dart';
import 'package:huit_score/model/livescore/bodytype/LinkTypeModel.dart';
import 'package:huit_score/res/AppLiveScoreUrl.dart';

import '../data/network/BaseApiServices.dart';
import '../data/network/NetworkApiService.dart';

class NewsRepo {
  //X_RapidAPI_Key1 || X_RapidAPI_Key2
  final BaseApiServices _apiServices = NetworkApiService();


  Future<List<NewsModel>> fetchNews() async {
    try {
      List<NewsModel> newsList = [];
      dynamic response = await _apiServices.getApiResponse(
          AppLiveScoreUrl.baseUrl);

      for (Map data in response['data']) {
        String id = data['id']?.toString() ?? 'N/a';
        String title = data['title']?.toString() ?? 'N/a';
        String subtitle = data['subtitle']?.toString() ?? 'N/a';
        String publishedAt = data['published_at']?.toString() ?? 'N/a';
        ImageModel image = ImageModel(
          id: data['image']?['data']?['id']?.toString() ?? 'N/a',
          galleryUrl: data['image']?['data']?['urls']?['uploaded']?['gallery']
              ?.toString() ?? 'N/a',
          des: data['image']?['data']?['description']?.toString() ?? 'N/a',
          createdAt: data['image']?['data']?['created_at']?.toString() ?? 'N/a',
        );
        //---------------------------------------------------------------------//
        List<BodyModel> bodiesList = [];
        for (Map body in data['body']) {
          String bodyId = body['id']?.toString() ?? 'N/a';
          log(bodyId);
          EditorBlockTypeModel editorBlockType = EditorBlockTypeModel(
              content: body['data']?['content']?.toString() ?? 'N/a'
          );
          log(editorBlockType.content ?? 'N/a');
          ImageTypeModel imageType = ImageTypeModel(
            id: body['data']?['id']?.toString() ?? 'N/a',
            galleryUrl: body['data']?['preview']?['imageBlock']?['image']?['urls']?['uploaded']?['gallery']?.toString() ?? 'N/a',
            imageDes:body['data']?['description']?.toString() ?? 'N/a'
          );
          log(editorBlockType.content ?? 'N/a');
          LinkTypeModel linkType = LinkTypeModel(
            link: body['data']?['link']?.toString() ?? 'N/a',
            text: body['data']?['text']?.toString() ?? 'N/a',
          );
          log(editorBlockType.content ?? 'N/a');
          String type = body['type']?.toString() ?? 'N/a';

          BodyModel bodyModel = BodyModel(
            id: bodyId,
            editorBlockType: editorBlockType,
            imageType: imageType,
            linkType: linkType,
            type: type,
          );
          bodiesList.add(bodyModel);
        }
        //---------------------------------------------------------------------//
        List<AuthorModel> authorsList = [];
        for (Map author in data['authors']) {
          String authorId = author['id']?.toString() ?? 'N/a';
          String authorName = author['name']?.toString() ?? 'N/a';

          AuthorModel authorModel = AuthorModel(
            id: authorId,
            name: authorName
          );
          authorsList.add(authorModel);
        }

        NewsModel newsModel = NewsModel(
          id: id,
          title: title,
          subtitle: subtitle,
          publishedAt: publishedAt,
          bodiesList: bodiesList,
          image: image,
          authorsList: authorsList,
        );
        newsList.add(newsModel);
      }
      return newsList;
    } catch (e) {
      rethrow;
    }
  }
}
