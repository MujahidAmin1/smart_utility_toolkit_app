import 'package:flutter/material.dart';

enum UnitCategory { length, weight, temperature }

class UnitConverterController extends ChangeNotifier {
  UnitCategory _category = UnitCategory.length;
  String _fromUnit = '';
  String _toUnit = '';
  double? _result;

  UnitCategory get category => _category;
  String get fromUnit => _fromUnit;
  String get toUnit => _toUnit;
  double? get result => _result;

  static const Map<UnitCategory, List<String>> unitLabels = {
    UnitCategory.length: ['mm', 'cm', 'm', 'km', 'in', 'ft', 'mi'],
    UnitCategory.weight: ['mg', 'g', 'kg', 'lb', 'oz'],
    UnitCategory.temperature: ['°C', '°F', 'K'],
  };

  static const Map<String, double> _lengthToMeters = {
    'mm': 0.001,
    'cm': 0.01,
    'm': 1,
    'km': 1000,
    'in': 0.0254,
    'ft': 0.3048,
    'mi': 1609.344,
  };

  static const Map<String, double> _weightToGrams = {
    'mg': 0.001,
    'g': 1,
    'kg': 1000,
    'lb': 453.592,
    'oz': 28.3495,
  };

  List<String> get units => unitLabels[_category]!;

  UnitConverterController() {
    _fromUnit = units.first;
    _toUnit = units.length > 1 ? units[1] : units.first;
  }

  void setCategory(UnitCategory cat) {
    _category = cat;
    _fromUnit = units.first;
    _toUnit = units.length > 1 ? units[1] : units.first;
    _result = null;
    notifyListeners();
  }

  void setFromUnit(String unit) {
    _fromUnit = unit;
    _result = null;
    notifyListeners();
  }

  void setToUnit(String unit) {
    _toUnit = unit;
    _result = null;
    notifyListeners();
  }

  void swapUnits() {
    final temp = _fromUnit;
    _fromUnit = _toUnit;
    _toUnit = temp;
    _result = null;
    notifyListeners();
  }

  void convert(double inputValue) {
    switch (_category) {
      case UnitCategory.length:
        _result = _convertLinear(inputValue, _lengthToMeters);
      case UnitCategory.weight:
        _result = _convertLinear(inputValue, _weightToGrams);
      case UnitCategory.temperature:
        _result = _convertTemperature(inputValue);
    }
    notifyListeners();
  }

  double _convertLinear(double value, Map<String, double> factors) {
    final fromFactor = factors[_fromUnit]!;
    final toFactor = factors[_toUnit]!;
    return value * fromFactor / toFactor;
  }

  double _convertTemperature(double value) {
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
        return celsius;
      case '°F':
        return celsius * 9 / 5 + 32;
      case 'K':
        return celsius + 273.15;
      default:
        return celsius;
    }
  }
}
