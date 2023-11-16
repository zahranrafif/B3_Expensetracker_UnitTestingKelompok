import 'package:flutter/material.dart';
import 'package:expensetracker/config/color.dart';
import 'package:expensetracker/config/style.dart';

class ProfilePic extends StatefulWidget {
  const ProfilePic({super.key, required this.firstName, required this.backgroundColor, required this.textColor});

  final String firstName;
  final Color backgroundColor;
  final Color textColor;

  String get firstLetter => this.firstName.substring(0, 1).toUpperCase();

  @override
  State<ProfilePic> createState() => _ProfilePicState();
}


class _ProfilePicState extends State<ProfilePic> {
  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.contain,
      alignment: Alignment.center,
      child: Container(
        alignment: Alignment.center,
        height: 40,
        width: 40,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: widget.backgroundColor,
          border: Border.all(color: Colors.white12, width: 2),
          // gradient: const LinearGradient(colors: [mainLightBlue, mainDarkBlue], begin: Alignment.topCenter, end: Alignment.bottomCenter)
        ),
        padding: EdgeInsets.all(8),
        child: Text(widget.firstLetter, style: TextStyle(color: widget.textColor, fontSize: 20, fontWeight: FontWeight.bold)),
      ),
    );
  }
}