import 'package:flutter/material.dart';
import 'package:my_albums_app/repo/profile_repo.dart';
import 'package:my_albums_app/screen/profile/contact_info/contact_info_screen.dart';
import 'package:my_albums_app/screen/profile/your_profile/profile_view_model.dart';
import 'package:my_albums_app/theming/dimensions.dart';
import 'package:my_albums_app/widgets/app_bar_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:my_albums_app/widgets/list_tile_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final ProfileViewModel profileViewModel =
      ProfileViewModel(ProfileRepo(SharedPreferences.getInstance()), Input());

  @override
  initState() {
    super.initState();
    profileViewModel.input.load.add(true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
          title: Text(AppLocalizations.of(context)!.yourProfile,
              style: Theme.of(context).textTheme.headlineSmall),
          centerTitle: false,
          actions: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.notifications))
          ]),
      body: StreamBuilder(
        stream: profileViewModel.output.data,
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return _buildUser(context, snapshot.data as ProfileData);
          }
        },
      ),
    );
  }

  Widget _buildUser(BuildContext context, ProfileData profileData) {
    final translations = {
      "unknown": AppLocalizations.of(context)!.unknown,
      "emailAddress": AppLocalizations.of(context)!.emailAddress,
      "memberSince": AppLocalizations.of(context)!.memberSince,
    };
    return SingleChildScrollView(
      child: Padding(
        padding: albumListPadding,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              smallVerticalDistance,
              CircleAvatar(
                foregroundColor: Theme.of(context).colorScheme.onPrimary,
                backgroundColor: Theme.of(context).colorScheme.primary,
                minRadius: 40.0,
                child: Text(
                  profileData.circularAvatarText,
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
              ),
              normalVerticalDistance,
              Text(
                translations.containsKey(profileData.fullName)
                    ? translations[profileData.fullName]!
                    : profileData.fullName,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              Text(
                translations.containsKey(profileData.memberSince)
                    ? "${translations[profileData.memberSince]!} ${profileData.profile!.year}"
                    : profileData.memberSince,
                style: Theme.of(context).textTheme.titleSmall,
              ),
              xLargeVerticalDistance,
              ListTileWidget(
                title: Text(AppLocalizations.of(context)!.contactInfo),
                subtitle: Text(translations
                        .containsKey(profileData.emailAddress)
                    ? "${translations[profileData.emailAddress]}: ${profileData.profile!.email}"
                    : profileData.emailAddress),
                leadingIconData: Icons.perm_contact_calendar_rounded,
                onTap: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(
                    builder: (context) => ContactInfoScreen(
                      profile: profileData.profile,
                    ),
                  ))
                      .then((value) {
                    profileViewModel.input.load.add(true);
                  });
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
