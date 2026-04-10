import 'package:flutter/material.dart';
import 'package:smart_utility_toolkit_app/utils/app_themes.dart';

enum Gender { male, female }

class GenderToggle extends StatelessWidget {
  final Gender selected;
  final ValueChanged<Gender> onChanged;

  const GenderToggle({
    super.key,
    required this.selected,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _buildChip(Gender.male, 'Male', Icons.male_rounded),
        const SizedBox(width: 12),
        _buildChip(Gender.female, 'Female', Icons.female_rounded),
      ],
    );
  }

  Widget _buildChip(Gender gender, String label, IconData icon) {
    final isSelected = selected == gender;
    return Expanded(
      child: GestureDetector(
        onTap: () => onChanged(gender),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(vertical: 14),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.primary : AppColors.surfaceVariant,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 20,
                color: isSelected ? Colors.white : AppColors.onSurfaceMuted,
              ),
              const SizedBox(width: 8),
              Text(
                label,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                  color: isSelected ? Colors.white : AppColors.onSurfaceMuted,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
