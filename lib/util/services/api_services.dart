import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:note_app/core/config/app_config.dart';
import 'package:path/path.dart';

class ApiServices {
  Map<String, String> myheaders = {
    'authorization': "Basic ${base64Encode(utf8.encode('ahmed:amt123'))}"
  };

  getRequest({required String endPoint}) async {
    String fullUrl = AppConfig.baseUrl + endPoint;

    http.Response response =
        await http.get(Uri.parse(fullUrl), headers: myheaders);

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      return null;
    }
  }

  //=======================================================
  postRequest({required String endPoint, data}) async {
    String fullUrl = AppConfig.baseUrl + endPoint;

    http.Response response =
        await http.post(Uri.parse(fullUrl), body: data, headers: myheaders);

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      return null;
    }
  }

  //=======================================================
  postRequestWithFile({
    required String endPoint,
    required String fileField,
    File? file,
    required Map data,
  }) async {
    String fullUrl = AppConfig.baseUrl + endPoint;
    var request = http.MultipartRequest('POST', Uri.parse(fullUrl));
    request.headers.addAll(myheaders);

    if (file != null) {
      int length = await file.length();
      var stream = http.ByteStream(file.openRead());
      var multipartfile = http.MultipartFile(fileField, stream, length,
          filename: basename(file.path));
      request.files.add(multipartfile);
    }

    data.forEach((key, value) => request.fields[key] = value);
    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      return null;
    }
  }
}
