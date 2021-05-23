class TrendingCryptoModel {
  Data data;

  TrendingCryptoModel({this.data});

  TrendingCryptoModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null
        ? Data.fromJson(json['data'] as Map<String, dynamic>)
        : null;
  }
}

class Data {
  List<CryptoTopSearchRanks> cryptoTopSearchRanks;

  Data({this.cryptoTopSearchRanks});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['cryptoTopSearchRanks'] != null) {
      cryptoTopSearchRanks = <CryptoTopSearchRanks>[];
      json['cryptoTopSearchRanks'].forEach((v) {
        cryptoTopSearchRanks
            .add(CryptoTopSearchRanks.fromJson(v as Map<String, dynamic>));
      });
    }
  }
}

class CryptoTopSearchRanks {
  int id;
  int dataType;
  String name;
  String symbol;
  String slug;
  int rank;
  String status;
  double marketCap;
  PriceChange priceChange;

  CryptoTopSearchRanks(
      {this.id,
      this.dataType,
      this.name,
      this.symbol,
      this.slug,
      this.rank,
      this.status,
      this.marketCap,
      this.priceChange});

  CryptoTopSearchRanks.fromJson(Map<String, dynamic> json) {
    id = json['id'] as int;
    dataType = json['dataType'] as int;
    name = json['name'] as String;
    symbol = json['symbol'] as String;
    slug = json['slug'] as String;
    rank = json['rank'] as int;
    status = json['status'] as String;
    marketCap = json['marketCap'] as double;
    priceChange = json['priceChange'] != null
        ? PriceChange.fromJson(json['priceChange'] as Map<String, dynamic>)
        : null;
  }
}

class PriceChange {
  double price;
  double priceChange24h;
  double volume24h;

  PriceChange({this.price, this.priceChange24h, this.volume24h});

  PriceChange.fromJson(Map<String, dynamic> json) {
    price = json['price'] as double;
    priceChange24h = json['priceChange24h'] as double;
    volume24h = json['volume24h'] as double;
  }
}
