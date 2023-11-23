import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:expensetracker/presentation/pages/auth/login_page.dart';
import 'package:integration_test/integration_test.dart';
import 'package:expensetracker/presentation/pages/home_page.dart';

Future main() async {
  group('"Login Test"', () {
    testWidgets('Login Page UI Test', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: LoginPage(),
      ));

      // Example: Testing login functionality
      await tester.enterText(
          find.byKey(const Key('_email_input')), 'zahran@gmail.com');
      await tester.enterText(
          find.byKey(const Key('_password_input')), '12345678');
      await tester.tap(find.text('MASUK'));
      await tester.pumpAndSettle();
    });
  });
}
