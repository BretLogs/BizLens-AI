import 'package:flutter/material.dart';

class AdjustableTextField extends StatelessWidget {
  const AdjustableTextField({super.key, required this.maxLines, required this.txtTitle, required this.message});
  final int maxLines;
  final String txtTitle;
  final TextEditingController message;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const SizedBox(height: 20),
        Text(txtTitle),
        TextField(
          controller: message,
          maxLines: maxLines,
          decoration: const InputDecoration(
            border: OutlineInputBorder(
                borderSide: BorderSide(
              color: Colors.black,
            )),
          ),
        ),
      ],
    );
  }
}
