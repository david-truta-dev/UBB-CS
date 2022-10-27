import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:my_albums_app/model/photo.dart';
import 'package:my_albums_app/screen/albums/details/widgets/photo_list_widget.dart';
import 'package:network_image_mock/network_image_mock.dart';

void main() {
  testWidgets('PhotoListWidget', (tester) async {
    mockNetworkImagesFor(() async {
      await tester.pumpWidget(
        MaterialApp(
          localizationsDelegates: const [
            AppLocalizations.delegate, // Add this line
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('ro', ''),
            Locale('en', ''),
          ],
          home: Scaffold(
            body: SingleChildScrollView(
              child: Center(
                child: Column(
                  children: [
                    PhotoListWidget(
                      photos: List<Photo>.generate(
                        1000,
                        (index) => Photo(
                          id: index,
                          albumId: 101,
                          title: "title$index",
                          thumbnailUrl: "https://example.com/image.png",
                          url: "https://example.com/image.png",
                          key: Key("item_${index}_text"),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );

      final listFinder = find.byType(Scrollable).first;
      final itemFinder = find.textContaining('title420').first;

      await tester.scrollUntilVisible(
        itemFinder,
        500.0,
        scrollable: listFinder,
      );

      // Verify that the item contains the correct text.
      expect(itemFinder, findsOneWidget);
    });
  });
}
