import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:reactive_programming_sample/components/MobileDataList.dart';
import 'package:reactive_programming_sample/models/getmobiledataresponse.dart';
import 'package:reactive_programming_sample/models/mobiledata.dart';
import 'package:reactive_programming_sample/models/records.dart';
import 'package:reactive_programming_sample/webserviceproxy/mobile_data.dart';

class MobileDataListing extends StatefulWidget {
  MobileDataListing({Key key}) : super(key: key);

  @override
  _MobileDataListingState createState() => _MobileDataListingState();
}

class _MobileDataListingState extends State<MobileDataListing> {
  int offset = 0;
  String errorMessage = "";
  List<Records> oriRecordsList = new List<Records>();
  List<Mobiledata> mobileDataList = new List<Mobiledata>();
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  void initState() {
    super.initState();
    _onLoading();
  }

  @override
  void dispose() {
    mobileDataList.clear();
    oriRecordsList.clear();
    super.dispose();
  }

  void _onRefresh() async {
    // monitor network fetch
    setState(() {
      mobileDataList = [];
      oriRecordsList = [];
      offset = 0;
    });

    _onLoading();
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    try {
      Getmobiledataresponse response = await getGovMobileDataUsage(offset);
      if (response.success) {
        oriRecordsList.addAll(response.result.records);

        response.result.records.forEach((record) {
          if (mobileDataList.length > 0 &&
              mobileDataList.last.year == record.quarter.substring(0, 4)) {
            mobileDataList.last.quarterRecords.add(record);
          } else {
            List<Records> t = new List<Records>();
            t.add(record);
            Mobiledata mobiledata = new Mobiledata(
                year: record.quarter.substring(0, 4), quarterRecords: t);
            mobileDataList.add(mobiledata);
          }
        });

        setState(() {
          mobileDataList = mobileDataList;
          oriRecordsList = oriRecordsList;
          offset = offset + response.result.limit;
        });
      }

      if (response.result.total == oriRecordsList.length || response.result.total == null) {
        _refreshController.loadNoData();
      } else {
        _onLoading();
        _refreshController.loadComplete();
      }
    } catch (e) {
      setState(() {
        errorMessage = e.toString();
      });
      // print(e.toString());
      _refreshController.loadFailed();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Mobile data List"),
        ),
        body: Padding(
          padding: const EdgeInsets.only(bottom: 13),
          child: SmartRefresher(
            enablePullDown: true,
            enablePullUp: true,
            header: ClassicHeader(),
            footer: CustomFooter(
              builder: (BuildContext context, LoadStatus mode) {
                Widget body;
                if (mode == LoadStatus.idle) {
                  body = Text("pull up load");
                } else if (mode == LoadStatus.loading) {
                  body = CupertinoActivityIndicator();
                } else if (mode == LoadStatus.failed) {
                  body = Text("Load Failed!Click retry!");
                } else if (mode == LoadStatus.canLoading) {
                  body = Text("release to load more");
                } else {
                  body = Text("<------ No more Data ------>");
                }

                return Container(
                  height: 55.0,
                  child: Center(child: body),
                );
              },
            ),
            controller: _refreshController,
            onRefresh: _onRefresh,
            onLoading: _onLoading,
            child: mobileDataList.length < 1
                ? Center(child: errorMessage.isEmpty ? Text("Loading!!") : Text("Fail to load.\n $errorMessage \n pull to refresh"))
                : ListView.builder(
                    itemCount: mobileDataList.length,
                    itemBuilder: (BuildContext ctxt, int index) {
                      return new Cardview(mobiledata: mobileDataList[index]);
                    }),
          ),
        ));
  }
}
