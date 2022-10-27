import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_albums_app/widgets/app_bar_widget.dart';

void main() {
  group("AppBarWidgetTest - ", () {
    testWidgets('title, leading, actions', (tester) async {
      final myApp = MaterialApp(
        home: Scaffold(
          appBar: AppBarWidget(
            title: const Text("myTitle"),
            leading: const Text("leading"),
            actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.access_time))],
          ),
        ),
      );
      await tester.pumpWidget(myApp);

      expect(find.text('myTitle'), findsOneWidget);
      expect(find.text('leading'), findsOneWidget);
      expect(find.byIcon(Icons.access_time), findsOneWidget);
    });
  });
}
