import 'package:flutter/material.dart';
import 'package:smart_utility_toolkit_app/utils/app_themes.dart';

class ResultCard extends StatelessWidget {
  final Widget child;

  const ResultCard({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(16),
      ),
      child: child,
    );
  }
}
