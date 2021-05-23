import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tothemoon/src/Network/Provider/get_requests.dart';
import 'package:tothemoon/src/constants.dart';
import 'package:tothemoon/src/pages/home/widgets/sliver_app_bar.dart';

import 'widgets/main_box.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _loading = false;
  int limit = 10;
  final ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        setState(() {
          _loading = true;
          limit += 10;
        });
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          gradient: pageGradient,
        ),
        child: CustomScrollView(
          physics: const ClampingScrollPhysics(),
          controller: _scrollController,
          shrinkWrap: true,
          slivers: [
            SliverAppBar(
              backgroundColor: Colors.transparent,
              brightness: MediaQuery.of(context).platformBrightness,
              elevation: 0,
              expandedHeight: 120,
              flexibleSpace: const FlexibleSpaceBar(
                background: SliverBar(),
              ),
            ),
            SliverToBoxAdapter(
              child: ListView(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  MainBoxWidget(
                    getInsiderInfo:
                        Provider.of<APIRequests>(context, listen: false)
                            .getInsiderInfo(limit),
                    page: "home",
                  ),
                  if (_loading == true)
                    Padding(
                      padding: const EdgeInsets.only(
                        bottom: 6,
                      ),
                      child: Center(
                        child: Theme(
                          data: ThemeData(
                            cupertinoOverrideTheme: const CupertinoThemeData(
                              brightness: Brightness.dark,
                            ),
                          ),
                          child: const CupertinoActivityIndicator(),
                        ),
                      ),
                    )
                  else
                    const SizedBox.shrink(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
