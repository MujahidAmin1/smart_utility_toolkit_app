import 'package:flutter/material.dart';
import 'package:smart_utility_toolkit_app/features/currency_converter/view/currency_converter_view.dart';
import 'package:smart_utility_toolkit_app/features/length_converter/view/length_view.dart';
import 'package:smart_utility_toolkit_app/features/temperature_converter/view/temperature_view.dart';
import 'package:smart_utility_toolkit_app/features/weight_converter/view/weight_view.dart';
import 'package:smart_utility_toolkit_app/models/tool_item.dart';
import 'package:smart_utility_toolkit_app/utils/app_themes.dart';
import 'package:smart_utility_toolkit_app/utils/navigator_helper.dart';

final _tools = [
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
    subtitle: 'Major currencies, live rates',
    icon: Icons.currency_exchange_rounded,
    iconColor: const Color(0xFFFF8CC8),
    page: const CurrencyConverterScreen(),
  ),
];

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 32),
              Row(
                children: [
                  Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(Icons.auto_awesome, size: 18, color: Colors.white),
                  ),
                  const SizedBox(width: 10),
                  Text('Smart Toolkit', style: Theme.of(context).textTheme.titleLarge),
                ],
              ),
              const SizedBox(height: 20),
              Text(
                'Your everyday\nutility companion.',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 8),
              Text(
                '${_tools.length} tools available',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 32),
              Expanded(
                child: ListView.separated(
                  itemCount: _tools.length,
                  separatorBuilder: (_, _) => const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    final tool = _tools[index];
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
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}