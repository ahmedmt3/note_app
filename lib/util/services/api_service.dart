import 'package:http/http.dart' as http;
import 'package:note_app/app/app_config.dart';

class ApiServices {
  getRequest({required String endPoint}) async {
    String fullUrl = AppConfig.baseUrl + endPoint;

    http.Response response = await http.get(Uri.parse(fullUrl));

    if (response.statusCode == 200) {
      return response;
    } else {
      return null;
    }
  }

  //=======================================================
  postRequest({required String endPoint, data}) async {
    String fullUrl = AppConfig.baseUrl + endPoint;

    http.Response response = await http.post(Uri.parse(fullUrl), body: data);

    if (response.statusCode == 200) {
      return response;
    } else {
      return null;
    }
  }
}
