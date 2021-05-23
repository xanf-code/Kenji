import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:tothemoon/src/Models/insider_api.dart';
import 'package:tothemoon/src/Models/trending_api.dart';
import 'package:http/http.dart' as http;
import 'package:tothemoon/urls.dart';
import 'package:tothemoon/src/Models/stocks_info.dart';
import 'package:tothemoon/src/Models/individual_insider.dart';
import 'package:tothemoon/src/Models/trending_crypto.dart';
import 'package:tothemoon/src/Models/insider_news_model.dart';
import 'package:tothemoon/src/Models/community_model.dart';
import 'package:tothemoon/src/Models/charts_model.dart';

class APIRequests extends ChangeNotifier {
  InsiderInfoModel insiderInfoModel;
  TrendingModel trendingModel;
  StocksInfo stocksInfo;
  IndividualInsiderInfo individualInsiderInfo;
  TrendingCryptoModel trendingCrypto;
  InsiderNewsModel insiderNewsInfo;
  CommunityModel communityModel;
  ChartModel chartModel;

  AllURL allURL = AllURL();
  Map<String, String> headers = {
    'accept':
        'text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.9',
    'referer': 'https://www.google.com/',
    'sec-fetch-dest': 'empty',
    'sec-fetch-mode': 'cors',
    'sec-fetch-site': 'same-site',
    'user-agent':
        'Mozilla/5.0 (Windows NT 10.0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/81.0.4044.100 Safari/537.36',
  };

  // ignore: missing_return
  Future<InsiderInfoModel> getInsiderInfo(int limit) async {
    try {
      final url = Uri.parse(
          'https://insidershibu.herokuapp.com/scrapedata/getInsiderData?limit=$limit');
      final response = await http.get(url, headers: headers);
      if (response.statusCode == 200) {
        insiderInfoModel = InsiderInfoModel.fromJson(
            jsonDecode(response.body) as Map<String, dynamic>);
        notifyListeners();
        return insiderInfoModel;
      }
    } catch (error) {
      debugPrint(error.toString());
    }
  }

  // ignore: missing_return
  Future<TrendingModel> getTrendingData() async {
    try {
      final url = Uri.parse(allURL.trendingURL);
      final response = await http.get(url, headers: headers);
      if (response.statusCode == 200) {
        trendingModel = TrendingModel.fromJson(
            jsonDecode(response.body) as Map<String, dynamic>);
        notifyListeners();
        return trendingModel;
      }
    } catch (error) {
      debugPrint(error.toString());
    }
  }

  // ignore: missing_return
  Future<StocksInfo> getStocksInfo(String symbol) async {
    try {
      final url = Uri.parse("https://ql.stocktwits.com/batch?symbols=$symbol");
      final response = await http.get(url, headers: headers);
      if (response.statusCode == 200) {
        stocksInfo = StocksInfo.fromJson(
            jsonDecode(response.body) as Map<String, dynamic>, symbol);
        notifyListeners();
        return stocksInfo;
      }
    } catch (error) {
      debugPrint(error.toString());
    }
  }

  // ignore: missing_return
  Future<IndividualInsiderInfo> getIndividualInsiderDetails(
      String insiderName) async {
    try {
      final url = Uri.parse(
          "https://insidershibu.herokuapp.com/scrapedata/getInsiderData/$insiderName");
      final response = await http.get(url, headers: headers);
      if (response.statusCode == 200) {
        individualInsiderInfo = IndividualInsiderInfo.fromJson(
            jsonDecode(response.body) as Map<String, dynamic>);
        notifyListeners();
        return individualInsiderInfo;
      }
    } catch (error) {
      debugPrint(error.toString());
    }
  }

  // ignore: missing_return
  Future<TrendingCryptoModel> getTrendingCrypto() async {
    try {
      final url =
          Uri.parse("https://api.coinmarketcap.com/data-api/v3/topsearch/rank");
      final response = await http.get(url, headers: headers);
      if (response.statusCode == 200) {
        trendingCrypto = TrendingCryptoModel.fromJson(
            jsonDecode(response.body) as Map<String, dynamic>);
        notifyListeners();
        return trendingCrypto;
      }
    } catch (error) {
      debugPrint(error.toString());
    }
  }

  // ignore: missing_return
  Future<InsiderNewsModel> getInsiderNews(String newsUrl) async {
    try {
      final url = Uri.parse(
          "${newsUrl.replaceAll("?page[size]=5", "")}?filter[category]=news_card");
      final response = await http.get(url, headers: headers);
      if (response.statusCode == 200) {
        insiderNewsInfo = InsiderNewsModel.fromJson(
            jsonDecode(response.body) as Map<String, dynamic>);
        notifyListeners();
        return insiderNewsInfo;
      }
    } catch (error) {
      debugPrint(error.toString());
    }
  }

  // ignore: missing_return
  Future<CommunityModel> getCommunityFeed(String symbol, String type) async {
    try {
      final url = Uri.parse(
          "https://api.stocktwits.com/api/2/streams/symbol/$symbol.json?filter=$type&limit=20");
      final response = await http.get(url, headers: headers);
      if (response.statusCode == 200) {
        communityModel = CommunityModel.fromJson(
            jsonDecode(response.body) as Map<String, dynamic>);
        notifyListeners();
        return communityModel;
      }
    } catch (error) {
      debugPrint(error.toString());
    }
  }

  // ignore: missing_return
  Future<ChartModel> getCharts(String symbol, String frequency) async {
    try {
      final url = Uri.parse(
          "https://query1.finance.yahoo.com/v8/finance/chart/$symbol?region=US&lang=en-US&includePrePost=false&interval=2m&useYfid=true&range=$frequency&corsDomain=finance.yahoo.com&.tsrc=finance");
      final response = await http.get(url, headers: headers);
      if (response.statusCode == 200) {
        chartModel = ChartModel.fromJson(
          jsonDecode(response.body) as Map<String, dynamic>,
        );
        notifyListeners();
        return chartModel;
      }
    } catch (error) {
      debugPrint(error.toString());
    }
  }
}
