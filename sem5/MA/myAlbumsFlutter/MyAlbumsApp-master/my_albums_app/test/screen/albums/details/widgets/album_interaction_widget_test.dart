import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:my_albums_app/screen/albums/details/widgets/album_interatcion_widget.dart';

void main() {
  testWidgets('AlbumInteractionWidget', (tester) async {
    await tester.pumpWidget(const MaterialApp(
      localizationsDelegates: [
        AppLocalizations.delegate, // Add this line
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        Locale('ro', ''),
        Locale('en', ''),
      ],
      home: Scaffold(
        body: AlbumInteractionWidget(
         nrOfPhotos: 420,
        ),
      ),
    ));
    expect(find.text('420'), findsOneWidget);
    expect(find.text('Photos'), findsOneWidget);
    expect(find.text('Save to favorites'), findsOneWidget);
    expect(find.text('Add a comment'), findsOneWidget);

    await tester.tap(find.byType(InkWell).first);
    await tester.pump();
    // Nothing is supposed to happen yet :) (can't test fluttertoast)

    await tester.tap(find.byType(InkWell).last);
    await tester.pump();
    // Nothing is supposed to happen yet :) (can't test fluttertoast)

  });
}
