import 'package:ems_app/src/screens/settings/theme_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets("description", (WidgetTester tester) async {
    Widget makeTestableWidget({Widget child}) {
      return MaterialApp(
        home: child,
      );
    }

    ThemeSettingScreen themeSettingScreen = ThemeSettingScreen();
    await tester.pumpWidget(makeTestableWidget(child: themeSettingScreen));
  });
}
