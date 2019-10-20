import 'package:json_annotation/json_annotation.dart';
import 'package:reactive_programming_sample/models/links.dart';
import 'package:reactive_programming_sample/models/records.dart';

part 'mobiledatamodel.g.dart';

@JsonSerializable( explicitToJson: true )
class Mobiledatamodel{
  
  @JsonKey(name: 'resource_id')
  final String resourceId;
  final List<Records> records;
  @JsonKey(name: '_links')
  final Links links;
  final int limit;
  final int total;

  Mobiledatamodel({this.resourceId, this.records, this.links, this.limit, this.total});
  
  factory Mobiledatamodel.fromJson(Map<String, dynamic> json) => _$MobiledatamodelFromJson(json);
  Map<String, dynamic> toJson() => _$MobiledatamodelToJson(this);

}