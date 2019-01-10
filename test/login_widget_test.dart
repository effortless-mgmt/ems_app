import 'package:ems_app/main.dart';
import 'package:ems_app/src/screens/home_screen.dart';
import 'package:ems_app/src/widgets/navbar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ems_app/src/screens/login_screen.dart';
import 'package:mockito/mockito.dart';

class MockNavigatorObserver extends Mock implements NavigatorObserver {}

void main() {
  group('LoginScreen navigation tests:', () {
    NavigatorObserver mockObserver;

    setUp(() {
      mockObserver = MockNavigatorObserver();
    });

    Future<Null> _buildLoginPage(WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: Navbar(),
        navigatorObservers: [mockObserver],
      ));

      verify(mockObserver.didPush(any, any));
    }

    Future<Null> _navigateToHomeScreen(WidgetTester tester) async {
      await tester.tap(find.byKey(LoginScreen.loginButtonKey));
      await tester.pumpAndSettle();
    }

    testWidgets('tapping login button should navigate to the home screen',
        (WidgetTester tester) async {
      await _buildLoginPage(tester);
      await _navigateToHomeScreen(tester);

      expect(find.byType(HomeScreen), findsOneWidget);
      expect(find.text('Upcoming Shifts'), findsOneWidget);
    });
  });
}
