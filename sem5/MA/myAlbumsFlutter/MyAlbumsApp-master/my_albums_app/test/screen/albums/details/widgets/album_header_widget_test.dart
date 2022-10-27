import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_albums_app/screen/albums/details/widgets/album_header_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() {
  testWidgets('AlbumHeaderWidget test', (tester) async {
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
        body: AlbumHeaderWidget(
          id: 69,
          title: 'Album nr 12431',
        ),
      ),
    ));
    expect(find.text('Album nr 12431'), findsOneWidget);
    expect(find.text('Album with id: 69'), findsOneWidget);
    expect(find.text('A'), findsOneWidget);
  });
}
