import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AlbumInteractionWidget extends StatelessWidget {
  final int nrOfPhotos;

  const AlbumInteractionWidget({Key? key, required this.nrOfPhotos})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Flexible(
          fit: FlexFit.tight,
          flex: 1,
          child: InkWell(
            borderRadius: BorderRadius.circular(20),
            onTap: () {
              Fluttertoast.showToast(
                msg: "Not implemented yet !",
              );
            },
            child: Column(
              children: [
                Icon(
                  Icons.favorite,
                  color: Theme.of(context).colorScheme.primary,
                ),
                Text(
                  AppLocalizations.of(context)!.saveToFavorites,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleSmall,
                )
              ],
            ),
          ),
        ),
        const VerticalDivider(
          thickness: 1,
        ),
        Flexible(
          fit: FlexFit.tight,
          flex: 1,
          child: Column(
            children: [
              FittedBox(
                child: Text(
                  nrOfPhotos.toString(),
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ),
              Text(
                AppLocalizations.of(context)!.photos,
                style: Theme.of(context).textTheme.titleSmall,
              )
            ],
          ),
        ),
        const VerticalDivider(
          thickness: 1,
        ),
        Flexible(
          fit: FlexFit.tight,
          flex: 1,
          child: InkWell(
            borderRadius: BorderRadius.circular(20),
            onTap: () {
              Fluttertoast.showToast(
                msg: "Not implemented yet !",
              );
            },
            child: Column(
              children: [
                Icon(Icons.mode_comment_rounded,
                    color: Theme.of(context).colorScheme.primary),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  AppLocalizations.of(context)!.addAComment,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleSmall,
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
