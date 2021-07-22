import 'package:crypto_app/api/crypto_api.dart';
import 'package:crypto_app/models/currency.dart';
import 'package:crypto_app/utils/currency_data_source.dart';
import 'package:flutter/material.dart';

class CurrencyProvider extends ChangeNotifier {
  CurrencyDataSource? currencyDataSource;
  List<Currency> currencies = [];
  CurrencyProvider() {
    loadCurrencies();
  }
  Future loadCurrencies() async {
    final currencies = await CryptoApi().getCurrencies();
    this.currencies = currencies;
    currencyDataSource = CurrencyDataSource(currencies: currencies);
    notifyListeners();
  }
}
