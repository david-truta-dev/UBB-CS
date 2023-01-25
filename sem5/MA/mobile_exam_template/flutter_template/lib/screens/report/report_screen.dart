import 'package:flutter/material.dart';
import 'package:flutter_template/repo/entity_repo.dart';
import 'package:flutter_template/screens/report/report_view_model.dart';
import 'package:flutter_template/widgets/generic_list_tile.dart';

import '../../utils.dart';

class ReportScreen extends StatefulWidget {
  const ReportScreen({Key? key}) : super(key: key);

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  final ReportViewModel _viewModel = ReportViewModel(EntityRepo());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar,
      body: Utils.checkInternetScreenWrapper(
        onRetry: () => setState(() {}),
        child: _screen,
      ),
    );
  }

  Widget get _screen => StreamBuilder(
        stream: _viewModel.getEntities(),
        builder: (context, snapshot) {
          if (snapshot.error != null) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Utils.displayError(context, snapshot.error.toString());
            });
            return Container();
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return ListView(children: [
              const SizedBox(height: 10),
              const Text(
                "Top 10 planes by size",
                style: TextStyle(
                    color: Colors.white70,
                    fontSize: 22,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const Divider(
                color: Colors.white70,
                thickness: 2,
              ),
              ...(_viewModel
                  .getTop10BiggestPlanes(snapshot.data!)
                  .map((e) => GenericListTile(
                        title: e.name!,
                        subtitles: [
                          e.status!,
                          e.size.toString(),
                          e.owner!,
                        ],
                      ))
                  .toList()),
              const SizedBox(height: 30),
              const Text(
                "Top 10 owners by number of planes",
                style: TextStyle(
                    color: Colors.white70,
                    fontSize: 22,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const Divider(
                color: Colors.white70,
                thickness: 2,
              ),
              ...(_viewModel
                  .getTop10Owners(snapshot.data!)
                  .map((e) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: GenericListTile(
                        title: e.name,
                        trailing: e.nrOfPlanes,
                      )))
                  .toList()),
              const SizedBox(height: 30),
              const Text(
                "Top 5 planes by capacity",
                style: TextStyle(
                    color: Colors.white70,
                    fontSize: 22,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const Divider(
                color: Colors.white70,
                thickness: 2,
              ),
              ...(_viewModel
                  .getTop5PlanesByCapacity(snapshot.data!)
                  .map((e) => GenericListTile(
                        title: e.name!,
                        trailing: e.capacity.toString(),
                      ))
                  .toList())
            ]);
          }
        },
      );

  AppBar get _appBar => AppBar(
        title: const Text(
          "Report",
          style: TextStyle(fontSize: 30, color: Colors.black54),
        ),
      );
}
