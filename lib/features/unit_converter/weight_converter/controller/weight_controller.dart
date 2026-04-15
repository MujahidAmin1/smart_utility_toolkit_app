import 'package:flutter/material.dart';

class WeightController extends ChangeNotifier {
  static const List<String> units = ['mg', 'g', 'kg', 'lb', 'oz'];

  static const Map<String, double> _weightToGrams = {
    'mg': 0.001,
    'g': 1,
    'kg': 1000,
    'lb': 453.592,
    'oz': 28.3495,
  };

  String _fromUnit = units[0];
  String _toUnit = units[1];
  double? _result;

  String get fromUnit => _fromUnit;
  String get toUnit => _toUnit;
  double? get result => _result;

  void setFromUnit(String unit) {
    _fromUnit = unit;
    notifyListeners();
  }

  void setToUnit(String unit) {
    _toUnit = unit;
    notifyListeners();
  }

  void swapUnits() {
    final temp = _fromUnit;
    _fromUnit = _toUnit;
    _toUnit = temp;
    notifyListeners();
  }

  void convert(double? inputValue) {
    if (inputValue == null) {
       _result = null;
       notifyListeners();
       return;
    }
    final fromFactor = _weightToGrams[_fromUnit]!;
    final toFactor = _weightToGrams[_toUnit]!;
    _result = inputValue * fromFactor / toFactor;
    notifyListeners();
  }
}
