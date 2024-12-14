import 'package:flutter/material.dart';

class AdjustableTextField extends StatelessWidget {
  const AdjustableTextField({super.key, required this.maxLines, required this.txt});
  final int maxLines;
  final String txt;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const SizedBox(height: 20),
        Text(txt),
        TextField(
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
