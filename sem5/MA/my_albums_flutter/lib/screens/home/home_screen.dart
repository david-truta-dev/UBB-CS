import 'package:flutter/material.dart';
import 'package:my_albums_flutter/screens/home/widgets/photo_list_tile.dart';

import '../../repo/photo_repo.dart';
import '../../theme/app_colors.dart';
import '../add/add_screen.dart';
import '../edit/edit_screen.dart';
import 'home_view_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HomeViewModel _viewModel = HomeViewModel(PhotoRepo());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "My Photos",
          style: TextStyle(fontSize: 30),
        ),
        actions: [
          IconButton(
              onPressed: () => Navigator.of(context)
                  .push(MaterialPageRoute(
                      builder: (BuildContext context) => const AddScreen()))
                  .then((_) => setState(() {})),
              icon: const Icon(Icons.add_photo_alternate_outlined))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: ListView(
          children: _viewModel
              .getPhotos()
              .map(
                (p) => PhotoListTile(
                  photo: p,
                  onEdit: () => Navigator.of(context)
                      .push(MaterialPageRoute(
                          builder: (context) => EditScreen(photo: p)))
                      .then((_) => setState(() {})),
                  onDelete: () => showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      backgroundColor: AppColors.backgroundColor,
                      title: const Center(child: Text("Are you sure ?", style: TextStyle(color: Colors.white),)),
                      actionsAlignment: MainAxisAlignment.spaceAround,
                      actions: [
                        TextButton(
                            onPressed: () => Navigator.of(context).pop(),
                            child: const Text("No")),
                        TextButton(
                            onPressed: () => setState(() {
                                  _viewModel.deletePhotos(p.id);
                                  Navigator.of(context).pop();
                                }),
                            child: const Text("Yes")),
                      ],
                    ),
                  ),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
