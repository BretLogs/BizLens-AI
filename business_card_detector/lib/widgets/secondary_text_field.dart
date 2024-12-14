import 'package:flutter/material.dart';

class SecondaryTextField extends StatelessWidget {
  const SecondaryTextField({super.key, required this.btnText, required this.btnFunction});

  final String btnText;
  final Function() btnFunction;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: <Widget>[
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                  border: const OutlineInputBorder(
                      borderSide: BorderSide(
                    color: Colors.black,
                  )),
                  labelText: btnText),
            ),
          ),
        ],
      ),
    );
  }
}
