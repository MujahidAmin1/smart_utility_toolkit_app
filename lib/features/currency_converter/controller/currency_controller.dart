import 'package:flutter/material.dart';

class CurrencyController extends ChangeNotifier {
  static const Map<String, double> _ratesToUsd = {
    'USD': 1.0,
    'NGN': 1388.03,
    'EUR': 0.8544,
    'GBP': 0.7513,
    'CNY': 6.8741,
  };

  static const Map<String, String> currencyNames = {
    'USD': 'US Dollar',
    'NGN': 'Nigerian Naira',
    'EUR': 'Euro',
    'GBP': 'British Pound',
    'CNY': 'Chinese Yuan',
  };

  static List<String> get currencies => _ratesToUsd.keys.toList();

  String _fromCurrency = 'USD';
  String _toCurrency = 'NGN';
  double? _result;

  String get fromCurrency => _fromCurrency;
  String get toCurrency => _toCurrency;
  double? get result => _result;

  double get exchangeRate {
    final fromRate = _ratesToUsd[_fromCurrency]!;
    final toRate = _ratesToUsd[_toCurrency]!;
    return toRate / fromRate;
  }

  void setFromCurrency(String currency) {
    _fromCurrency = currency;
    _result = null;
    notifyListeners();
  }

  void setToCurrency(String currency) {
    _toCurrency = currency;
    _result = null;
    notifyListeners();
  }

  void swapCurrencies() {
    final temp = _fromCurrency;
    _fromCurrency = _toCurrency;
    _toCurrency = temp;
    _result = null;
    notifyListeners();
  }

  void convert(double amount) {
    if (amount <= 0) return;
    _result = amount * exchangeRate;
    notifyListeners();
  }
}
