import 'package:flutter/material.dart';

class InputTextField extends StatelessWidget {
  final TextEditingController controller;

  const InputTextField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    //TODO: make the TextField more responsive

    // return LayoutBuilder(
    //   builder: (BuildContext context, BoxConstraints constraints) {
    //     double margin = ResponsiveInputField.getMargin(constraints);
    //     return Container(
    // padding: EdgeInsets.symmetric(horizontal: margin),
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        contentPadding:
            EdgeInsets.only(top: 16.0, bottom: 16.0, left: 32.0, right: 32.0),
        filled: true,
        hintText: "Add Tasks",
        fillColor: const Color(0xFFcdd6f4),
        hintStyle: TextStyle(
            color: const Color(0xFFa6adc8), fontWeight: FontWeight.bold),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(100),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
