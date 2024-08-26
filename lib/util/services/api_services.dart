import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:note_app/core/config/app_config.dart';
import 'package:note_app/util/helpers/api_response.dart';
import 'package:note_app/util/helpers/app_helper.dart';

class ApiServices {
  //==========================[ GET ]============================
  Future<Either<ApiResponse, dynamic>> getRequest(
      {required String endPoint}) async {
    final String fullUrl = AppConfig.baseUrl + endPoint;
    final bool online = await AppHelper.checkInternet();

    if (online) {
      http.Response response = await http.get(Uri.parse(fullUrl));

      switch (response.statusCode) {
        case 200:
          return Right(jsonDecode(response.body));
        case 401:
          return const Left(ApiResponse.unauthorized);
        case 404:
          return const Left(ApiResponse.notFound);
        default:
          return const Left(ApiResponse.unknown);
      }
    } else {
      return const Left(ApiResponse.offline);
    }
  }

  //==========================[ POST ]============================
  Future<Either<ApiResponse, dynamic>> postRequest(
      {required String endPoint, data}) async {
    final String fullUrl = AppConfig.baseUrl + endPoint;
    final bool online = await AppHelper.checkInternet();

    if (online) {
      http.Response response = await http.post(Uri.parse(fullUrl), body: data);

      switch (response.statusCode) {
        case 200 || 201:
          return Right(jsonDecode(response.body));
        case 422:
          return const Left(ApiResponse.unprocessableEntity);
        case 409:
          return const Left(ApiResponse.conflict);
        case 401:
          return const Left(ApiResponse.unauthorized);
        default:
          return const Left(ApiResponse.unknown);
      }
    } else {
      return const Left(ApiResponse.offline);
    }
  }

  //==========================[ PATCH ]============================
  Future<Either<ApiResponse, dynamic>> patchRequest(
      {required String endPoint, data}) async {
    final String fullUrl = AppConfig.baseUrl + endPoint;
    final bool online = await AppHelper.checkInternet();

    if (online) {
      http.Response response = await http.patch(Uri.parse(fullUrl), body: data);

     switch (response.statusCode) {
        case 200:
          return Right(jsonDecode(response.body));
        case 422:
          return const Left(ApiResponse.unprocessableEntity);
        case 404:
          return const Left(ApiResponse.notFound);
        default:
          return const Left(ApiResponse.unknown);
      }
    } else {
      return const Left(ApiResponse.offline);
    }
  }

  //==========================[ DELETE ]============================
  Future<Either<ApiResponse, dynamic>> deleteRequest({required String endPoint}) async {
    final String fullUrl = AppConfig.baseUrl + endPoint;
    final bool online = await AppHelper.checkInternet();

    if (online) {
      http.Response response = await http.delete(Uri.parse(fullUrl));

     switch (response.statusCode) {
        case 200:
          return Right(jsonDecode(response.body));
        case 404:
          return const Left(ApiResponse.notFound);
        default:
          return const Left(ApiResponse.unknown);
      }
    } else {
      return const Left(ApiResponse.offline);
    }
  }
  //=======================================================
  // postRequestWithFile({
  //   required String endPoint,
  //   required String fileField,
  //   File? file,
  //   required Map data,
  // }) async {
  //   String fullUrl = AppConfig.baseUrl + endPoint;
  //   var request = http.MultipartRequest('POST', Uri.parse(fullUrl));
  //   request.headers.addAll(myheaders);

  //   if (file != null) {
  //     int length = await file.length();
  //     var stream = http.ByteStream(file.openRead());
  //     var multipartfile = http.MultipartFile(fileField, stream, length,
  //         filename: basename(file.path));
  //     request.files.add(multipartfile);
  //   }

  //   data.forEach((key, value) => request.fields[key] = value);
  //   var streamedResponse = await request.send();
  //   var response = await http.Response.fromStream(streamedResponse);
  //   if (response.statusCode == 200) {
  //     return jsonDecode(response.body);
  //   } else {
  //     return null;
  //   }
  // }
}
