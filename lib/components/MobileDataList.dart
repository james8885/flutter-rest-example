import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:reactive_programming_sample/bloc/mobile_data_bloc.dart';
import 'package:reactive_programming_sample/models/mobiledata.dart';
import 'package:reactive_programming_sample/models/records.dart';

class MobileDataList extends StatefulWidget {
  final List<Records> recordList;
  final MobileDataBloc bloc;

  const MobileDataList({Key key, this.recordList, this.bloc}) : super(key: key);

  @override
  _MobileDataListState createState() => _MobileDataListState();
}

class _MobileDataListState extends State<MobileDataList> {
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  void _onRefresh() async {
    // monitor network fetch
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    _refreshController.refreshCompleted();
  }

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
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
      child: ListView.builder(
          itemCount: widget.recordList.length,
          itemBuilder: (BuildContext ctxt, int index) {
            return new Cardview(
              records: widget.recordList[index],
            );
          }),
    );
  }
}

class Cardview extends StatefulWidget {
  final Records records;
  final Mobiledata mobiledata;
  final List<Records> oriRecordList;

  Cardview({Key key, this.records, this.oriRecordList, this.mobiledata})
      : super(key: key);

  @override
  _CardviewState createState() => _CardviewState();
}

class _CardviewState extends State<Cardview> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(widget.mobiledata.year),
          Text(widget.mobiledata.getTotalVolumeOfMobileData().toString()),
          widget.mobiledata.isDecreaseWithinQuarter()
              ? RaisedButton(
                  onPressed: () {
                    _displayInformationDialog(context);
                  },
                  child: Icon(Icons.stars))
              : Text(""),
        ],
      ),
    );
  }

  void _displayInformationDialog(context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              backgroundColor: Colors.white,
              content: Container(
                  width: MediaQuery.of(context).size.width * 0.85,
                  height: MediaQuery.of(context).size.height * 0.65,
                  child: ListView.builder(
                    itemCount: widget.mobiledata.quarterRecords.length,
                    itemBuilder: (BuildContext ctxt, int index) {
                      return new Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                              "${widget.mobiledata.quarterRecords[index].quarter}"),
                          Text(
                              "${widget.mobiledata.quarterRecords[index].volumeOfMobileData}")
                        ],
                      );
                    },
                  )));
        });
  }
}
