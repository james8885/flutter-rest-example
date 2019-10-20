import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:reactive_programming_sample/models/getmobiledataresponse.dart';

String baseUrl =
    "https://data.gov.sg";
String subUrl = "/api/action/datastore_search?limit=10&resource_id=a807b7ab-6cad-4aa6-87d0-e283a7353a0f&offset=";

Future<Getmobiledataresponse> getGovMobileDataUsage(int offset) async {
  var client = new http.Client();

  String apiUrl = baseUrl + subUrl + offset.toString();

  try {
    var response = await http.get(apiUrl);

    int statusCode = response.statusCode;
    // Map<String, String> headers = response.headers;
    // print(statusCode);
    // print(response.body);

    Getmobiledataresponse getmobiledataresponse =
        Getmobiledataresponse.fromJson(json.decode(response.body));

    // print(getmobiledataresponse.result.links.next);
    return getmobiledataresponse;
  } finally {
    client.close();
  }
  // http.Response response = await http.get(apiUrl);
}
