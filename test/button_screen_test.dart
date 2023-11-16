import 'package:expensetracker/presentation/widgets/buttons/button_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('ButtonScreen displays text when not loading',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: ButtonScreen(text: 'Click Me', isLoading: false, action: () {}),
        ),
      ),
    );

    expect(find.text('Click Me'), findsOneWidget);
    expect(find.byType(CircularProgressIndicator), findsNothing);
  });

  testWidgets('ButtonScreen displays CircularProgressIndicator when loading',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: ButtonScreen(text: 'Click Me', isLoading: true, action: () {}),
        ),
      ),
    );

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    expect(find.text('Click Me'), findsNothing);
  });

  testWidgets('ButtonScreen calls action when button is pressed',
      (WidgetTester tester) async {
    var actionCalled = false;
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: ButtonScreen(
              text: 'Click Me',
              isLoading: false,
              action: () {
                actionCalled = true;
              }),
        ),
      ),
    );

    await tester.tap(find.byType(ElevatedButton));
    await tester.pump();
    expect(actionCalled, isTrue);
  });
}
