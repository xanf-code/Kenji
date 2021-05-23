import 'package:extended_image/extended_image.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:tothemoon/src/Models/trending_crypto.dart';
import 'package:tothemoon/src/Network/Provider/get_requests.dart';
import 'package:url_launcher/url_launcher.dart';

class TrendingCrypto extends StatefulWidget {
  @override
  _TrendingCryptoState createState() => _TrendingCryptoState();
}

class _TrendingCryptoState extends State<TrendingCrypto>
    with AutomaticKeepAliveClientMixin {
  final RefreshController _refreshController = RefreshController();

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return FutureBuilder<TrendingCryptoModel>(
      future:
          Provider.of<APIRequests>(context, listen: false).getTrendingCrypto(),
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
          child: ListView.separated(
            shrinkWrap: true,
            separatorBuilder: (BuildContext context, int index) {
              return Divider(
                color: Colors.grey.withOpacity(0.2),
                indent: 20,
                endIndent: 20,
              );
            },
            physics: const BouncingScrollPhysics(),
            itemCount: snapshot.data.data.cryptoTopSearchRanks.length,
            itemBuilder: (context, index) {
              final data = snapshot.data.data.cryptoTopSearchRanks[index];
              return Padding(
                padding: const EdgeInsets.only(
                  bottom: 4.0,
                  left: 12,
                  right: 12,
                ),
                child: FlipCard(
                  direction: FlipDirection.VERTICAL,
                  front: MainBodyWidget(
                    data: data,
                    index: index,
                  ),
                  back: BackBodyWidget(data: data),
                ),
              );
            },
          ),
        );
      },
    );
  }

  void _onRefresh(BuildContext context) async {
    await Future.delayed(const Duration(milliseconds: 1000));
    Provider.of<APIRequests>(context, listen: false).getTrendingCrypto();
    setState(() {});
    _refreshController.refreshCompleted();
  }

  @override
  bool get wantKeepAlive => true;
}

class BackBodyWidget extends StatelessWidget {
  const BackBodyWidget({
    Key key,
    @required this.data,
  }) : super(key: key);

  final CryptoTopSearchRanks data;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 20.0,
        right: 20,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: 12.0,
              left: 14,
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
                  // bottom: 4.0,
                  // top: 4.0,
                ),
                child: Text(
                  "CRYPTO",
                  style: GoogleFonts.dmSans(
                    color: const Color(0xff3979d7),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 8.0,
              left: 6,
            ),
            child: Text(
              "\$${data.priceChange.price.toString()}",
              style: GoogleFonts.dmSans(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 26,
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              HapticFeedback.mediumImpact();
              launch("https://coinmarketcap.com/currencies/${data.slug}");
            },
            child: Padding(
              padding: const EdgeInsets.only(
                top: 6.0,
                left: 12,
              ),
              child: ExtendedImage.network(
                "https://user-images.githubusercontent.com/168240/39501128-e66e2a18-4d6d-11e8-9e16-88655102da6c.png",
                height: 15,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MainBodyWidget extends StatelessWidget {
  const MainBodyWidget({
    Key key,
    @required this.data,
    this.index,
  }) : super(key: key);
  final int index;
  final CryptoTopSearchRanks data;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.grey.withOpacity(0.3),
          ),
          child: Padding(
            padding: const EdgeInsets.all(6.0),
            child: Center(
              child: Text(
                (index + 1).toString(),
                style: GoogleFonts.dmSans(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ),
        Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    top: 12.0,
                    left: 14,
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
                        data.symbol,
                        style: GoogleFonts.dmSans(
                          color: const Color(0xff3979d7),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 8,
                    left: 14,
                    right: 12,
                  ),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.6,
                    child: Text(
                      data.name,
                      style: GoogleFonts.dmSans(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    HapticFeedback.mediumImpact();
                    launch("https://coinmarketcap.com/currencies/${data.slug}");
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(
                      top: 6.0,
                      left: 20,
                    ),
                    child: ExtendedImage.network(
                      "https://user-images.githubusercontent.com/168240/39501128-e66e2a18-4d6d-11e8-9e16-88655102da6c.png",
                      height: 15,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            ClipOval(
              child: CircleAvatar(
                backgroundColor: Colors.transparent,
                child: ExtendedImage.network(
                  "https://s2.coinmarketcap.com/static/img/coins/64x64/${data.id}.png",
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
