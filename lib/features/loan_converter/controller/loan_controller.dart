import 'dart:math';
import 'package:flutter/material.dart';

class LoanController extends ChangeNotifier {
  double? _emi;
  double? _totalPayment;
  double? _totalInterest;

  double? get emi => _emi;
  double? get totalPayment => _totalPayment;
  double? get totalInterest => _totalInterest;

  bool get hasResult => _emi != null;

  void calculateEMI(double principal, double annualRate, int tenureMonths) {
    if (principal <= 0 || annualRate <= 0 || tenureMonths <= 0) return;

    final monthlyRate = annualRate / 12 / 100;
    final n = tenureMonths;
    final factor = pow(1 + monthlyRate, n).toDouble();

    _emi = principal * monthlyRate * factor / (factor - 1);
    _totalPayment = _emi! * n;
    _totalInterest = _totalPayment! - principal;

    notifyListeners();
  }
}
