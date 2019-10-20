import 'dart:async';

import 'package:reactive_programming_sample/models/getmobiledataresponse.dart';
import 'package:reactive_programming_sample/webserviceproxy/api_response.dart';
import 'package:reactive_programming_sample/webserviceproxy/mobile_data_proxy.dart';

class MobileDataBloc {
  StreamController _mobiledataController;

  StreamSink<ApiResponse<Getmobiledataresponse>> get mobileDataListSink =>
      _mobiledataController.sink;

  Stream<ApiResponse<Getmobiledataresponse>> get mobileDataListStream =>
      _mobiledataController.stream;

  MobileDataBloc() {
    _mobiledataController = StreamController<ApiResponse<Getmobiledataresponse>>();
    fetchMobileDataList();
  }

  fetchMobileDataList() async {
    mobileDataListSink.add(ApiResponse.loading('Fetching data'));
    try {
      Getmobiledataresponse getmobiledataresponse = await MobileDataProxy().getGovMobileDataUsage(0);
      mobileDataListSink.add(ApiResponse.completed(getmobiledataresponse));
    } catch (e) {
      mobileDataListSink.add(ApiResponse.error(e.toString()));
      print(e);
    }
  }

  dispose() {
    _mobiledataController?.close();
  }
}
