import 'package:intl/intl.dart';

class AppFormatters {
  static final _numberFormat = NumberFormat('#,##0.####');
  static final _currencyFormat = NumberFormat('#,##0.00');

  static String formatNumber(double value) {
    if (value == 0) return '0';
    if (value.abs() >= 1e12) return '₦${_numberFormat.format(value / 1e12)}T';
    if (value.abs() >= 1e9) return '₦${_numberFormat.format(value / 1e9)}B';
    if (value.abs() >= 1e6) return '₦${_numberFormat.format(value / 1e6)}M';
    return _numberFormat.format(value);
  }

  static String formatCurrency(double value) => _currencyFormat.format(value);

  static String formatResult(double value) {
    if (value == value.roundToDouble()) {
      return value.toStringAsFixed(0);
    }
    return value.toStringAsFixed(4).replaceAll(RegExp(r'0+$'), '');
  }
}