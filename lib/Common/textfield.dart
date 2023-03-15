import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  // final dynamic controller;
  final bool obsecure_Text;
  final String text;
  final Icon icon;
  final String validator_value;
  String onChange_value;

  CustomTextField(
      {super.key,
      // required this.controller,
      required this.obsecure_Text,
      required this.text,
      required this.icon,
      required this.validator_value,
      required this.onChange_value});

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      // controller: widget.controller,
      obscureText: widget.obsecure_Text,
      decoration: InputDecoration(
        labelText: widget.text,
        labelStyle: const TextStyle(color: Color.fromARGB(255, 66, 63, 63)),
        prefixIcon: widget.icon,
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xffec6f59), width: 1.5),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xffec6f59), width: 1),
        ),
      ),
      onChanged: (value) {
        setState(() {
          widget.onChange_value = value;
          // print(widget.onChange_value);
        });
      },
      validator: (value) {
        if (value!.isEmpty) {
          return widget.validator_value;
        }
        return null;
      },
    );
  }
}
