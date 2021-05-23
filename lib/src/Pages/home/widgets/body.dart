import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class Body extends StatelessWidget {
  final String ownerName;
  final String ownerTitle;
  final String stocksQuantity;
  final String stocksPercentage;
  final String symbol;
  const Body(
      {Key key,
      this.ownerName,
      this.ownerTitle,
      this.stocksQuantity,
      this.stocksPercentage,
      this.symbol})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 12.0,
        left: 14.0,
        right: 12.0,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.5,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  ownerName,
                  style: GoogleFonts.dmSans(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(
                  height: 4,
                ),
                Text(
                  ownerTitle,
                  style: GoogleFonts.dmSans(
                    color: const Color(0xff3979d7),
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          const Spacer(),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              if (stocksQuantity.toString().contains("-"))
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      FontAwesomeIcons.suitcase,
                      color: Colors.red,
                      size: 12,
                    ),
                    const SizedBox(
                      width: 6,
                    ),
                    Text(
                      stocksQuantity,
                      style: GoogleFonts.dmSans(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    const Icon(
                      FontAwesomeIcons.caretDown,
                      color: Colors.red,
                    ),
                  ],
                )
              else
                Row(
                  children: [
                    const Icon(
                      FontAwesomeIcons.suitcase,
                      color: Colors.green,
                      size: 12,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      stocksQuantity,
                      style: GoogleFonts.dmSans(
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    const Icon(
                      FontAwesomeIcons.caretUp,
                      color: Colors.green,
                    ),
                  ],
                ),
              if (stocksPercentage.toString().contains("-"))
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      FontAwesomeIcons.percentage,
                      color: Colors.red,
                      size: 12,
                    ),
                    const SizedBox(
                      width: 6,
                    ),
                    Text(
                      stocksPercentage,
                      style: GoogleFonts.dmSans(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    const Icon(
                      FontAwesomeIcons.caretDown,
                      color: Colors.red,
                    ),
                  ],
                )
              else
                Row(
                  children: [
                    const Icon(
                      FontAwesomeIcons.percentage,
                      color: Colors.green,
                      size: 12,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      stocksPercentage,
                      style: GoogleFonts.dmSans(
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    const Icon(
                      FontAwesomeIcons.caretUp,
                      color: Colors.green,
                    ),
                  ],
                ),
            ],
          ),
        ],
      ),
    );
  }
}
