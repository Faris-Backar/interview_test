import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final String lable;
  const TextFieldWidget({
    Key? key,
    required this.controller,
    required this.lable,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
          labelText: lable,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
          enabled: false),
    );
  }
}
