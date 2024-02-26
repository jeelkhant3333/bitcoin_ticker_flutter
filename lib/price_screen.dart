import 'package:flutter/material.dart';
import 'coin_data.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  List<DropdownMenuItem<String>>? getDropDownItems() {
    List<DropdownMenuItem<String>> dropDownItems = [];
    for (String currency in currenciesList) {
      var newItem = DropdownMenuItem(
        value: currency,
        child: Text(currency),
      );
      dropDownItems.add(newItem);
    }
    return dropDownItems;
  }

  CoinData coinData = CoinData();
  String selectCurrency = 'USD';
  int rate = 0;
  String selectCoin = 'USD';

  Future selectCurrencyName(value) async {
    coinData.currencyName = value;
    selectCoin = await coinData.currencyName;
  }

  Future getcoin(selectedCoinName) async {
    var coin = await coinData.getCoinData(selectedCoinName);

    setState(() {
      double inr = coin['rate'];
      rate = inr.toInt();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Card(
              color: Colors.lightBlueAccent,
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 15.0, horizontal: 28.0),
                child: Text(
                  '1 BTC = $rate $selectCoin',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),

          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: const EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: DropdownButton<String>(
              value: selectCurrency,
              items: getDropDownItems()?.toList(),
              onChanged: (value) {
                setState(() {
                  selectCurrency = value!;
                  selectCurrencyName(selectCurrency);
                  getcoin(selectCurrency);
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
