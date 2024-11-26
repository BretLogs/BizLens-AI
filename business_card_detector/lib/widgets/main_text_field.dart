import 'package:flutter/material.dart';

class MainTextField extends StatelessWidget {
  const MainTextField({super.key, required this.labelTxt, this.controller});
  final String labelTxt;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: TextField(
        decoration: InputDecoration(
            border: const OutlineInputBorder(
                borderSide: BorderSide(
              color: Colors.black,
            )),
            labelText: labelTxt),
        controller: controller ?? TextEditingController(),
      ),
    );
  }
}
