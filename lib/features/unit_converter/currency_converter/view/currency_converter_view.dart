import 'package:flutter/material.dart';
import 'package:smart_utility_toolkit_app/features/unit_converter/currency_converter/controller/currency_controller.dart';
import 'package:smart_utility_toolkit_app/utils/app_themes.dart';
import 'package:smart_utility_toolkit_app/utils/text_formatter.dart';
import 'package:smart_utility_toolkit_app/utils/thousands_formatter.dart';
import 'package:smart_utility_toolkit_app/widgets/input_card.dart';
import 'package:smart_utility_toolkit_app/widgets/result_card.dart';
import 'package:smart_utility_toolkit_app/widgets/swap_button.dart';
import 'package:smart_utility_toolkit_app/widgets/tool_scaffold.dart';

class CurrencyConverterScreen extends StatefulWidget {
  const CurrencyConverterScreen({super.key});

  @override
  State<CurrencyConverterScreen> createState() => _CurrencyConverterScreenState();
}

class _CurrencyConverterScreenState extends State<CurrencyConverterScreen> {
  final _controller = CurrencyController();
  final _amountController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller.addListener(() => setState(() {}));
    _amountController.addListener(_onConvert);
  }

  @override
  void dispose() {
    _amountController.removeListener(_onConvert);
    _controller.dispose();
    _amountController.dispose();
    super.dispose();
  }

  void _onConvert() {
    final text = _amountController.text.replaceAll(',', '');
    final amount = double.tryParse(text);
    _controller.convert(amount);
  }

  @override
  Widget build(BuildContext context) {
    final currencies = CurrencyController.currencies;

    return ToolScaffold(
      title: 'Currency Converter',
      children: [
        InputCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'From',
                style: Theme.of(context).textTheme.labelLarge,
              ),
              const SizedBox(height: 12),
              _buildCurrencyDropdown(
                value: _controller.fromCurrency,
                currencies: currencies,
                onChanged: (v) {
                  _controller.setFromCurrency(v!);
                  _onConvert();
                },
              ),
              const SizedBox(height: 8),
              SwapButton(onPressed: () {
                _controller.swapCurrencies();
                _onConvert();
              }),
              const SizedBox(height: 8),
              Text(
                'To',
                style: Theme.of(context).textTheme.labelLarge,
              ),
              const SizedBox(height: 12),
              _buildCurrencyDropdown(
                value: _controller.toCurrency,
                currencies: currencies,
                onChanged: (v) {
                  _controller.setToCurrency(v!);
                  _onConvert();
                },
              ),
              const SizedBox(height: 16),
              Text(
                'Amount',
                style: Theme.of(context).textTheme.labelLarge,
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _amountController,
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                inputFormatters: [ThousandsFormatter()],
                style: const TextStyle(color: AppColors.onSurface),
                decoration: const InputDecoration(
                  hintText: 'Enter amount',
                ),
              ),
            ],
          ),
        ),
        if (_controller.result != null)
          ResultCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Converted Amount',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColors.onSurfaceMuted,
                      ),
                ),
                const SizedBox(height: 8),
                Text(
                  AppFormatters.formatCurrency(_controller.result!),
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(height: 4),
                Text(
                  _controller.toCurrency,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: AppColors.primary,
                      ),
                ),
                const SizedBox(height: 16),
                const Divider(color: AppColors.divider, height: 1),
                const SizedBox(height: 12),
                Text(
                  '1 ${_controller.fromCurrency} = ${AppFormatters.formatCurrency(_controller.exchangeRate)} ${_controller.toCurrency}',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColors.onSurfaceMuted,
                      ),
                ),
              ],
            ),
          ),
      ],
    );
  }

  Widget _buildCurrencyDropdown({
    required String value,
    required List<String> currencies,
    required ValueChanged<String?> onChanged,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: AppColors.surfaceVariant,
        borderRadius: BorderRadius.circular(12),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          isExpanded: true,
          dropdownColor: AppColors.surfaceVariant,
          style: const TextStyle(
            color: AppColors.onSurface,
            fontSize: 15,
          ),
          icon: const Icon(Icons.keyboard_arrow_down_rounded, color: AppColors.onSurfaceMuted),
          items: currencies.map((code) {
            final name = CurrencyController.currencyNames[code]!;
            return DropdownMenuItem(
              value: code,
              child: Text('$code — $name'),
            );
          }).toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }
}