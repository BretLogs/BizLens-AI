import 'package:flutter/material.dart';

class MainIconBtn extends StatelessWidget {
  const MainIconBtn({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: 60,
      decoration: BoxDecoration(
        color: Colors.blue[400],
        borderRadius: BorderRadius.circular(12),
      ),
      child: IconButton(
        onPressed: () {},
        icon: const Icon(Icons.send_rounded),
        color: Colors.white,
        iconSize: 32,
      ),
    );
  }
}
