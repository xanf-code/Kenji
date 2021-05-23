import 'package:extended_image/extended_image.dart';
import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:swipe_to/swipe_to.dart';
import 'package:tothemoon/src/Pages/home/widgets/body.dart';
import 'package:tothemoon/src/Pages/home/widgets/footer.dart';
import 'package:tothemoon/src/Pages/home/widgets/header.dart';
import 'package:tothemoon/src/constants.dart';
import 'package:tothemoon/src/adapters/fav_adapter.dart';

class FavouritePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Favourites",
          style: GoogleFonts.dmSans(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        automaticallyImplyLeading: false,
        brightness: MediaQuery.of(context).platformBrightness,
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
        child: ValueListenableBuilder(
          valueListenable: Hive.box<Favourites>("favourite").listenable(),
          builder: (context, Box<Favourites> box, _) {
            if (box.values.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ExtendedImage.network(
                      "https://cdn.dribbble.com/users/778834/screenshots/5380379/internet.png",
                    ),
                    Text(
                      "Oops it's empty! :(",
                      style: GoogleFonts.dmSans(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              );
            }
            return Padding(
              padding: const EdgeInsets.only(top: 12.0),
              child: ListView.builder(
                itemCount: box.length,
                itemBuilder: (context, index) {
                  final Favourites favs = box.getAt(index);
                  return SwipeTo(
                    onRightSwipe: () async {
                      HapticFeedback.mediumImpact();
                      await box.deleteAt(index);
                    },
                    rightSwipeWidget: const Padding(
                      padding: EdgeInsets.only(left: 30.0),
                      child: Icon(
                        FluentSystemIcons.ic_fluent_delete_filled,
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
                              ticker: favs.ticker.toString().toUpperCase(),
                              companyName: favs.companyName.toString(),
                              date: favs.date.toString(),
                            ),
                            Body(
                              ownerName: favs.insiderName.toString(),
                              ownerTitle: favs.insiderTitle.toString(),
                              stocksQuantity: favs.quantity.toString(),
                              stocksPercentage: favs.percentage.toString(),
                              symbol: favs.ticker.toString(),
                            ),
                            Footer(
                              value: favs.totalValue.toString(),
                              tradeType: favs.purchaseType.toString(),
                              singleCost: favs.shareValue.toString(),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
