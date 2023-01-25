// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Plane _$PlaneFromJson(Map<String, dynamic> json) => Plane(
      id: json['id'] as int?,
      name: json['name'] as String?,
      status: json['status'] as String?,
      size: json['size'] as int?,
      owner: json['owner'] as String?,
      manufacturer: json['manufacturer'] as String?,
      capacity: json['capacity'] as int?,
    );

Map<String, dynamic> _$PlaneToJson(Plane instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'status': instance.status,
      'size': instance.size,
      'owner': instance.owner,
      'manufacturer': instance.manufacturer,
      'capacity': instance.capacity,
    };
