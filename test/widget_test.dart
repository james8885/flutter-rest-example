// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';

import 'package:reactive_programming_sample/main.dart';
import 'package:reactive_programming_sample/models/getmobiledataresponse.dart';
import 'package:reactive_programming_sample/models/mobiledata.dart';
import 'package:reactive_programming_sample/models/mobiledatamodel.dart';
import 'package:reactive_programming_sample/models/records.dart';
import 'package:reactive_programming_sample/webserviceproxy/mobile_data_proxy.dart';

class MobileDataProxyMock implements MobileDataProxy {
  @override
  String baseUrl;

  @override
  String subUrl;

  @override
  Future<Getmobiledataresponse> getGovMobileDataUsage(int offset) async {
    Getmobiledataresponse response;
    if (offset == null) {
      throw StateError('No offset');
    } else {
      Records a =
          new Records(id: 1, quarter: "2004-01", volumeOfMobileData: "100");
      Records b =
          new Records(id: 2, quarter: "2004-02", volumeOfMobileData: "99");
      Records c =
          new Records(id: 3, quarter: "2004-03", volumeOfMobileData: "80");
      Records d =
          new Records(id: 4, quarter: "2004-04", volumeOfMobileData: "120");

      Mobiledatamodel t = new Mobiledatamodel(records: [a, b, c, d]);
      response = new Getmobiledataresponse(result: t);
      response.success = true;
    }

    return response;
  }
}

void main() {
  group('Mobiledata_model', () {
    Records a =
        new Records(id: 1, quarter: "2004-01", volumeOfMobileData: "100");
    Records b =
        new Records(id: 2, quarter: "2004-02", volumeOfMobileData: "99");
    Records c =
        new Records(id: 3, quarter: "2004-03", volumeOfMobileData: "80");
    Records d =
        new Records(id: 4, quarter: "2004-04", volumeOfMobileData: "120");

    Mobiledata result = Mobiledata(year: "2004", quarterRecords: [a, b, c, d]);
    test('isDecrease_true', () {
      expect(result.isDecreaseWithinQuarter(), true);
    });

    test('isDecrease_false', () {
      result = Mobiledata(year: "2004", quarterRecords: [c, b, a, d]);
      expect(result.isDecreaseWithinQuarter(), false);
    });

    test('getTotalVolumeOfMobileData', () {
      expect(result.getTotalVolumeOfMobileData(), 399);
    });
  });

  test('Passing null to service', () async {
    await MobileDataProxyMock().getGovMobileDataUsage(null).catchError((e) {
      expect(e, isStateError);
    });
    // expect(result, StateError('No offset'));
  });

  test('Passing service response', () async {
    await MobileDataProxyMock().getGovMobileDataUsage(0).then((result) {
      expect(result.success, true);
      expect(result.result.records.length, 4);
      expect(result.result.records[0].volumeOfMobileData, "100");
    });
    // expect(result, StateError('No offset'));
  });
  

  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MyApp());

    // Verify that our counter starts at 0.
    expect(find.text('Mobile data List'), findsOneWidget);
  });
}
