import 'package:floor/floor.dart';
import 'package:json_annotation/json_annotation.dart';

part 'entity.g.dart';

@entity
@JsonSerializable()
class Plane {
  @primaryKey
  int? id;
  String? name;
  String? status;
  int? size;
  String? owner;
  String? manufacturer;
  int? capacity;

  Plane({
    this.id,
    this.name,
    this.status,
    this.size,
    this.owner,
    this.manufacturer,
    this.capacity,
  });

  factory Plane.fromJson(Map<String, dynamic> json) => _$PlaneFromJson(json);

  Map<String, dynamic> toJson() => _$PlaneToJson(this);
}
