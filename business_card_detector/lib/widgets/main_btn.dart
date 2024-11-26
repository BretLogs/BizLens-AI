import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MainBtn extends StatelessWidget {
  const MainBtn({super.key, required this.btnText});
  final String btnText;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: const ButtonStyle(
        backgroundColor: WidgetStatePropertyAll<Color>(
          Color(0xff428DEB),
        ),
        shape: WidgetStatePropertyAll<OutlinedBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(12),
            ),
          ),
        ),
      ),
      onPressed: () {},
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: SizedBox(
          width: double.infinity,
          child: Center(
            child: Text(
              btnText,
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 20,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
