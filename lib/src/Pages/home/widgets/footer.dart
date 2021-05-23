import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class Footer extends StatelessWidget {
  final String value;
  final String tradeType;
  final String singleCost;
  const Footer({Key key, this.value, this.tradeType, this.singleCost})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(
            top: 12.0,
            left: 12,
            right: 12,
          ),
          child: Container(
            decoration: BoxDecoration(
              color: const Color(0xFF253348),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Padding(
              padding: const EdgeInsets.only(
                left: 8.0,
                right: 8.0,
                bottom: 4.0,
                top: 4.0,
              ),
              child: Text(
                tradeType,
                style: GoogleFonts.dmSans(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 12.0),
          child: Text(
            singleCost,
            style: GoogleFonts.dmSans(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const Spacer(),
        Padding(
          padding: const EdgeInsets.only(
            top: 12.0,
            right: 6,
          ),
          child: Icon(
            FontAwesomeIcons.moneyBillWave,
            color: value.contains('+') ? Colors.green : Colors.red,
            size: 16,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            left: 4,
            top: 12.0,
            right: 12,
          ),
          child: Container(
            decoration: BoxDecoration(
              color: const Color(0xFF253348),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Padding(
              padding: const EdgeInsets.only(
                left: 8.0,
                right: 8.0,
                bottom: 4.0,
                top: 4.0,
              ),
              child: Text(
                value,
                style: GoogleFonts.dmSans(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
