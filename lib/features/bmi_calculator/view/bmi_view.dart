import 'package:flutter/material.dart';
import 'package:smart_utility_toolkit_app/features/bmi_calculator/controller/bmi_controller.dart';
import 'package:smart_utility_toolkit_app/utils/app_themes.dart';
import 'package:smart_utility_toolkit_app/utils/thousands_formatter.dart';
import 'package:smart_utility_toolkit_app/widgets/gender_toggle.dart';
import 'package:smart_utility_toolkit_app/widgets/input_card.dart';
import 'package:smart_utility_toolkit_app/widgets/primary_action_button.dart';
import 'package:smart_utility_toolkit_app/widgets/result_card.dart';
import 'package:smart_utility_toolkit_app/widgets/tool_scaffold.dart';

class BmiScreen extends StatefulWidget {
  const BmiScreen({super.key});

  @override
  State<BmiScreen> createState() => _BmiScreenState();
}

class _BmiScreenState extends State<BmiScreen> {
  final _controller = BmiController();
  final _heightController = TextEditingController();
  final _weightController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _controller.dispose();
    _heightController.dispose();
    _weightController.dispose();
    super.dispose();
  }

  void _onCalculate() {
    final height = double.tryParse(_heightController.text.replaceAll(',', ''));
    final weight = double.tryParse(_weightController.text.replaceAll(',', ''));
    if (height == null || weight == null) return;
    _controller.calculateBMI(height, weight);
  }

  @override
  Widget build(BuildContext context) {
    return ToolScaffold(
      title: 'BMI Calculator',
      children: [
        InputCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Gender',
                style: Theme.of(context).textTheme.labelLarge,
              ),
              const SizedBox(height: 12),
              GenderToggle(
                selected: _controller.gender,
                onChanged: _controller.setGender,
              ),
              const SizedBox(height: 16),
              Text(
                'Height (cm)',
                style: Theme.of(context).textTheme.labelLarge,
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _heightController,
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                inputFormatters: [ThousandsFormatter()],
                style: const TextStyle(color: AppColors.onSurface),
                decoration: const InputDecoration(
                  hintText: 'Enter height in cm',
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Weight (kg)',
                style: Theme.of(context).textTheme.labelLarge,
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _weightController,
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                inputFormatters: [ThousandsFormatter()],
                style: const TextStyle(color: AppColors.onSurface),
                decoration: const InputDecoration(
                  hintText: 'Enter weight in kg',
                ),
              ),
            ],
          ),
        ),
        PrimaryActionButton(label: 'Calculate BMI', onPressed: _onCalculate),
        if (_controller.bmi != null)
          ResultCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Your BMI',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColors.onSurfaceMuted,
                      ),
                ),
                const SizedBox(height: 8),
                Text(
                  _controller.bmi!.toStringAsFixed(1),
                  style: Theme.of(context).textTheme.displayLarge,
                ),
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: _controller.categoryColor!.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    _controller.categoryLabel!,
                    style: TextStyle(
                      color: _controller.categoryColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                const Divider(color: AppColors.divider, height: 1),
                const SizedBox(height: 12),
                Text(
                  'Height: ${_heightController.text} cm · Weight: ${_weightController.text} kg',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColors.onSurfaceMuted,
                      ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Gender: ${_controller.gender == Gender.male ? 'Male' : 'Female'}',
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
}