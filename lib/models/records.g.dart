// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'records.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Records _$RecordsFromJson(Map<String, dynamic> json) {
  return Records(
    id: json['_id'] as int,
    quarter: json['quarter'] as String,
    volumeOfMobileData: json['volume_of_mobile_data'] as String,
  );
}

Map<String, dynamic> _$RecordsToJson(Records instance) => <String, dynamic>{
      '_id': instance.id,
      'quarter': instance.quarter,
      'volume_of_mobile_data': instance.volumeOfMobileData,
    };
