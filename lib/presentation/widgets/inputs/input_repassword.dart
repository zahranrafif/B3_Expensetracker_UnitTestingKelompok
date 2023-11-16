import 'package:flutter/material.dart';
import 'package:expensetracker/config/style.dart';

class InputRePassword extends StatefulWidget {
  const InputRePassword({super.key, required this.prefixIcon, required this.labelText, required this.style, required this.controller, required this.passwordController});

  final Icon prefixIcon;
  final String labelText;
  final int style;
  final TextEditingController controller;
  final TextEditingController passwordController;

  @override
  State<InputRePassword> createState() => _InputRePasswordState();
}

class _InputRePasswordState extends State<InputRePassword> {


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
          validator: (value) => value.toString().isEmpty ? "Please re-enter your password" : value.toString().length < 6 ? "Must be at least 6 characters" : widget.passwordController.text != value.toString() ? "Password must be the same" : null,
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
        validator: (value) => value.toString().isEmpty ? "Please re-enter your password" : value.toString().length < 6 ? "Must be at least 6 characters" : widget.passwordController.text != value.toString() ? "Password must be the same" : null,
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