import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:tothemoon/src/adapters/fav_adapter.dart';

class FavProvider extends ChangeNotifier {
  void addData(
    String insiderName,
    String insiderTitle,
    String ticker,
    String date,
    String companyName,
    String percentage,
    String purchaseType,
    String quantity,
    String shareValue,
    String totalValue,
  ) {
    final Box<Favourites> favBox = Hive.box("favourite");
    favBox.add(
      Favourites(
        insiderName: insiderName,
        insiderTitle: insiderTitle,
        ticker: ticker,
        date: date,
        companyName: companyName,
        percentage: percentage,
        purchaseType: purchaseType,
        quantity: quantity,
        shareValue: shareValue,
        totalValue: totalValue,
      ),
    );
  }
}
