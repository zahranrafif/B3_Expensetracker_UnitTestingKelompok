import 'package:flutter/material.dart';
import 'package:expensetracker/config/style.dart';

class InputEmail extends StatefulWidget {
  const InputEmail({super.key, required this.prefixIcon, required this.labelText, required this.style, required this.controller});

  final Icon prefixIcon;
  final String labelText;
  final int style; // { 1 : style form login/register, 2 : style form normal}
  final TextEditingController controller;

  @override
  State<InputEmail> createState() => _InputEmailState();
}

class _InputEmailState extends State<InputEmail> {
  @override
  Widget build(BuildContext context) {
    if(widget.style == 1){ // style form login/register
      return TextFormField(
        style: const TextStyle(
          color: Colors.white,
          fontFamily: 'OpenSans',
        ),
        validator: (value) => value.toString().isEmpty ? "Please enter your email" : value.toString().length < 6 ? "Must be at least 6 characters" : !value.toString().contains("@") ? "Please enter a valid email" : null,
        decoration: InputDecoration(
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            borderSide: BorderSide.none
          ),
          fillColor: const Color(0xFF6CA8F1),
          filled: true,
          contentPadding: const EdgeInsets.only(top: 14.0),
          prefixIcon: widget.prefixIcon,
          hintText: widget.labelText,
          hintStyle: hintTextStyle,
          errorStyle: const TextStyle(color: Colors.white70)
        ),
        keyboardType: TextInputType.emailAddress,
        controller: widget.controller,
      );

    }else{ // style form normal

      return TextFormField(
        keyboardType: TextInputType.emailAddress,
        validator: (value) => value.toString().isEmpty ? "Please enter your email" : value.toString().length < 6 ? "Must be at least 6 characters" : !value.toString().contains("@") ? "Please enter a valid email" : null,
        decoration: InputDecoration(
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            borderSide: BorderSide.none
          ),
          prefixIcon: widget.prefixIcon,
          hintText: widget.labelText,
          fillColor: Colors.grey.shade200,
          filled: true
        ),
        controller: widget.controller,
      );

    }
    
  }
}