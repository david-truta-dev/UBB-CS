import 'dart:async';

import 'package:flutter/material.dart';
import 'package:my_albums_app/screen/main/tab_bar_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


import '../albums/albums_screen.dart';
import '../friends/friends_screen.dart';
import '../news/news_screen.dart';
import '../profile/your_profile/profile_screen.dart';
import '../splash/splash_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late Timer _timer;

  @override
  initState() {
    super.initState();
    _timer = Timer(const Duration(milliseconds: 2200), () => {setState(() {})});
  }

  @override
  Widget build(BuildContext context) {
    return _timer.isActive
        ? const SplashScreen()
        : TabBarWidget(
            screens: [
              {'screen': AlbumsScreen(), 'icon':const Icon(Icons.search), 'label': Text(AppLocalizations.of(context)!.browse.toUpperCase())},
              {'screen': const FriendsScreen(), 'icon':const Icon(Icons.emoji_emotions_outlined), 'label': Text(AppLocalizations.of(context)!.friends.toUpperCase())},
              {'screen': const NewsScreen(), 'icon':const Icon(Icons.newspaper), 'label': Text(AppLocalizations.of(context)!.news.toUpperCase())},
              {'screen': const ProfileScreen(), 'icon':const Icon(Icons.account_circle_outlined), 'label': Text(AppLocalizations.of(context)!.profile.toUpperCase())},
            ],
          );
  }
}
