import 'package:flutter/material.dart';
import 'package:smart_utility_toolkit_app/features/loan_converter/controller/loan_controller.dart';
import 'package:smart_utility_toolkit_app/utils/app_themes.dart';
import 'package:smart_utility_toolkit_app/utils/text_formatter.dart';
import 'package:smart_utility_toolkit_app/utils/thousands_formatter.dart';
import 'package:smart_utility_toolkit_app/widgets/input_card.dart';
import 'package:smart_utility_toolkit_app/widgets/primary_action_button.dart';
import 'package:smart_utility_toolkit_app/widgets/result_card.dart';
import 'package:smart_utility_toolkit_app/widgets/stat_row.dart';
import 'package:smart_utility_toolkit_app/widgets/tool_scaffold.dart';

class LoanConverterScreen extends StatefulWidget {
  const LoanConverterScreen({super.key});

  @override
  State<LoanConverterScreen> createState() => _LoanConverterScreenState();
}

class _LoanConverterScreenState extends State<LoanConverterScreen> {
  final _controller = LoanController();
  final _principalController = TextEditingController();
  final _rateController = TextEditingController();
  final _tenureController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _controller.dispose();
    _principalController.dispose();
    _rateController.dispose();
    _tenureController.dispose();
    super.dispose();
  }

  void _onCalculate() {
    final principal = double.tryParse(_principalController.text.replaceAll(',', ''));
    final rate = double.tryParse(_rateController.text.replaceAll(',', ''));
    final tenure = int.tryParse(_tenureController.text.replaceAll(',', ''));
    if (principal == null || rate == null || tenure == null) return;
    _controller.calculateEMI(principal, rate, tenure);
  }

  @override
  Widget build(BuildContext context) {
    return ToolScaffold(
      title: 'Loan Calculator',
      children: [
        InputCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Principal Amount(NGN)',
                style: Theme.of(context).textTheme.labelLarge,
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _principalController,
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                inputFormatters: [ThousandsFormatter()],
                style: const TextStyle(color: AppColors.onSurface),
                decoration: const InputDecoration(
                  hintText: 'Enter loan amount',
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Annual Interest Rate (%)',
                style: Theme.of(context).textTheme.labelLarge,
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _rateController,
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                inputFormatters: [ThousandsFormatter()],
                style: const TextStyle(color: AppColors.onSurface),
                decoration: const InputDecoration(
                  hintText: 'Enter annual rate',
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Tenure (Months)',
                style: Theme.of(context).textTheme.labelLarge,
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _tenureController,
                keyboardType: TextInputType.number,
                inputFormatters: [ThousandsFormatter()],
                style: const TextStyle(color: AppColors.onSurface),
                decoration: const InputDecoration(
                  hintText: 'Enter tenure in months',
                ),
              ),
            ],
          ),
        ),
        PrimaryActionButton(label: 'Calculate EMI', onPressed: _onCalculate),
        if (_controller.hasResult)
          ResultCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Monthly EMI',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColors.onSurfaceMuted,
                      ),
                ),
                const SizedBox(height: 8),
                Text(
                  AppFormatters.formatCurrency(_controller.emi!),
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(height: 16),
                const Divider(color: AppColors.divider, height: 1),
                StatRow(
                  label: 'Monthly EMI',
                  value: AppFormatters.formatCurrency(_controller.emi!),
                ),
                const Divider(color: AppColors.divider, height: 1),
                StatRow(
                  label: 'Total Payment',
                  value: AppFormatters.formatCurrency(_controller.totalPayment!),
                ),
                const Divider(color: AppColors.divider, height: 1),
                StatRow(
                  label: 'Total Interest',
                  value: AppFormatters.formatCurrency(_controller.totalInterest!),
                ),
              ],
            ),
          ),
      ],
    );
  }
}