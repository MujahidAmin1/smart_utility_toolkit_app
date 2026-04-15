import 'package:flutter/material.dart';
import 'package:smart_utility_toolkit_app/features/unit_converter/currency_converter/view/currency_converter_view.dart';
import 'package:smart_utility_toolkit_app/features/unit_converter/length_converter/view/length_view.dart';
import 'package:smart_utility_toolkit_app/features/unit_converter/temperature_converter/view/temperature_view.dart';
import 'package:smart_utility_toolkit_app/features/unit_converter/weight_converter/view/weight_view.dart';
import 'package:smart_utility_toolkit_app/models/tool_item.dart';
import 'package:smart_utility_toolkit_app/utils/app_themes.dart';
import 'package:smart_utility_toolkit_app/utils/navigator_helper.dart';

final _converters = [
  ToolItem(
    title: 'Length Converter',
    subtitle: 'Meters, Inches, Feet, Miles, etc.',
    icon: Icons.straighten,
    iconColor: const Color(0xFF4C6EF5),
    page: const LengthConverterScreen(),
  ),
  ToolItem(
    title: 'Weight Converter',
    subtitle: 'Kilograms, Pounds, Ounces, etc.',
    icon: Icons.monitor_weight_outlined,
    iconColor: const Color(0xFF69DB7C),
    page: const WeightConverterScreen(),
  ),
  ToolItem(
    title: 'Temperature Converter',
    subtitle: 'Celsius, Fahrenheit, Kelvin',
    icon: Icons.thermostat_outlined,
    iconColor: const Color(0xFFFFD43B),
    page: const TemperatureConverterScreen(),
  ),
  ToolItem(
    title: 'Currency Converter',
    subtitle: 'USD, NGN, EUR, GBP, CNY',
    icon: Icons.currency_exchange_rounded,
    iconColor: const Color(0xFFFF8CC8),
    page: const CurrencyConverterScreen(),
  ),
];

class ConverterHubScreen extends StatelessWidget {
  const ConverterHubScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Unit Converter'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () => context.pop(),
        ),
        elevation: 0,
        scrolledUnderElevation: 0,
      ),
      body: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        itemCount: _converters.length,
        separatorBuilder: (_, _) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final tool = _converters[index];
          return GestureDetector(
            onTap: () => context.push(tool.page),
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.divider, width: 1),
              ),
              child: Row(
                children: [
                  Container(
                    width: 52,
                    height: 52,
                    decoration: BoxDecoration(
                      color: tool.iconColor.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Icon(tool.icon, color: tool.iconColor, size: 24),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(tool.title, style: Theme.of(context).textTheme.titleMedium),
                        const SizedBox(height: 4),
                        Text(tool.subtitle, style: Theme.of(context).textTheme.bodyMedium),
                      ],
                    ),
                  ),
                  const Icon(Icons.chevron_right_rounded,
                      color: AppColors.onSurfaceMuted, size: 20),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
