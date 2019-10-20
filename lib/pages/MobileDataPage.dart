import 'package:flutter/material.dart';
import 'package:reactive_programming_sample/bloc/mobile_data_bloc.dart';
import 'package:reactive_programming_sample/components/MobileDataList.dart';
import 'package:reactive_programming_sample/models/getmobiledataresponse.dart';
import 'package:reactive_programming_sample/webserviceproxy/api_response.dart';

class MobileDataPage extends StatefulWidget {
  MobileDataPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MobileDataPageState createState() => _MobileDataPageState();
}

class _MobileDataPageState extends State<MobileDataPage> {
  MobileDataBloc _mobileDataBloc;

  @override
  void initState() {
    super.initState();
    _mobileDataBloc = MobileDataBloc();
  }

  @override
  void dispose() {
    _mobileDataBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: StreamBuilder<ApiResponse<Getmobiledataresponse>>(
          stream: _mobileDataBloc.mobileDataListStream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              switch (snapshot.data.status) {
                case Status.LOADING:
                  return Text("Loading");
                  break;
                case Status.COMPLETED:
                  return MobileDataList(
                    recordList: snapshot.data.data.result.records,
                  );
                  break;
                case Status.ERROR:
                  return Text(snapshot.data.message);
              }
            }
            return Container();
          }),
    );
  }
}
