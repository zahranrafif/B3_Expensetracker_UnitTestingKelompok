import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expensetracker/domain/models/transaction/transaction_model.dart';
import 'package:expensetracker/presentation/widgets/inputs/input_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:expensetracker/presentation/pages/outcome/edit_outcome_page.dart';
import 'package:expensetracker/presentation/pages/outcome/bloc/outcome_bloc.dart';
import 'package:mockito/mockito.dart';

class MockOutcomeBloc extends Mock implements OutcomeBloc {}

void main() {
  late MockOutcomeBloc mockOutcomeBloc;

  setUp(() {
    mockOutcomeBloc = MockOutcomeBloc();
  });

  Widget buildTestableWidget() {
    return MaterialApp(
      home: EditOutcomePage(
          outcome: TransactionModel(
              id: '1',
              amount: 100,
              description: 'Test',
              isIncome: false,
              trxDate: Timestamp.now(),
              userId: 'userId')),
    );
  }

  testWidgets('EditOutcomePage renders correctly', (WidgetTester tester) async {
    await tester.pumpWidget(buildTestableWidget());

    // Verify that the EditOutcomePage is rendered
    expect(find.byType(EditOutcomePage), findsOneWidget);
    expect(find.text('Edit Pengeluaran'), findsOneWidget);
  });
}
