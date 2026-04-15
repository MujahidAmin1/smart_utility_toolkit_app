import 'package:flutter/material.dart';
import 'package:smart_utility_toolkit_app/models/task_model.dart';
import 'package:smart_utility_toolkit_app/utils/app_themes.dart';
import 'package:smart_utility_toolkit_app/utils/date_formatter.dart';

class TaskTile extends StatelessWidget {
  final TaskModel task;
  final bool isCompleted;
  final VoidCallback onToggle;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const TaskTile({
    super.key,
    required this.task,
    required this.isCompleted,
    required this.onToggle,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.divider, width: 1),
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: task.isCompleted ? null : onToggle,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 150),
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                color: isCompleted
                    ? AppColors.primary
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(6),
                border: Border.all(
                  color: isCompleted
                      ? AppColors.primary
                      : AppColors.onSurfaceMuted,
                  width: 1.5,
                ),
              ),
              child: isCompleted
                  ? const Icon(Icons.check_rounded, size: 16, color: Colors.white)
                  : null,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  task.title,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: isCompleted
                        ? AppColors.onSurfaceMuted
                        : AppColors.onSurface,
                    decoration: isCompleted
                        ? TextDecoration.lineThrough
                        : TextDecoration.none,
                    decorationColor: AppColors.onSurfaceMuted,
                  ),
                ),
                Text(
                  task.isCompleted && task.completedAt != null
                      ? "completed at ${formatDate(task.completedAt!)}"
                      : "created at ${formatDate(task.dateCreated)}",
                  style: TextStyle(fontSize: 12),
                )
              ],
            ),
          ),
          isCompleted ? IconButton(
            onPressed: onDelete,
            icon: const Icon(Icons.delete, color: Colors.red)) :
          PopupMenuButton<String>(
            icon: const Icon(
              Icons.more_horiz_rounded,
              color: AppColors.onSurfaceMuted,
              size: 20,
            ),
            color: AppColors.surfaceVariant,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            onSelected: (value) {
              if (value == 'edit') onEdit();
              if (value == 'delete') onDelete();
            },
            itemBuilder: (_) => [
                const PopupMenuItem(
                  value: 'edit',
                  child: Text('Edit', style: TextStyle(color: AppColors.onSurface)),
                ),
              const PopupMenuItem(
                value: 'delete',
                child: Text('Delete', style: TextStyle(color: Colors.red)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
