import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:tothemoon/src/Network/Provider/get_requests.dart';
import 'package:tothemoon/src/Pages/home/widgets/main_box.dart';
import 'package:tothemoon/src/constants.dart';

import 'community/community.dart';
import 'news/news.dart';
import 'widgets/news_widget.dart';

class IndividualInfoMain extends StatefulWidget {
  final String insiderName;
  final String newsUrl;
  final String symbol;
  final String companyName;
  const IndividualInfoMain(
      {Key key, this.insiderName, this.newsUrl, this.symbol, this.companyName})
      : super(key: key);

  @override
  _IndividualInfoMainState createState() => _IndividualInfoMainState();
}

class _IndividualInfoMainState extends State<IndividualInfoMain>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  final RefreshController _refreshController = RefreshController();

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
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
      appBar: AppBar(
        brightness: MediaQuery.platformBrightnessOf(context),
        automaticallyImplyLeading: false,
        title: Text(
          widget.insiderName,
          style: GoogleFonts.dmSans(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: pageGradient,
          ),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: pageGradient,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                top: 20.0,
                left: 12,
                right: 12,
                bottom: 20,
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
                        "Activity",
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
                        "News",
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
                        "Community",
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
                  SmartRefresher(
                    header: ClassicHeader(
                      refreshingText: "Updating Data...",
                      completeText: "Updated",
                      refreshingIcon: Theme(
                        data: ThemeData(
                          cupertinoOverrideTheme: const CupertinoThemeData(
                            brightness: Brightness.dark,
                          ),
                        ),
                        child: const CupertinoActivityIndicator(),
                      ),
                    ),
                    controller: _refreshController,
                    onRefresh: () => _onRefresh(context),
                    child: ListView(
                      shrinkWrap: true,
                      children: [
                        ChartHeader(widget: widget),
                        ChartWidget(widget: widget),
                        MainBoxWidget(
                          getInsiderInfo: Provider.of<APIRequests>(context,
                                  listen: false)
                              .getIndividualInsiderDetails(widget.insiderName),
                          page: "individual",
                        ),
                      ],
                    ),
                  ),
                  IndividualNews(
                    newsUrl: widget.newsUrl,
                  ),
                  IndividualCommunity(
                    symbol: widget.symbol,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onRefresh(BuildContext context) async {
    await Future.delayed(const Duration(milliseconds: 1000));
    Provider.of<APIRequests>(context, listen: false)
        .getCharts(widget.symbol, "1d");
    setState(() {});
    _refreshController.refreshCompleted();
  }
}

class ChartHeader extends StatelessWidget {
  const ChartHeader({
    Key key,
    @required this.widget,
  }) : super(key: key);

  final IndividualInfoMain widget;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 24.0,
        bottom: 16,
      ),
      child: Row(
        children: [
          Container(
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
                widget.symbol,
                style: GoogleFonts.dmSans(
                  color: const Color(0xff3979d7),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.6,
            child: Text(
              widget.companyName,
              style: GoogleFonts.dmSans(
                color: const Color(0xff3979d7),
                fontWeight: FontWeight.bold,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
