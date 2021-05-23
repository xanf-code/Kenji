class StocksInfo {
  IndInfo info;

  StocksInfo({this.info});

  StocksInfo.fromJson(Map<String, dynamic> json, String symbol) {
    info = json[symbol] != null
        ? IndInfo.fromJson(json[symbol] as Map<String, dynamic>)
        : null;
  }
}

class IndInfo {
  double extendedHoursChange;
  double open;
  double last;
  double extendedHoursPrice;
  String symbol;
  double previousClose;
  double volume;
  String lastSize;
  double low;
  double percentChange;
  double high;
  double change;
  String type;
  IndInfo(
      {this.extendedHoursChange,
      this.open,
      this.last,
      this.extendedHoursPrice,
      this.symbol,
      this.previousClose,
      this.volume,
      this.lastSize,
      this.low,
      this.percentChange,
      this.high,
      this.change,
      this.type});

  IndInfo.fromJson(Map<String, dynamic> json) {
    extendedHoursChange = json['ExtendedHoursChange'] as double;
    open = json['Open'] as double;
    last = json['Last'] as double;
    extendedHoursPrice = json['ExtendedHoursPrice'] as double;
    symbol = json['Symbol'] as String;
    previousClose = json['PreviousClose'] as double;
    volume = json['Volume'] as double;
    lastSize = json['LastSize'] as String;
    low = json['Low'] as double;
    percentChange = json['PercentChange'] as double;
    high = json['High'] as double;
    change = json['Change'] as double;
    type = json['Type'] as String;
  }
}
