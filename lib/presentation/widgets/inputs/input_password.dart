import 'package:flutter/material.dart';
import 'package:expensetracker/config/style.dart';

class InputPassword extends StatefulWidget {
  const InputPassword({super.key, required this.prefixIcon, required this.labelText, required this.style, required this.controller});

  final Icon prefixIcon;
  final String labelText;
  final int style; // { 1 : style login/register, 2 : normal}
  final TextEditingController controller;

  @override
  State<InputPassword> createState() => _InputPasswordState();
}

class _InputPasswordState extends State<InputPassword> {
  @override
  Widget build(BuildContext context) {
    if(widget.style == 1){
        
        return TextFormField(
          keyboardType: TextInputType.visiblePassword,
          obscureText: true,
          style: const TextStyle(
            color: Colors.white,
            fontFamily: 'OpenSans',
          ),
          validator: (value) => value.toString().isEmpty ? "Please enter your password" : value.toString().length < 6 ? "Must be at least 6 characters" : null,
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
          controller: widget.controller,
        );

    }else{

      return TextFormField(
        keyboardType: TextInputType.visiblePassword,
        obscureText: true,
        validator: (value) => value.toString().isEmpty ? "Please enter your password" : value.toString().length < 6 ? "Must be at least 6 characters" : null,
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