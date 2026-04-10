import 'package:flutter/material.dart';
import 'package:smart_utility_toolkit_app/utils/app_themes.dart';

class SwapButton extends StatelessWidget {
  final VoidCallback onPressed;

  const SwapButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.surfaceVariant,
          shape: BoxShape.circle,
        ),
        child: IconButton(
          icon: const Icon(Icons.swap_vert_rounded, size: 22),
          color: AppColors.onSurface,
          onPressed: onPressed,
          tooltip: 'Swap',
        ),
      ),
    );
  }
}
