import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_albums_app/widgets/list_tile_widget.dart';

void main() {
  group("ListTileWidgetTest - ", () {
    testWidgets('leadingIconData', (tester) async {
      final myApp = MaterialApp(
        home: Scaffold(
          body: Column(
            children: const [
              ListTileWidget(
                leadingIconData: Icons.access_time,
                title: Text('title'),
                subtitle: Text('subtitle'),
                trailing: Text('trailing'),
              ),
            ],
          ),
        ),
      );
      await tester.pumpWidget(myApp);

      expect(find.byIcon(Icons.access_time), findsOneWidget);
      expect(find.text('title'), findsOneWidget);
      expect(find.text('subtitle'), findsOneWidget);
      expect(find.text('trailing'), findsOneWidget);
    });

    testWidgets('leading', (tester) async {
      final myApp = MaterialApp(
        home: Scaffold(
          body: Column(
            children: const [
              ListTileWidget(
                leading: Text('leading'),
                title: Text('title'),
                subtitle: Text('subtitle'),
                trailing: Text('trailing'),
              ),
            ],
          ),
        ),
      );
      await tester.pumpWidget(myApp);

      expect(find.text('leading'), findsOneWidget);
      expect(find.text('title'), findsOneWidget);
      expect(find.text('subtitle'), findsOneWidget);
      expect(find.text('trailing'), findsOneWidget);
    });
  });
}
