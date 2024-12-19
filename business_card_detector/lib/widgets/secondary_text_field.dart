import 'package:flutter/material.dart';

class SecondaryTextField extends StatelessWidget {
  const SecondaryTextField({super.key, required this.btnText, required this.btnFunction, this.controller});

  final String btnText;
  final Function() btnFunction;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: <Widget>[
          Expanded(
            child: TextField(
              controller: controller,
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
