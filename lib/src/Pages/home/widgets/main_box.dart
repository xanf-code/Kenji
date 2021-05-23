import 'package:extended_image/extended_image.dart';
import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:swipe_to/swipe_to.dart';
import 'package:tothemoon/src/Pages/IndividualInsider/individual_main.dart';
import 'package:tothemoon/src/Providers/fav_provider.dart';

import 'body.dart';
import 'footer.dart';
import 'header.dart';

class MainBoxWidget extends StatelessWidget {
  final Future getInsiderInfo;
  final String page;
  const MainBoxWidget({
    Key key,
    this.getInsiderInfo,
    this.page,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getInsiderInfo,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          if (page == "home") {
            return Column(
              children: [
                ExtendedImage.asset(
                  "assets/doggy.gif",
                  height: 200,
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 12.0),
                  child: Text(
                    "🌕🌕🚀🚀",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                    ),
                  ),
                ),
              ],
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        } else {
          return AnimationLimiter(
            child: ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: snapshot.data.result.length as int,
              itemBuilder: (context, index) {
                final info = snapshot.data.result[index];
                return AnimationConfiguration.staggeredList(
                  position: index,
                  duration: const Duration(milliseconds: 375),
                  child: SlideAnimation(
                    horizontalOffset: 50.0,
                    child: GestureDetector(
                      onTap: () {
                        if (page == "home") {
                          HapticFeedback.lightImpact();
                          Get.to(
                            () => IndividualInfoMain(
                              insiderName: info.insiderName as String,
                              newsUrl: info.newsURL as String,
                              symbol: info.ticker as String,
                              companyName: info.companyName as String,
                            ),
                            transition: Transition.native,
                          );
                        }
                      },
                      child: SwipeTo(
                        onRightSwipe: () async {
                          HapticFeedback.lightImpact();
                          Provider.of<FavProvider>(context, listen: false)
                              .addData(
                            info.insiderName as String,
                            info.insiderTitle as String,
                            info.ticker as String,
                            info.date as String,
                            info.companyName as String,
                            info.stockPercent as String,
                            info.tradeType as String,
                            info.tradeQuantity as String,
                            info.tradePrice as String,
                            info.value as String,
                          );
                        },
                        rightSwipeWidget: const Padding(
                          padding: EdgeInsets.only(left: 30.0),
                          child: Icon(
                            FluentSystemIcons.ic_fluent_star_regular,
                            color: Colors.white,
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(
                            left: 14.0,
                            right: 14.0,
                            bottom: 14.0,
                          ),
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.14,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              color: Colors.grey.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Header(
                                  ticker: info.ticker.toString().toUpperCase(),
                                  companyName: info.companyName.toString(),
                                  date: info.date.toString(),
                                ),
                                Body(
                                  ownerName: info.insiderName.toString(),
                                  ownerTitle: info.insiderTitle.toString(),
                                  stocksQuantity: info.tradeQuantity.toString(),
                                  stocksPercentage:
                                      info.stockPercent.toString(),
                                  symbol: info.ticker.toString(),
                                ),
                                Footer(
                                  value: info.value.toString(),
                                  tradeType: info.tradeType.toString(),
                                  singleCost: info.tradePrice.toString(),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        }
      },
    );
  }
}
