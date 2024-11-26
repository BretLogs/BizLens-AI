import 'package:business_card_detector/capture_img.dart';
import 'package:business_card_detector/widgets/main_btn.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Text(
                      'BizLens',
                      style: GoogleFonts.pixelifySans(fontSize: 28),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'AI',
                      style: GoogleFonts.pixelifySans(
                        color: const Color(0xff0067EB),
                        fontSize: 28,
                      ),
                    ),
                  ],
                ),
                Column(
                  children: <Widget>[
                    SvgPicture.asset(
                      'assets/images/Landing Page Image.svg',
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 32,
                      ),
                      child: Text(
                        'Transform the way you connect with BizLens AI',
                        style: GoogleFonts.lexend(
                          fontSize: 20,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
                MainBtn(
                  btnText: 'GET STARTED',
                  btnFunction: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (BuildContext context) => const CaptureImg()),
                    );
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
