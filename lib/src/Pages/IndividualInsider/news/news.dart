import 'package:extended_image/extended_image.dart';
import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';
import 'package:tothemoon/src/Network/Provider/get_requests.dart';
import 'package:tothemoon/src/Models/insider_news_model.dart';
import 'package:timeago/timeago.dart' as tago;
import 'package:tothemoon/src/constants.dart';
import 'package:url_launcher/url_launcher.dart';

class IndividualNews extends StatefulWidget {
  final String newsUrl;

  const IndividualNews({Key key, this.newsUrl}) : super(key: key);
  @override
  _IndividualNewsState createState() => _IndividualNewsState();
}

class _IndividualNewsState extends State<IndividualNews>
    with AutomaticKeepAliveClientMixin<IndividualNews> {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return FutureBuilder<InsiderNewsModel>(
      future: Provider.of<APIRequests>(context, listen: false)
          .getInsiderNews(widget.newsUrl),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator.adaptive(),
          );
        }
        return ListView.separated(
          separatorBuilder: (context, index) {
            return Divider(
              color: Colors.grey.withOpacity(0.1),
            );
          },
          physics: const BouncingScrollPhysics(),
          itemCount: snapshot.data.data.length,
          itemBuilder: (context, index) {
            final news = snapshot.data.data[index];
            return GestureDetector(
              onTap: () {
                HapticFeedback.lightImpact();
                Get.to(
                  () => WebviewScaffold(
                    url: '${"https://seekingalpha.com"}${news.links.self}',
                    appBar: AppBar(
                      brightness: MediaQuery.of(context).platformBrightness,
                      automaticallyImplyLeading: false,
                      title: Text(
                        news.attributes.title,
                        style: GoogleFonts.dmSans(
                          color: Colors.white,
                        ),
                      ),
                      backgroundColor: Colors.black,
                      actions: [
                        GestureDetector(
                          onTap: () {
                            HapticFeedback.mediumImpact();
                            Share.share(
                              "${"https://seekingalpha.com"}${news.links.self}",
                            );
                          },
                          child: const Padding(
                            padding: EdgeInsets.only(right: 12.0),
                            child: Icon(
                              FluentSystemIcons.ic_fluent_share_regular,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            HapticFeedback.mediumImpact();
                            launch(
                              "${"https://seekingalpha.com"}${news.links.self}",
                            );
                          },
                          child: const Padding(
                            padding: EdgeInsets.only(right: 16.0),
                            child: Icon(
                              FluentSystemIcons.ic_fluent_globe_regular,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                    hidden: true,
                    initialChild: Container(
                      decoration: const BoxDecoration(
                        gradient: pageGradient,
                      ),
                      child: const Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                  ),
                );
              },
              child: NewsWidget(news: news),
            );
          },
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class NewsWidget extends StatelessWidget {
  const NewsWidget({
    Key key,
    @required this.news,
  }) : super(key: key);

  final Data news;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 14.0,
        right: 14,
        bottom: 8,
        top: 8,
      ),
      child: Row(
        children: [
          if (news.type == "filing")
            ExtendedImage.network(
              "https://upload.wikimedia.org/wikipedia/commons/thumb/9/94/Filing_cabinet_icon.svg/1200px-Filing_cabinet_icon.svg.png",
              width: 30,
            ),
          if (news.type == "news")
            ExtendedImage.network(
              "https://upload.wikimedia.org/wikipedia/commons/thumb/1/11/Newspaper_Cover.svg/768px-Newspaper_Cover.svg.png",
              width: 30,
            ),
          if (news.type == "transcript")
            ExtendedImage.network(
              "https://cdn1.iconfinder.com/data/icons/university-indigo-vol-2/256/Transcript-512.png",
              width: 30,
            ),
          if (news.type == "earningsSlide")
            ExtendedImage.network(
              "https://cdn.iconscout.com/icon/premium/png-256-thumb/earning-3169098-2644745.png",
              width: 30,
            ),
          Flexible(
            child: Padding(
              padding: const EdgeInsets.only(left: 12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    news.attributes.title,
                    style: GoogleFonts.dmSans(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    tago.format(
                      DateTime.parse(news.attributes.publishOn),
                    ),
                    style: GoogleFonts.dmSans(
                      color: Colors.white30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
