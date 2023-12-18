import 'dart:convert';
import 'dart:io';

import 'package:huit_score/data/AppExceptions.dart';
import 'package:huit_score/data/network/BaseApiServices.dart';
import 'package:http/http.dart' as http;
import 'package:huit_score/res/AppFootApiUrl.dart';
import 'package:huit_score/res/AppLiveScoreUrl.dart';

class NetworkApiService extends BaseApiServices {
  @override
  Future getApiResponse(String url) async {
    dynamic responseJson;

    var headers = {
      'X-RapidAPI-Key': AppLiveScoreUrl.X_RapidAPI_Key1,
      'X-RapidAPI-Host': AppLiveScoreUrl.X_RapidAPI_Host
    };

    final queryParameters = {
      'category': '2021020913320920836',
    };

    try {
      final uri = Uri.https('livescore6.p.rapidapi.com', '/news/v2/list-by-sport', queryParameters);

      final response = await http
          .get(uri, headers: headers);

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

class NetworkApiService1 extends BaseApiServices {
  @override
  Future getApiResponse(String url) async {
    dynamic responseJson;

    var headers = {
      'X-RapidAPI-Key': AppFootApiUrl.X_RapidAPI_Key1,
      'X-RapidAPI-Host': AppFootApiUrl.X_RapidAPI_Host
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

class NetworkApiService2 extends BaseApiServices {
  @override
  Future getApiResponse(String url) async {
    dynamic responseJson;

    var headers = {
      'X-RapidAPI-Key': AppFootApiUrl.X_RapidAPI_Key2,
      'X-RapidAPI-Host': AppFootApiUrl.X_RapidAPI_Host
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

class NetworkApiService3 extends BaseApiServices {
  @override
  Future getApiResponse(String url) async {
    dynamic responseJson;

    var headers = {
      'X-RapidAPI-Key': AppFootApiUrl.X_RapidAPI_Key3,
      'X-RapidAPI-Host': AppFootApiUrl.X_RapidAPI_Host
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

class NetworkApiService4 extends BaseApiServices {
  @override
  Future getApiResponse(String url) async {
    dynamic responseJson;

    var headers = {
      'X-RapidAPI-Key': AppFootApiUrl.X_RapidAPI_Key4,
      'X-RapidAPI-Host': AppFootApiUrl.X_RapidAPI_Host
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

class NetworkApiService5 extends BaseApiServices {
  @override
  Future getApiResponse(String url) async {
    dynamic responseJson;

    var headers = {
      'X-RapidAPI-Key': AppFootApiUrl.X_RapidAPI_Key5,
      'X-RapidAPI-Host': AppFootApiUrl.X_RapidAPI_Host
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

class NetworkApiService6 extends BaseApiServices {
  @override
  Future getApiResponse(String url) async {
    dynamic responseJson;

    var headers = {
      'X-RapidAPI-Key': AppFootApiUrl.X_RapidAPI_Key6,
      'X-RapidAPI-Host': AppFootApiUrl.X_RapidAPI_Host
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

class NetworkApiService7 extends BaseApiServices {
  @override
  Future getApiResponse(String url) async {
    dynamic responseJson;

    var headers = {
      'X-RapidAPI-Key': AppFootApiUrl.X_RapidAPI_Key7,
      'X-RapidAPI-Host': AppFootApiUrl.X_RapidAPI_Host
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

class NetworkApiService8 extends BaseApiServices {
  @override
  Future getApiResponse(String url) async {
    dynamic responseJson;

    var headers = {
      'X-RapidAPI-Key': AppFootApiUrl.X_RapidAPI_Key8,
      'X-RapidAPI-Host': AppFootApiUrl.X_RapidAPI_Host
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

class NetworkApiService9 extends BaseApiServices {
  @override
  Future getApiResponse(String url) async {
    dynamic responseJson;

    var headers = {
      'X-RapidAPI-Key': AppFootApiUrl.X_RapidAPI_Key9,
      'X-RapidAPI-Host': AppFootApiUrl.X_RapidAPI_Host
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

class NetworkApiService10 extends BaseApiServices {
  @override
  Future getApiResponse(String url) async {
    dynamic responseJson;

    var headers = {
      'X-RapidAPI-Key': AppFootApiUrl.X_RapidAPI_Key10,
      'X-RapidAPI-Host': AppFootApiUrl.X_RapidAPI_Host
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

class NetworkApiService11 extends BaseApiServices {
  @override
  Future getApiResponse(String url) async {
    dynamic responseJson;

    var headers = {
      'X-RapidAPI-Key': AppFootApiUrl.X_RapidAPI_Key11,
      'X-RapidAPI-Host': AppFootApiUrl.X_RapidAPI_Host
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
