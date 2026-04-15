import 'package:flutter/material.dart';

class LengthController extends ChangeNotifier {
  static const List<String> units = ['mm', 'cm', 'm', 'km', 'in', 'ft', 'mi'];

  static const Map<String, double> _lengthToMeters = {
    'mm': 0.001,
    'cm': 0.01,
    'm': 1,
    'km': 1000,
    'in': 0.0254,
    'ft': 0.3048,
    'mi': 1609.344,
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
    final fromFactor = _lengthToMeters[_fromUnit]!;
    final toFactor = _lengthToMeters[_toUnit]!;
    _result = inputValue * fromFactor / toFactor;
    notifyListeners();
  }
}
