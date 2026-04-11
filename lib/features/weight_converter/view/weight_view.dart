import 'package:flutter/material.dart';
import 'package:smart_utility_toolkit_app/features/weight_converter/controller/weight_controller.dart';
import 'package:smart_utility_toolkit_app/utils/app_themes.dart';
import 'package:smart_utility_toolkit_app/utils/text_formatter.dart';
import 'package:smart_utility_toolkit_app/utils/thousands_formatter.dart';
import 'package:smart_utility_toolkit_app/widgets/input_card.dart';
import 'package:smart_utility_toolkit_app/widgets/result_card.dart';
import 'package:smart_utility_toolkit_app/widgets/swap_button.dart';
import 'package:smart_utility_toolkit_app/widgets/tool_scaffold.dart';

class WeightConverterScreen extends StatefulWidget {
  const WeightConverterScreen({super.key});

  @override
  State<WeightConverterScreen> createState() => _WeightConverterScreenState();
}

class _WeightConverterScreenState extends State<WeightConverterScreen> {
  final _controller = WeightController();
  final _inputController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller.addListener(() => setState(() {}));
    _inputController.addListener(_onConvert);
  }

  @override
  void dispose() {
    _inputController.removeListener(_onConvert);
    _controller.dispose();
    _inputController.dispose();
    super.dispose();
  }

  void _onConvert() {
    final text = _inputController.text.replaceAll(',', '');
    final value = double.tryParse(text);
    _controller.convert(value);
  }

  @override
  Widget build(BuildContext context) {
    return ToolScaffold(
      title: 'Weight Converter',
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
              appDropdown(
                value: _controller.fromUnit,
                items: WeightController.units,
                onChanged: (v) {
                  _controller.setFromUnit(v!);
                  _onConvert();
                },
              ),
              const SizedBox(height: 8),
              SwapButton(onPressed: () {
                _controller.swapUnits();
                _onConvert();
              }),
              const SizedBox(height: 8),
              Text(
                'To',
                style: Theme.of(context).textTheme.labelLarge,
              ),
              const SizedBox(height: 12),
              appDropdown(
                value: _controller.toUnit,
                items: WeightController.units,
                onChanged: (v) {
                  _controller.setToUnit(v!);
                  _onConvert();
                },
              ),
              const SizedBox(height: 16),
              Text(
                'Value',
                style: Theme.of(context).textTheme.labelLarge,
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _inputController,
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                inputFormatters: [ThousandsFormatter()],
                style: const TextStyle(color: AppColors.onSurface),
                decoration: const InputDecoration(
                  hintText: 'Enter value',
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
                  'Result',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColors.onSurfaceMuted,
                      ),
                ),
                const SizedBox(height: 8),
                Text(
                  AppFormatters.formatResult(_controller.result!),
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(height: 4),
                Text(
                  '${_inputController.text} ${_controller.fromUnit} = ${AppFormatters.formatResult(_controller.result!)} ${_controller.toUnit}',
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

  Widget appDropdown({
    required String value,
    required List<String> items,
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
          items: items.map((unit) {
            return DropdownMenuItem(value: unit, child: Text(unit));
          }).toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }
}
