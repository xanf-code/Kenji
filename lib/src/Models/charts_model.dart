class ChartModel {
  Chart chart;

  ChartModel({this.chart});

  ChartModel.fromJson(Map<String, dynamic> json) {
    chart = json['chart'] != null
        ? Chart.fromJson(json['chart'] as Map<String, dynamic>)
        : null;
  }
}

class Chart {
  List<Result> result;

  Chart({this.result});

  Chart.fromJson(Map<String, dynamic> json) {
    if (json['result'] != null) {
      result = <Result>[];
      json['result'].forEach((v) {
        result.add(Result.fromJson(v as Map<String, dynamic>));
      });
    }
  }
}

class Result {
  Meta meta;
  Indicators indicators;

  Result({this.meta, this.indicators});

  Result.fromJson(Map<String, dynamic> json) {
    meta = json['meta'] != null
        ? Meta.fromJson(json['meta'] as Map<String, dynamic>)
        : null;
    indicators = json['indicators'] != null
        ? Indicators.fromJson(json['indicators'] as Map<String, dynamic>)
        : null;
  }
}

class Meta {
  String currency;
  String symbol;
  String exchangeName;
  String instrumentType;

  Meta({this.currency, this.symbol, this.exchangeName, this.instrumentType});

  Meta.fromJson(Map<String, dynamic> json) {
    currency = json['currency'] as String;
    symbol = json['symbol'] as String;
    exchangeName = json['exchangeName'] as String;
    instrumentType = json['instrumentType'] as String;
  }
}

class Indicators {
  List<Quote> quote;

  Indicators({this.quote});

  Indicators.fromJson(Map<String, dynamic> json) {
    if (json['quote'] != null) {
      quote = <Quote>[];
      json['quote'].forEach((v) {
        quote.add(Quote.fromJson(v as Map<String, dynamic>));
      });
    }
  }
}

class Quote {
  List<double> open;

  Quote({this.open});

  Quote.fromJson(Map<String, dynamic> json) {
    open = json['open'].cast<double>() as List<double>;
  }
}
