import 'package:http/http.dart' as http;
import 'dart:convert';

const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

class CoinData {
  String currencyName = 'INR';
  String cryptoName = 'BTC';
  Future getCoinData(String coinName) async {
    currencyName = coinName;
    try {
      http.Response response = await http.get(Uri.parse(
          'https://rest.coinapi.io/v1/exchangerate/$cryptoName/$currencyName?apikey=3B473141-188D-48BB-B2BA-301AB88D2748'));
      String data = response.body;
      return jsonDecode(data);
    } catch (e) {
      print(e);
    }
  }
}
