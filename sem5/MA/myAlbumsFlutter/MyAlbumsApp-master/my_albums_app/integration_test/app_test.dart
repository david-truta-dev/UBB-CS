import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

// ignore: avoid_relative_lib_imports
import '../lib/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('end-to-end test', () {
    testWidgets('tap on the an album, verify it displays album details',
        (tester) async {
      app.main();
      await tester.pumpAndSettle();

      final Finder album = find.text("Album with id: 2");
      expect(album, findsOneWidget);

      await tester.tap(album);
      await tester.pumpAndSettle();

      final Finder appBarDetails = find.text("Details");
      expect(appBarDetails, findsOneWidget);

      final backButton = find.byIcon(Icons.arrow_back);
      expect(backButton, findsOneWidget);

      await tester.tap(backButton);
      await tester.pumpAndSettle();

      expect(find.text("My Albums"), findsOneWidget);
    });
  });
}
