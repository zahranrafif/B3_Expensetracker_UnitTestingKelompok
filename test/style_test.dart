import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:expensetracker/config/style.dart'; // Import your color file

void main() {
  test('BoxDecoration is not null', () {
    expect(boxDecorationStyle, isNotNull);
    expect(boxDecorationStyle, isInstanceOf<BoxDecoration>());
  });

  test('TextStyles are not null and of type TextStyle', () {
    expect(hintTextStyle, isNotNull);
    expect(hintTextStyle, isInstanceOf<TextStyle>());

    expect(labelStyle, isNotNull);
    expect(labelStyle, isInstanceOf<TextStyle>());

    expect(displayNameStyle, isNotNull);
    expect(displayNameStyle, isInstanceOf<TextStyle>());

    expect(displayEmailStyle, isNotNull);
    expect(displayEmailStyle, isInstanceOf<TextStyle>());

    expect(incomeNumberStyle, isNotNull);
    expect(incomeNumberStyle, isInstanceOf<TextStyle>());

    expect(outcomeNumberStyle, isNotNull);
    expect(outcomeNumberStyle, isInstanceOf<TextStyle>());

    expect(displayDayStyle, isNotNull);
    expect(displayDayStyle, isInstanceOf<TextStyle>());

    expect(displayDateStyle, isNotNull);
    expect(displayDateStyle, isInstanceOf<TextStyle>());

    expect(displayProfileNameStyle, isNotNull);
    expect(displayProfileNameStyle, isInstanceOf<TextStyle>());

    expect(displayProfileEmailStyle, isNotNull);
    expect(displayProfileEmailStyle, isInstanceOf<TextStyle>());

    expect(displayFooterStyle, isNotNull);
    expect(displayFooterStyle, isInstanceOf<TextStyle>());
  });

  test('Gradients are not null and of type LinearGradient', () {
    expect(gradientGreenStyle, isNotNull);
    expect(gradientGreenStyle, isInstanceOf<LinearGradient>());

    expect(gradientRedStyle, isNotNull);
    expect(gradientRedStyle, isInstanceOf<LinearGradient>());
  });
}
