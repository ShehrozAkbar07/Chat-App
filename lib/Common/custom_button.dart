import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class CustomButton extends StatelessWidget {
  final String text;
  CustomButton({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      height: size.height * 0.05,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Color(0xffec6f59),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Center(
        child: Text(
          text,
          style: const TextStyle(fontSize: 22, color: Colors.white),
        ),
      ),
    );
  }
}
