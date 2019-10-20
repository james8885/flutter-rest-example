import 'package:json_annotation/json_annotation.dart';
import 'package:reactive_programming_sample/models/baseresponse.dart';
import 'package:reactive_programming_sample/models/records.dart';

@JsonSerializable(explicitToJson: true)
class Mobiledata extends Baseresponse {
  String year;
  List<Records> quarterRecords;

  Mobiledata({this.year, this.quarterRecords});

  bool isDecreaseWithinQuarter() {
    Records t;
    bool isDecreased = false;

    if (quarterRecords != null && quarterRecords.length > 0) {
      quarterRecords.forEach((record) {
        if (t == null) {
          t = record;
        } else if (double.parse(t.volumeOfMobileData) >
            double.parse(record.volumeOfMobileData)) {
          isDecreased = true;
        }
      });
    }
    return isDecreased;
  }

  double getTotalVolumeOfMobileData() {
    double total = 0.0;

    if (quarterRecords != null && quarterRecords.length > 0) {
      quarterRecords.forEach((a) {
        total = total + double.parse(a.volumeOfMobileData);
      });
    }
    return total;
  }
}
