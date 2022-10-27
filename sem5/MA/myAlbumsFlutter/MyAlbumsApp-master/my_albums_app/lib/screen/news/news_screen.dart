import 'package:flutter/material.dart';
import 'package:my_albums_app/widgets/app_bar_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class NewsScreen extends StatelessWidget {
  const NewsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        title: Text(AppLocalizations.of(context)!.news.replaceFirst("n", "N"),
            style: Theme.of(context).textTheme.headlineSmall),
        centerTitle: false,
      ),
      body: const Center(
        child: Text('News coming soon!'),
      ),
    );
  }
}
