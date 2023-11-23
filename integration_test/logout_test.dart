import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:expensetracker/presentation/pages/profile/profile_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:integration_test/integration_test.dart';

Future main() async {
  group('"Logout Test"', () {
    testWidgets('Logout Page UI Test', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: const ProfilePage(),
      ));

      // Expectations for the Profile Page UI Testing
      expect(find.text('ExpenseTracker ©2023'), findsOneWidget);
      expect(find.text('by Abdil Tegar Arifin'), findsOneWidget);

      // You can add more expectations based on your UI

      // Example: Testing Logout functionality
      await tester.tap(find.byType(IconButton));
      await tester.pumpAndSettle();

      // Expect the AlertDialog to be present after tapping logout
      expect(find.byType(AlertDialog), findsOneWidget);

      // Example: Tap on "Logout" button in the AlertDialog
      await tester.tap(find.text('Logout').last);
      await tester.pumpAndSettle();
    });
  });
}
