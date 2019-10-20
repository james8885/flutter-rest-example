import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:reactive_programming_sample/models/getmobiledataresponse.dart';
import 'app_exception.dart';

String baseUrl = "https://data.gov.sg";
String subUrl =
    "/api/action/datastore_search?limit=100&resource_id=a807b7ab-6cad-4aa6-87d0-e283a7353a0f&offset=";

Future<Getmobiledataresponse> getGovMobileDataUsage(int offset) async {
  var client = new http.Client();

  String apiUrl = baseUrl + subUrl + offset.toString();

  try {
    final response = await http.get(apiUrl);

    Getmobiledataresponse getmobiledataresponse =
        Getmobiledataresponse.fromJson(json.decode(_returnResponse(response)));

    return getmobiledataresponse;
  } on SocketException {
    throw FetchDataException('No Internet Connection');
  } catch (e) {
    throw FetchDataException(e.toString());
  } finally {
    client.close();
  }
}

dynamic _returnResponse(http.Response response) {
  switch (response.statusCode) {
    case 200:
      // var responseJson = json.decode(response.body.toString());
      // print(responseJson);
      return response.body;
    case 400:
      throw BadRequestException(response.body.toString());
    case 401:
    case 403:
      throw UnauthorisedException(response.body.toString());
    case 500:
    default:
      throw FetchDataException(
          'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
  }
}
