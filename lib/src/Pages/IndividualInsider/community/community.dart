import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:tothemoon/src/Models/community_model.dart';
import 'package:tothemoon/src/Network/Provider/get_requests.dart';
import 'package:url_launcher/url_launcher.dart';
import './Widgets/tweet_box.dart';

class IndividualCommunity extends StatefulWidget {
  final String symbol;

  const IndividualCommunity({Key key, this.symbol}) : super(key: key);
  @override
  _IndividualCommunityState createState() => _IndividualCommunityState();
}

class _IndividualCommunityState extends State<IndividualCommunity>
    with AutomaticKeepAliveClientMixin<IndividualCommunity> {
  final RefreshController _refreshController = RefreshController();
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return FutureBuilder<CommunityModel>(
      future: Provider.of<APIRequests>(context, listen: false)
          .getCommunityFeed(widget.symbol, "All"),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return SmartRefresher(
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
            physics: const BouncingScrollPhysics(),
            children: [
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                separatorBuilder: (context, index) {
                  return Divider(
                    color: Colors.grey.withOpacity(0.4),
                    indent: 20,
                    endIndent: 20,
                  );
                },
                itemCount: snapshot.data.messages.length,
                itemBuilder: (context, index) {
                  final community = snapshot.data.messages[index];
                  return GestureDetector(
                    onTap: () {
                      HapticFeedback.mediumImpact();
                      launch(community.links[0].url);
                    },
                    child: TweetBox(community: community),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _onRefresh(BuildContext context) async {
    await Future.delayed(const Duration(milliseconds: 1000));
    Provider.of<APIRequests>(context, listen: false)
        .getCommunityFeed(widget.symbol, "All");
    setState(() {});
    _refreshController.refreshCompleted();
  }

  @override
  bool get wantKeepAlive => true;
}
