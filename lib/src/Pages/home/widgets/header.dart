import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as tago;
import 'package:google_fonts/google_fonts.dart';

class Header extends StatelessWidget {
  final String ticker;
  final String companyName;
  final String date;
  const Header({
    Key key,
    this.ticker,
    this.companyName,
    this.date,
  }) : super(key: key);

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
                ticker,
                style: GoogleFonts.dmSans(
                  color: const Color(0xff3979d7),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 12.0),
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.6,
            child: Text(
              companyName,
              style: GoogleFonts.dmSans(
                color: const Color(0xff3979d7),
                fontWeight: FontWeight.bold,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        const Spacer(),
        Padding(
          padding: const EdgeInsets.only(
            top: 10.0,
            right: 12.0,
          ),
          child: Text(
            tago.format(
              DateTime.parse(date),
            ),
            style: GoogleFonts.dmSans(
              color: Colors.white54,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
        ),
      ],
    );
  }
}
