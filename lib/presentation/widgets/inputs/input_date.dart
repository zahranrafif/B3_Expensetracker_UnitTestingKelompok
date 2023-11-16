import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:expensetracker/config/style.dart';

class InputDate extends StatefulWidget {
  const InputDate({super.key, required this.validatorMessage, this.prefixIcon, required this.labelText, required this.keyboardType, required this.controller, this.style});

  final String validatorMessage;
  final Icon? prefixIcon;
  final String labelText;
  final TextInputType keyboardType;
  final TextEditingController controller;
  final int? style;

  @override
  State<InputDate> createState() => _InputDateState();
}

class _InputDateState extends State<InputDate> {
  @override
  Widget build(BuildContext context) {
    if(widget.style != null && widget.style == 2){ // style filter

      return TextFormField(
        keyboardType: widget.keyboardType,
        validator: (value) => value.toString().isEmpty ? widget.validatorMessage : null,
        decoration: InputDecoration(
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            borderSide: BorderSide.none
          ),
          prefixIcon: widget.prefixIcon,
          hintText: widget.labelText,
          fillColor: Colors.grey.shade200,
          filled: true,
          contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0)
          
        ),
        style: const TextStyle(fontSize: 11),
        controller: widget.controller,
        readOnly: true,  //set it true, so that user will not able to edit text
        onTap: () async {
          DateTime? pickedDate = await showDatePicker(
              context: context, 
              initialDate: widget.controller.text != '' ? DateTime.parse(widget.controller.text) : DateTime.now(),
              firstDate: DateTime(2000), //DateTime.now() - not to allow to choose before today.
              lastDate: DateTime(2101)
          );
          
          if(pickedDate != null ){
              String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
              widget.controller.text = formattedDate;
          }else{
              print("Date is not selected");
          }
        },
      );

    }else{ // style umum
      return TextFormField(
        keyboardType: widget.keyboardType,
        validator: (value) => value.toString().isEmpty ? widget.validatorMessage : null,
        decoration: InputDecoration(
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            borderSide: BorderSide.none
          ),
          prefixIcon: widget.prefixIcon,
          hintText: widget.labelText,
          fillColor: Colors.grey.shade200,
          filled: true,
        ),
        controller: widget.controller,
        readOnly: true,  //set it true, so that user will not able to edit text
        onTap: () async {
          DateTime? pickedDate = await showDatePicker(
              context: context, 
              initialDate: widget.controller.text != '' ? DateTime.parse(widget.controller.text) : DateTime.now(),
              firstDate: DateTime(2000), //DateTime.now() - not to allow to choose before today.
              lastDate: DateTime(2101)
          );
          
          if(pickedDate != null ){
              String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
              widget.controller.text = formattedDate;
          }else{
              print("Date is not selected");
          }
        },
      );
    }

  }
  
}