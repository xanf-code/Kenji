import 'package:extended_image/extended_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sparkline/flutter_sparkline.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:tothemoon/src/Network/Provider/get_requests.dart';
import 'package:tothemoon/src/Models/charts_model.dart';

import '../individual_main.dart';

class ChartWidget extends StatefulWidget {
  const ChartWidget({
    Key key,
    @required this.widget,
  }) : super(key: key);

  final IndividualInfoMain widget;

  @override
  _ChartWidgetState createState() => _ChartWidgetState();
}

class _ChartWidgetState extends State<ChartWidget> {
  String frequency = "1d";
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FutureBuilder<ChartModel>(
          future: Provider.of<APIRequests>(context, listen: false)
              .getCharts(widget.widget.symbol, frequency),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return SizedBox(
                height: 172,
                child: Center(
                  child: ExtendedImage.asset(
                    "assets/loader.gif",
                    color: Colors.white,
                    height: 80,
                  ),
                ),
              );
            }
            final List<double> a =
                snapshot.data.chart.result[0].indicators.quote[0].open;
            final List<double> b = [
              for (var i in a)
                if (i != null) i
            ];
            return Padding(
              padding: const EdgeInsets.only(
                left: 20.0,
                right: 20,
                bottom: 22,
              ),
              child: Container(
                color: Colors.transparent,
                height: 150,
                child: Sparkline(
                  pointsMode: PointsMode.last,
                  lineGradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.purple[800],
                      Colors.purple[200],
                    ],
                  ),
                  pointColor: Colors.white,
                  fillMode: FillMode.below,
                  fillGradient: const LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Color(0xFF07041b),
                    ],
                  ),
                  data: b,
                ),
              ),
            );
          },
        ),
        Padding(
          padding: const EdgeInsets.only(
            right: 12.0,
            bottom: 8,
            left: 22,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                "Frequency",
                style: GoogleFonts.dmSans(
                  color: Colors.blueAccent,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              TextButton(
                onPressed: () {
                  setState(() {
                    frequency = "1d";
                  });
                },
                child: Text("1D"),
              ),
              TextButton(
                onPressed: () {
                  setState(() {
                    frequency = "5d";
                  });
                },
                child: Text("5D"),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
