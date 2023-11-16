import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:expensetracker/config/color.dart';

class ButtonScreen extends StatefulWidget {
  const ButtonScreen({super.key, required this.text, required this.isLoading, required this.action});

  final String text;
  final bool isLoading; // { 1 : style form login/register, 2 : style form normal}
  final VoidCallback action;

  @override
  State<ButtonScreen> createState() => _ButtonScreenState();
}

class _ButtonScreenState extends State<ButtonScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 30.0),
      width: double.infinity,
      child: ElevatedButton(
        onPressed: widget.action,
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.all(15.0),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
          backgroundColor: Colors.white,
        ),
        child : widget.isLoading ? const SizedBox(
          width: 25,
          height: 25,
          child: CircularProgressIndicator(
            backgroundColor: Colors.transparent,
            color: mainDarkBlue,
          )
        ) :
        Text(
          widget.text,
          style: const TextStyle(color: Color(0xFF398AE5)),
        ),
      ),
    );
  }
}