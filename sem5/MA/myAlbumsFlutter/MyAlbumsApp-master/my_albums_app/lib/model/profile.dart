import 'package:json_annotation/json_annotation.dart';

import 'address.dart';

part 'profile.g.dart';

@JsonSerializable()
class Profile {
  String? firstName;
  String? lastName;
  String? email;
  String? phone;
  Address? address;
  int? year;

  Profile(
      {this.firstName,
      this.lastName,
      this.email,
      this.phone,
      this.address,
      this.year});

  factory Profile.fromJson(Map<String, dynamic> json) => _$ProfileFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileToJson(this);

}
