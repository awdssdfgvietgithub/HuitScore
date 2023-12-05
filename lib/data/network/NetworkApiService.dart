import 'dart:convert';
import 'dart:io';

import 'package:huit_score/data/AppExceptions.dart';
import 'package:huit_score/data/network/BaseApiServices.dart';
import 'package:http/http.dart' as http;

import '../../res/AppUrl.dart';

class NetworkApiService extends BaseApiServices {
  @override
  Future getApiResponse(String url) async {
    dynamic responseJson;

    var headers = {
      'X-RapidAPI-Key': AppUrl.X_RapidAPI_Key2,
      'X-RapidAPI-Host': AppUrl.X_RapidAPI_Host
    };

    try {
      final response = await http
          .get(Uri.parse(url), headers: headers);

      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException('No internet conn');
    }

    return responseJson;
  }

  dynamic returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;
      case 400:
        throw BadRequestException(response.body.toString());
      case 404:
        throw UnauthorisedException(response.body.toString());
      default:
        throw FetchDataException(
            'Error while communicating with server, status code ${response.statusCode.toString()}');
    }
  }
}