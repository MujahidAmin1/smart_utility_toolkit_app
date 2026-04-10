import 'package:flutter/material.dart';
import 'package:smart_utility_toolkit_app/features/unit_converter/controller/unit_converter_controller.dart';
import 'package:smart_utility_toolkit_app/utils/app_themes.dart';
import 'package:smart_utility_toolkit_app/utils/text_formatter.dart';
import 'package:smart_utility_toolkit_app/utils/thousands_formatter.dart';
import 'package:smart_utility_toolkit_app/widgets/category_chip_row.dart';
import 'package:smart_utility_toolkit_app/widgets/input_card.dart';
import 'package:smart_utility_toolkit_app/widgets/primary_action_button.dart';
import 'package:smart_utility_toolkit_app/widgets/result_card.dart';
import 'package:smart_utility_toolkit_app/widgets/swap_button.dart';
import 'package:smart_utility_toolkit_app/widgets/tool_scaffold.dart';

class UnitConverterScreen extends StatefulWidget {
  const UnitConverterScreen({super.key});

  @override
  State<UnitConverterScreen> createState() => _UnitConverterScreenState();
}

class _UnitConverterScreenState extends State<UnitConverterScreen> {
  final _controller = UnitConverterController();
  final _inputController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _controller.dispose();
    _inputController.dispose();
    super.dispose();
  }

  void _onConvert() {
    final value = double.tryParse(_inputController.text.replaceAll(',', ''));
    if (value == null) return;
    _controller.convert(value);
  }

  @override
  Widget build(BuildContext context) {
    final categories = UnitCategory.values;
    final categoryLabels = ['Length', 'Weight', 'Temperature'];

    return ToolScaffold(
      title: 'Unit Converter',
      children: [
        CategoryChipRow(
          labels: categoryLabels,
          selectedIndex: categories.indexOf(_controller.category),
          onSelected: (index) {
            _controller.setCategory(categories[index]);
            _inputController.clear();
          },
        ),
        InputCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'From',
                style: Theme.of(context).textTheme.labelLarge,
              ),
              const SizedBox(height: 12),
              _buildDropdown(
                value: _controller.fromUnit,
                items: _controller.units,
                onChanged: (v) => _controller.setFromUnit(v!),
              ),
              const SizedBox(height: 8),
              SwapButton(onPressed: _controller.swapUnits),
              const SizedBox(height: 8),
              Text(
                'To',
                style: Theme.of(context).textTheme.labelLarge,
              ),
              const SizedBox(height: 12),
              _buildDropdown(
                value: _controller.toUnit,
                items: _controller.units,
                onChanged: (v) => _controller.setToUnit(v!),
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
        PrimaryActionButton(label: 'Convert', onPressed: _onConvert),
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

  Widget _buildDropdown({
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