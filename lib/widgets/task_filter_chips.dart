import 'package:flutter/material.dart';
import 'package:smart_utility_toolkit_app/models/task_filter.dart';
import 'package:smart_utility_toolkit_app/utils/app_themes.dart';

class TaskFilterChips extends StatelessWidget {
  final TaskFilter currentFilter;
  final ValueChanged<TaskFilter> onFilterChanged;
  final int Function(TaskFilter) getCount;

  const TaskFilterChips({
    super.key,
    required this.currentFilter,
    required this.onFilterChanged,
    required this.getCount,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: TaskFilter.values.map((filter) {
        final isSelected = currentFilter == filter;
        final count = getCount(filter);
        final label = '${filter.name[0].toUpperCase()}${filter.name.substring(1)}';

        return Padding(
          padding: const EdgeInsets.only(right: 8),
          child: ChoiceChip(
            label: Text('$label ($count)'),
            selected: isSelected,
            onSelected: (_) => onFilterChanged(filter),
            selectedColor: AppColors.primary,
            backgroundColor: AppColors.surfaceVariant,
            labelStyle: TextStyle(
              color: isSelected ? Colors.white : AppColors.onSurfaceMuted,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
              fontSize: 13,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
              side: BorderSide.none,
            ),
            showCheckmark: false,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          ),
        );
      }).toList(),
    );
  }
}
