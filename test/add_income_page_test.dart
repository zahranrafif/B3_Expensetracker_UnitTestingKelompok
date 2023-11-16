import 'package:expensetracker/presentation/widgets/inputs/input_date.dart';
import 'package:expensetracker/presentation/widgets/inputs/input_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:expensetracker/presentation/pages/income/add_income_page.dart';
import 'package:expensetracker/presentation/pages/income/bloc/income_bloc.dart';

void main() {
  group('AddIncomePage Tests', () {
    late AddIncomePage addIncomePage;

    setUp(() {
      addIncomePage = AddIncomePage();
    });

    testWidgets('Renders widgets', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: addIncomePage,
        ),
      );
      expect(find.text("Tambah Pemasukan"), findsOneWidget);
      expect(find.text("Deskripsi"), findsOneWidget);
      expect(find.text("Nominal"), findsOneWidget);
      expect(find.text("Tanggal"), findsOneWidget);
      expect(find.text("Save"), findsOneWidget);

      expect(find.byType(InputText), findsNWidgets(2));
      expect(find.byType(InputDate), findsOneWidget);
      expect(find.byType(ElevatedButton), findsOneWidget);
    });

    testWidgets('Save button triggers Bloc event', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider<IncomeBloc>(
            create: (context) => IncomeBloc(),
            child: addIncomePage,
          ),
        ),
      );
      await tester.enterText(find.byType(TextField).first, 'Gaji bulanan');
      await tester.enterText(find.byType(TextField).at(1), '1000000');
      await tester.enterText(find.byType(TextField).last, '2023-01-01');
      await tester.tap(find.text('Save'));
      await tester.pumpAndSettle();
      expect(find.byType(ElevatedButton), findsOneWidget);
      expect(find.byType(TextField), findsNWidgets(3));
    });
  });
}
