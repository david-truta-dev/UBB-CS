import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:my_albums_app/screen/friends/friends_screen.dart';
import 'package:my_albums_app/screen/main/tab_bar_widget.dart';
import 'package:my_albums_app/screen/news/news_screen.dart';

void main() {
  group("TabBarWidgetTest - ", () {
    testWidgets('TabBarWidget tests', (tester) async {
      const myApp = MaterialApp(
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
        home: TabBarWidget(screens: [
          {
            "screen": FriendsScreen(),
            "icon": Icon(Icons.access_time),
            "label": Text("atit s-a putut")
          },
          {
            "screen": NewsScreen(),
            "icon": Icon(Icons.access_time),
            "label": Text("inca una")
          }
        ]),
      );
      await tester.pumpWidget(myApp);

      expect(find.text('atit s-a putut'), findsOneWidget);
      expect(find.text('inca una'), findsOneWidget);

      await tester.tap(find.byType(Tab).first);
      await tester.pumpAndSettle();
      expect(find.text('Friends'), findsOneWidget);

      await tester.tap(find.widgetWithText(Tab, "inca una"));
      await tester.pumpAndSettle();
      expect(find.text('News'), findsOneWidget);
    });
  });
}
