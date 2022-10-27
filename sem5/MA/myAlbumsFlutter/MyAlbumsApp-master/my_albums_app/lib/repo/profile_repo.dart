import 'dart:convert';

import 'package:geocoding/geocoding.dart';
import 'package:location/location.dart' as coordinates;
import 'package:shared_preferences/shared_preferences.dart';

import '../model/profile.dart';

class ProfileRepo {
  static const _userKey = 'profile';
  final Future<SharedPreferences> sharedPreferences;

  ProfileRepo(this.sharedPreferences);

  Future<bool> saveProfile(Profile profile) {
    return sharedPreferences.then((prefs) {
      prefs.remove(_userKey);
      return prefs.setString(_userKey, jsonEncode(profile.toJson()));
    });
  }

  Future<Profile?> getProfile() {
    return sharedPreferences.then((prefs) {
        final String? profile = prefs.getString(_userKey);
        if (profile == null) return null;
        return Profile.fromJson(jsonDecode(profile));
    });
  }

  Future<Placemark> getCurrentLocationAddress() {
    coordinates.Location location = coordinates.Location();
    return location.getLocation().then((data) {
      return placemarkFromCoordinates(data.latitude!, data.longitude!)
          .then((placeMarks) {
        return placeMarks[0];
      });
    });
  }

}
