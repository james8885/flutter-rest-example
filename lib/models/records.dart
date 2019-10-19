import 'package:json_annotation/json_annotation.dart';

part 'records.g.dart';

@JsonSerializable()
class Records {
  @JsonKey(name: '_id')
  final int id;
  final String quater;
  @JsonKey(name: 'volume_of_mobile_data')
  final String volumeOfMobileData;

  Records({this.id, this.quater, this.volumeOfMobileData});
  
  factory Records.fromJson(Map<String, dynamic> json) => _$RecordsFromJson(json);
  Map<String, dynamic> toJson() => _$RecordsToJson(this);

}