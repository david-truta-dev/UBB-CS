import 'dart:async';

import 'package:my_albums_app/repo/profile_repo.dart';
import 'package:rxdart/rxdart.dart';

import '../../../model/profile.dart';

class ProfileData {
  late final String circularAvatarText;
  late final String fullName;
  late final String emailAddress;
  late final String memberSince;
  Profile? profile;

  ProfileData({
    this.profile,
  }) {
    if (profile == null) {
      circularAvatarText = "?";
      fullName = 'unknown';
      emailAddress = "";
      memberSince = "";
    } else {
      if(profile!.firstName == null || profile!.firstName!.isEmpty) {
        return;
      }
      circularAvatarText = profile!.firstName![0];
      fullName = "${profile!.firstName!} ${profile!.lastName!}";
      emailAddress = "emailAddress";
      memberSince = "memberSince";
    }
  }
}

class Input {
  final Subject<bool> load = BehaviorSubject();
}

class Output {
  final Stream<ProfileData> data;

  Output(this.data);
}

class ProfileViewModel {
  final ProfileRepo _profileRepo;
  late final Input input;
  late final Output output;

  ProfileViewModel(this._profileRepo, this.input) {
    output = Output(
      input.load.flatMap((_) => _profileRepo
          .getProfile()
          .asStream()
          .map((profile) => ProfileData(profile: profile))),
    );
  }
}
