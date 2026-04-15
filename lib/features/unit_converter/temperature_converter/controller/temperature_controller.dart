import 'package:flutter/material.dart';

class TemperatureController extends ChangeNotifier {
  static const List<String> units = ['°C', '°F', 'K'];

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

  void convert(double? value) {
    if (value == null) {
       _result = null;
       notifyListeners();
       return;
    }
    double celsius;
    switch (_fromUnit) {
      case '°C':
        celsius = value;
      case '°F':
        celsius = (value - 32) * 5 / 9;
      case 'K':
        celsius = value - 273.15;
      default:
        celsius = value;
    }

    switch (_toUnit) {
      case '°C':
        _result = celsius;
      case '°F':
        _result = celsius * 9 / 5 + 32;
      case 'K':
        _result = celsius + 273.15;
      default:
        _result = celsius;
    }
    
    notifyListeners();
  }
}
