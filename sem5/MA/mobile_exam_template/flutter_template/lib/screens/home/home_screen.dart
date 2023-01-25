import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_template/screens/home/home_view_model.dart';
import 'package:flutter_template/screens/register/register_screen.dart';
import 'package:rxdart/rxdart.dart';

import '../../utils.dart';
import '../manage/manage_sceen.dart';
import '../owner/owner_screen.dart';
import '../report/report_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with WidgetsBindingObserver {
  final HomeViewModel _viewModel = HomeViewModel();
  StreamSubscription? _subscription;
  int _selectedTabIndex = 0;

  @override
  void initState() {
    /// Listening for added planes on server, and showing a popup
    _subscription = _viewModel
        .listenForAddedPlanes()
        .listen((entity) {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: const Text("A new plane was added!"),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(entity.name ?? ""),
                    Text(entity.status ?? ""),
                    Text(entity.size.toString()),
                    Text(entity.owner ?? ""),
                    Text(entity.manufacturer ?? ""),
                    Text(entity.capacity.toString()),
                  ],
                ),
              ));
    })
      ..onError((error) {
        Utils.displayError(context, error.toString());
      });
    super.initState();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      setState(() {});
    }
    super.didChangeAppLifecycleState(state);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _currentScreen,
      bottomNavigationBar: _bottomNavBar,
    );
  }

  Widget get _currentScreen {
    switch (_selectedTabIndex) {
      case 0:
        return const RegisterScreen();
      case 1:
        return const ManageScreen();
      case 2:
        return const ReportScreen();
      case 3:
        return const OwnerScreen();
      default:
        return const RegisterScreen();
    }
  }

  Widget get _bottomNavBar => BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.black12,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        unselectedItemColor: Colors.white38,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.format_list_bulleted),
            label: 'Register',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.app_registration_rounded),
            label: 'Manage',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.leaderboard_outlined),
            label: 'Report',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Owner',
          ),
        ],
        currentIndex: _selectedTabIndex,
        onTap: (index) => setState(() {
          _selectedTabIndex = index;
        }),
      );

  @override
  void dispose() {
    _subscription?.cancel();
    _viewModel.dispose();
    super.dispose();
  }
}
