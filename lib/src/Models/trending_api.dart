class TrendingModel {
  List<Symbols> symbols;

  TrendingModel({this.symbols});

  TrendingModel.fromJson(Map<String, dynamic> json) {
    if (json['symbols'] != null) {
      symbols = <Symbols>[];
      json['symbols'].forEach((v) {
        symbols.add(Symbols.fromJson(v as Map<String, dynamic>));
      });
    }
  }
}

class Symbols {
  int id;
  String symbol;
  String title;

  Symbols({
    this.id,
    this.symbol,
    this.title,
  });

  Symbols.fromJson(Map<String, dynamic> json) {
    id = json['id'] as int;
    symbol = json['symbol'] as String;
    title = json['title'] as String;
  }
}
