import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class ThousandsFormatter extends TextInputFormatter {
  static const separator = ',';

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.isEmpty) {
      return newValue.copyWith(text: '');
    }

    String digits = newValue.text.replaceAll(RegExp(r'[^0-9.]'), '');
    
    // Hande multiple decimal points by keeping the first
    if (digits.indexOf('.') != digits.lastIndexOf('.')) {
      final parts = digits.split('.');
      digits = '${parts[0]}.${parts.sublist(1).join('')}';
    }

    final parts = digits.split('.');
    String integerPart = parts[0];
    String decimalPart = parts.length > 1 ? '.${parts[1]}' : '';

    if (digits.endsWith('.')) {
      decimalPart = '.';
    }

    String formattedIntegerPart = '';
    if (integerPart.isNotEmpty) {
      final number = int.tryParse(integerPart) ?? 0;
      formattedIntegerPart = NumberFormat('#,###').format(number);
    }

    String newText = '$formattedIntegerPart$decimalPart';

    // A simpler cursor handling strategy for formatting:
    // Count the number of non-formatting characters before the cursor
    int rawIndex = 0;
    for (int i = 0; i < newValue.selection.end && i < newValue.text.length; i++) {
      if (newValue.text[i] != separator) {
        rawIndex++;
      }
    }

    // Now find the equivalent position in the formatted string
    int formatIndex = 0;
    int rawCount = 0;
    while (rawCount < rawIndex && formatIndex < newText.length) {
      if (newText[formatIndex] != separator) {
        rawCount++;
      }
      formatIndex++;
    }

    return TextEditingValue(
      text: newText,
      selection: TextSelection.collapsed(offset: formatIndex),
    );
  }
}
