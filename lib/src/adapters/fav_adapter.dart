import 'package:hive/hive.dart';

part 'fav_adapter.g.dart';

@HiveType(typeId: 1)
class Favourites {
  @HiveField(0)
  String ticker;

  @HiveField(1)
  String companyName;

  @HiveField(3)
  String date;

  @HiveField(4)
  String insiderName;

  @HiveField(5)
  String insiderTitle;

  @HiveField(6)
  String purchaseType;

  @HiveField(7)
  String shareValue;

  @HiveField(8)
  String quantity;

  @HiveField(9)
  String percentage;

  @HiveField(10)
  String totalValue;

  Favourites({
    this.insiderName,
    this.ticker,
    this.insiderTitle,
    this.date,
    this.companyName,
    this.percentage,
    this.purchaseType,
    this.quantity,
    this.shareValue,
    this.totalValue,
  });
}
