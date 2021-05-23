class InsiderInfoModel {
  int total;
  List<Result> result;

  InsiderInfoModel({this.total, this.result});

  InsiderInfoModel.fromJson(Map<String, dynamic> json) {
    total = json['total'] as int;
    if (json['result'] != null) {
      result = <Result>[];
      json['result'].forEach((v) {
        result.add(Result.fromJson(v as Map<String, dynamic>));
      });
    }
  }
}

class Result {
  String date;
  String ticker;
  String tickerImageUrl;
  String communityURL;
  String newsURL;
  String companyName;
  String insiderName;
  String insiderLink;
  String insiderID;
  String insiderTitle;
  String tradeType;
  String tradePrice;
  String tradeQuantity;
  String stocksOwned;
  String stockPercent;
  String value;

  Result(
      {this.date,
      this.ticker,
      this.tickerImageUrl,
      this.communityURL,
      this.newsURL,
      this.companyName,
      this.insiderName,
      this.insiderLink,
      this.insiderID,
      this.insiderTitle,
      this.tradeType,
      this.tradePrice,
      this.tradeQuantity,
      this.stocksOwned,
      this.stockPercent,
      this.value});

  Result.fromJson(Map<String, dynamic> json) {
    date = json['date'] as String;
    ticker = json['ticker'] as String;
    tickerImageUrl = json['tickerImageUrl'] as String;
    communityURL = json['communityURL'] as String;
    newsURL = json['newsURL'] as String;
    companyName = json['companyName'] as String;
    insiderName = json['insiderName'] as String;
    insiderLink = json['insiderLink'] as String;
    insiderID = json['insiderID'] as String;
    insiderTitle = json['insiderTitle'] as String;
    tradeType = json['tradeType'] as String;
    tradePrice = json['tradePrice'] as String;
    tradeQuantity = json['tradeQuantity'] as String;
    stocksOwned = json['stocksOwned'] as String;
    stockPercent = json['stockPercent'] as String;
    value = json['value'] as String;
  }
}
