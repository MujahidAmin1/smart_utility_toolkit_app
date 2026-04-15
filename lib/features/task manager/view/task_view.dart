import 'package:flutter/material.dart';
import 'package:smart_utility_toolkit_app/features/task manager/controller/task_controller.dart';
import 'package:smart_utility_toolkit_app/models/task_model.dart';
import 'package:smart_utility_toolkit_app/utils/app_themes.dart';
import 'package:smart_utility_toolkit_app/utils/navigator_helper.dart';
import 'package:smart_utility_toolkit_app/widgets/task_bottom_sheet.dart';
import 'package:smart_utility_toolkit_app/widgets/task_filter_chips.dart';
import 'package:smart_utility_toolkit_app/widgets/task_tile.dart';

class TaskView extends StatefulWidget {
  const TaskView({super.key});

  @override
  State<TaskView> createState() => _TaskViewState();
}

class _TaskViewState extends State<TaskView> {
  final _controller = TaskController();
  final _inputController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      if (mounted) setState(() {});
    });
    _controller.init();
  }

  @override
  void dispose() {
    _controller.dispose();
    _inputController.dispose();
    super.dispose();
  }

  void _showAddSheet() {
    _inputController.clear();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => TaskBottomSheet(
        title: 'New Task',
        controller: _inputController,
        onCancel: () => context.pop(),
        onSave: () async {
          final title = _inputController.text.trim();
          if (title.isNotEmpty) {
            await _controller.addTask(title);
          }
          if (mounted) context.pop();
        },
      ),
    );
  }

  void _showEditSheet(TaskModel task) {
    _inputController.text = task.title;
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => TaskBottomSheet(
        title: 'Edit Task',
        controller: _inputController,
        onCancel: () => context.pop(),
        onSave: () async {
          final title = _inputController.text.trim();
          if (title.isNotEmpty) {
            await _controller.updateTask(task.id, title);
          }
          if (mounted) context.pop();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (!_controller.isInitialized) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Task Manager'),
          elevation: 0,
          scrolledUnderElevation: 0,
        ),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Task Manager'),
        elevation: 0,
        scrolledUnderElevation: 0,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddSheet,
        backgroundColor: AppColors.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: const Icon(Icons.add_rounded, color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(height: 8),
            TaskFilterChips(
              currentFilter: _controller.filter,
              onFilterChanged: _controller.setFilter,
              getCount: _controller.getTaskCount,
            ),
            const SizedBox(height: 20),
            Expanded(
              child: _controller.filteredTasks.isEmpty
                  ? Center(
                      child: Text(
                        'No ${_controller.filter.name} tasks',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    )
                  : ListView.builder(
                      itemCount: _controller.filteredTasks.length,
                      itemBuilder: (context, index) {
                        final task = _controller.filteredTasks[index];
                        return TaskTile(
                          task: task,
                          isCompleted: _controller.isTaskCompleted(task),
                          onToggle: () => _controller.toggleTask(task.id),
                          onEdit: () => _showEditSheet(task),
                          onDelete: () => _controller.deleteTask(task.id),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
