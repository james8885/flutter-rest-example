// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'getmobiledataresponse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Getmobiledataresponse _$GetmobiledataresponseFromJson(
    Map<String, dynamic> json) {
  return Getmobiledataresponse(
    result: json['result'] == null
        ? null
        : Mobiledatamodel.fromJson(json['result'] as Map<String, dynamic>),
  )
    ..help = json['help'] as String
    ..success = json['success'] as bool;
}

Map<String, dynamic> _$GetmobiledataresponseToJson(
        Getmobiledataresponse instance) =>
    <String, dynamic>{
      'help': instance.help,
      'success': instance.success,
      'result': instance.result?.toJson(),
    };
