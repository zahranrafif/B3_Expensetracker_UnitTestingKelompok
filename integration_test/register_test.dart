import 'package:expensetracker/presentation/pages/dashboard/dashboard_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:expensetracker/presentation/pages/auth/register_page.dart';

void main() {
  testWidgets('Register page UI test', (WidgetTester tester) async {
    // Build our widget and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: RegisterPage(),
    ));

    // Enter text into the name input field
    await tester.enterText(find.byKey(const Key('_name_input')), 'John Doe');
    // Enter text into the email input field
    await tester.enterText(
        find.byKey(const Key('_email_input')), 'john@example.com');
    // Enter text into the password input field
    await tester.enterText(
        find.byKey(const Key('_password_input')), 'password123');
    // Enter text into the re-password input field
    await tester.enterText(
        find.byKey(const Key('_repassword_input')), 'password123');

    // Tap the 'DAFTAR' button
    await tester.tap(find.text('DAFTAR'));
    await tester.pumpAndSettle(); // Wait for any animations to complete
  });
}
