import 'package:expensetracker/presentation/widgets/profile_pics/profile_pic.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('ProfilePic displays correct first letter and colors',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: ProfilePic(
              firstName: 'Fajri Fatchul',
              backgroundColor: Colors.blue,
              textColor: Colors.white),
        ),
      ),
    );
    expect(find.text('F'), findsOneWidget);
    expect(
      tester.widget<Container>(find.byType(Container)).decoration,
      BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.blue,
        border: Border.all(color: Colors.white12, width: 2),
      ),
    );

    expect(
      tester.widget<Text>(find.byType(Text)).style!.color,
      equals(Colors.white),
    );
  });
}
