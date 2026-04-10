import 'package:flutter/material.dart';
import 'package:smart_utility_toolkit_app/widgets/gender_toggle.dart';

class BmiController extends ChangeNotifier {
  Gender _gender = Gender.male;
  double? _bmi;
  String? _categoryLabel;
  Color? _categoryColor;

  Gender get gender => _gender;
  double? get bmi => _bmi;
  String? get categoryLabel => _categoryLabel;
  Color? get categoryColor => _categoryColor;

  void setGender(Gender g) {
    _gender = g;
    _bmi = null;
    _categoryLabel = null;
    _categoryColor = null;
    notifyListeners();
  }

  void calculateBMI(double heightCm, double weightKg) {
    if (heightCm <= 0 || weightKg <= 0) return;

    final heightM = heightCm / 100;
    _bmi = weightKg / (heightM * heightM);

    if (_bmi! < 18.5) {
      _categoryLabel = 'Underweight';
      _categoryColor = const Color(0xFF74C0FC);
    } else if (_bmi! < 25) {
      _categoryLabel = 'Normal';
      _categoryColor = const Color(0xFF69DB7C);
    } else if (_bmi! < 30) {
      _categoryLabel = 'Overweight';
      _categoryColor = const Color(0xFFFFD43B);
    } else {
      _categoryLabel = 'Obese';
      _categoryColor = const Color(0xFFFF6B6B);
    }

    notifyListeners();
  }
}
