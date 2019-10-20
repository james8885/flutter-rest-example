import 'dart:async';

import 'package:flutter/material.dart';
import 'package:reactive_programming_sample/pages/MobileDataListing.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  final StreamController<int> _streamController = StreamController<int>();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _streamController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Center(
            child: StreamBuilder<int>(
          stream: _streamController.stream,
          initialData: _counter,
          builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
            return Text('You hit me : ${snapshot.data} times.');
          },
        )),
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            FloatingActionButton(
              heroTag: "btn1",
              onPressed: () {
                _streamController.sink.add(--_counter);
              },
              tooltip: 'Increment',
              child: Icon(Icons.airport_shuttle),
            ),
            FloatingActionButton(
              heroTag: "btn2",
              onPressed: () {
                _streamController.sink.add(++_counter);
              },
              tooltip: 'Increment',
              child: Icon(Icons.add),
            ),
            FloatingActionButton(
              heroTag: "btn3",
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MobileDataListing()),
                  // MaterialPageRoute(builder: (context) => MobileDataListingPage(title: "asdasdasd",)),
                  // MaterialPageRoute(builder: (context) => MobileDataPage(title: "Mobile Data List",)),
                );
              },
              tooltip: 'GO',
              child: Icon(Icons.play_arrow),
            ),
          ],
        ));
  }
}
