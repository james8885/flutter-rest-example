// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mobiledatamodel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Mobiledatamodel _$MobiledatamodelFromJson(Map<String, dynamic> json) {
  return Mobiledatamodel(
    resourceId: json['resource_id'] as String,
    records: (json['records'] as List)
        ?.map((e) =>
            e == null ? null : Records.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    links: json['_links'] == null
        ? null
        : Links.fromJson(json['_links'] as Map<String, dynamic>),
    limit: json['limit'] as int,
    total: json['total'] as int,
  );
}

Map<String, dynamic> _$MobiledatamodelToJson(Mobiledatamodel instance) =>
    <String, dynamic>{
      'resource_id': instance.resourceId,
      'records': instance.records?.map((e) => e?.toJson())?.toList(),
      '_links': instance.links?.toJson(),
      'limit': instance.limit,
      'total': instance.total,
    };
