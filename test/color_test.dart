import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:expensetracker/config/color.dart';

void main() {
  test('Color values are not null', () {
    expect(mainLightBlue, isNotNull);
    expect(mainLightBlue2, isNotNull);
    expect(mainDarkBlue, isNotNull);
    expect(mainLightGrey, isNotNull);
    expect(mainDarkWhite, isNotNull);
    expect(mainBackgroundWhite, isNotNull);
  });

  test('Color values are of type Color', () {
    expect(mainLightBlue, isInstanceOf<Color>());
    expect(mainLightBlue2, isInstanceOf<Color>());
    expect(mainDarkBlue, isInstanceOf<Color>());
    expect(mainLightGrey, isInstanceOf<Color>());
    expect(mainDarkWhite, isInstanceOf<Color>());
    expect(mainBackgroundWhite, isInstanceOf<Color>());
  });
}
