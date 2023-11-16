import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/intl.dart';
import 'package:expensetracker/domain/helpers/date_formatter.dart';

void main() {
  group('DateFormatter', () {
    test('dateFormatYMD returns the correct format', () {
      // Replace with a sample Timestamp value for testing
      Timestamp datetime = Timestamp.now();

      String formattedDate = DateFormatter().dateFormatYMD(datetime);

      String expectedDate = DateFormat('yyyy-MM-dd').format(
        DateTime.fromMillisecondsSinceEpoch(datetime.millisecondsSinceEpoch),
      );

      expect(formattedDate, expectedDate);
    });

    test('dateFormatDMY returns the correct format', () {
      // Replace with a sample Timestamp value for testing
      Timestamp datetime = Timestamp.now();

      String formattedDate = DateFormatter().dateFormatDMY(datetime);

      String expectedDate = DateFormat('dd-MM-yyyy').format(
        DateTime.fromMillisecondsSinceEpoch(datetime.millisecondsSinceEpoch),
      );

      expect(formattedDate, expectedDate);
    });
  });
}
