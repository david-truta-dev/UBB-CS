
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'photo.g.dart';

@JsonSerializable()
class Photo {
  int? id;
  int? albumId;
  String? title;
  String? url;
  String? thumbnailUrl;
  Key? key;

  Photo({this.id, this.albumId, this.title, this.url, this.thumbnailUrl, this.key});

  factory Photo.fromJson(Map<String, dynamic> json) => _$PhotoFromJson(json);

  Map<String, dynamic> toJson() => _$PhotoToJson(this);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other.runtimeType != runtimeType) return false;
    return other is Photo &&
        other.id == id &&
        other.title == title &&
        other.url == url &&
        other.thumbnailUrl == thumbnailUrl &&
        other.albumId == albumId;
  }

  @override
  int get hashCode => id.hashCode;
}
