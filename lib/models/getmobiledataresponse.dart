import 'package:json_annotation/json_annotation.dart';
import 'package:reactive_programming_sample/models/baseresponse.dart';

import 'mobiledatamodel.dart';

part 'getmobiledataresponse.g.dart';

@JsonSerializable( explicitToJson: true )
class Getmobiledataresponse extends Baseresponse{
  
  final Mobiledatamodel result;

  Getmobiledataresponse({ this.result});
  
  factory Getmobiledataresponse.fromJson(Map<String, dynamic> json) => _$GetmobiledataresponseFromJson(json);
  Map<String, dynamic> toJson() => _$GetmobiledataresponseToJson(this);

}