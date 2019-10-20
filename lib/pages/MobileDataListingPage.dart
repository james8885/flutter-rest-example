import 'dart:async';

import 'package:flutter/material.dart';
import 'package:reactive_programming_sample/components/MobileDataList.dart';
import 'package:reactive_programming_sample/models/getmobiledataresponse.dart';
import 'package:reactive_programming_sample/webserviceproxy/mobile_data_proxy.dart';

class MobileDataListingPage extends StatefulWidget {
  MobileDataListingPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MobileDataListingPageState createState() => _MobileDataListingPageState();
}

class _MobileDataListingPageState extends State<MobileDataListingPage> {
  int offset = 0;
  Getmobiledataresponse getmobiledataresponse;
  final StreamController<Getmobiledataresponse> _streamController =
      StreamController<Getmobiledataresponse>();

  @override
  void initState() {
    super.initState();
    setupData();
  }

  @override
  void dispose() {
    _streamController.close();
    super.dispose();
  }

  void setupData() async {
    Getmobiledataresponse response = await MobileDataProxy().getGovMobileDataUsage(offset);
    // Getmobiledataresponse response = await getGovMobileDataUsage();
    if (response.success) {
      _streamController.sink.add(response);
      offset = offset + response.result.limit;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: StreamBuilder<Getmobiledataresponse>(
          stream: _streamController.stream,
          initialData: getmobiledataresponse,
          builder: (context, snapshot) {
            return ListView.builder(
                itemCount: snapshot.data != null ? snapshot.data.result.records.length : 0,
                itemBuilder: (BuildContext ctxt, int index) {
                  return new Cardview(records:
                       snapshot.data.result.records[index]);
                });
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setupData();
        },
        tooltip: 'Increment',
        child: Icon(Icons.airport_shuttle),
      ),
    );
  }
}
