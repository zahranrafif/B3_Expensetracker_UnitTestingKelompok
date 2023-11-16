import 'package:flutter/material.dart';
import 'package:expensetracker/config/color.dart';

final boxDecorationStyle = BoxDecoration(
  color: const Color(0xFF6CA8F1),
  borderRadius: BorderRadius.circular(10.0),
  boxShadow: const [
    BoxShadow(
      color: Colors.black12,
      blurRadius: 6.0,
      offset: Offset(0, 2),
    ),
  ],
);

const hintTextStyle = TextStyle(
  color: Colors.white54,
  fontFamily: 'OpenSans',
);

const labelStyle = TextStyle(
  color: Colors.white,
  fontWeight: FontWeight.bold,
  fontFamily: 'OpenSans',
);

const displayNameStyle = TextStyle(
  color: mainDarkBlue,
  fontSize: 14,
  fontFamily: 'OpenSans',
);

const displayEmailStyle = TextStyle(
  color: Colors.black54,
  fontSize: 11,
  fontFamily: 'OpenSans',
);

const incomeNumberStyle = TextStyle(color: Colors.green, fontWeight: FontWeight.bold);
const outcomeNumberStyle = TextStyle(color: Colors.red, fontWeight: FontWeight.bold);

const displayDayStyle = TextStyle(color: Colors.black, fontSize: 18);
const displayDateStyle = TextStyle(color: mainDarkBlue, fontSize: 15, fontWeight: FontWeight.bold);

const displayProfileNameStyle = TextStyle(color: Colors.white, fontSize: 20);
const displayProfileEmailStyle = TextStyle(color: Colors.white, fontSize: 15);

const displayFooterStyle = TextStyle(color: Colors.white60, fontSize: 11,);

const gradientGreenStyle = LinearGradient(colors: [Colors.green, Colors.lightGreen], begin: Alignment.bottomCenter, end: Alignment.topCenter);
const gradientRedStyle = LinearGradient(colors: [Colors.red, Colors.orange], begin: Alignment.bottomCenter, end: Alignment.topCenter);
