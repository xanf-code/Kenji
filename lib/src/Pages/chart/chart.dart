import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tothemoon/src/Pages/chart/trending_page.dart';
import 'package:tothemoon/src/constants.dart';
import 'package:tothemoon/src/Pages/chart/crypto_trending.dart';

class ChartPage extends StatefulWidget {
  const ChartPage({Key key}) : super(key: key);

  @override
  _ChartPageState createState() => _ChartPageState();
}

class _ChartPageState extends State<ChartPage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: pageGradient,
        ),
        child: Padding(
          padding: const EdgeInsets.only(
            top: 20.0,
            left: 12,
            right: 12,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  top: 30.0,
                  left: 12,
                  right: 12,
                  bottom: 12,
                ),
                child: Center(
                  child: TabBar(
                    controller: _tabController,
                    indicator: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        20.0,
                      ),
                      color: const Color(0xFF1f1e25),
                    ),
                    tabs: [
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 12.0,
                          bottom: 12,
                        ),
                        child: Text(
                          "Equity",
                          style: GoogleFonts.dmSans(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 12.0,
                          bottom: 12,
                        ),
                        child: Text(
                          "Crypto",
                          style: GoogleFonts.dmSans(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: TabBarView(
                  physics: const BouncingScrollPhysics(),
                  controller: _tabController,
                  children: [
                    Trending(),
                    TrendingCrypto(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
