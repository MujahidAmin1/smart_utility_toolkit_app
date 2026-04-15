import 'package:flutter/material.dart';
import 'package:hive_ce/hive_ce.dart';
import 'package:smart_utility_toolkit_app/models/task_filter.dart';
import 'package:smart_utility_toolkit_app/models/task_model.dart';

class TaskController extends ChangeNotifier {
  static const String _boxName = 'tasks';
  Box<TaskModel>? _box;
  
  List<TaskModel> _tasks = [];
  List<TaskModel> get tasks => _tasks;

  bool _isInitialized = false;
  bool get isInitialized => _isInitialized;

  TaskFilter _filter = TaskFilter.pending;
  TaskFilter get filter => _filter;

  final Set<String> _pendingToggles = {};

  bool isTaskCompleted(TaskModel task) {
    if (_pendingToggles.contains(task.id)) {
      return !task.isCompleted;
    }
    return task.isCompleted;
  }

  List<TaskModel> get filteredTasks {
    return switch (_filter) {
      TaskFilter.pending => _tasks.where((t) => !t.isCompleted).toList(),
      TaskFilter.completed => _tasks.where((t) => t.isCompleted).toList(),
    };
  }

  int getTaskCount(TaskFilter f) {
    return switch (f) {
      TaskFilter.pending => _tasks.where((t) => !t.isCompleted).length,
      TaskFilter.completed => _tasks.where((t) => t.isCompleted).length,
    };
  }

  void setFilter(TaskFilter f) {
    if (_filter == f) return;
    _filter = f;
    notifyListeners();
  }

  Future<void> init() async {
    if (_isInitialized) return;
    _box = await Hive.openBox<TaskModel>(_boxName);
    _isInitialized = true;
    _loadTasks();
  }

  void _loadTasks() {
    if (_box == null) return;
    final sorted = _box!.values.toList()
      ..sort((a, b) => b.dateCreated.compareTo(a.dateCreated));
    _tasks = sorted;
    notifyListeners();
  }

  Future<void> addTask(String title) async {
    if (_box == null) return;
    final task = TaskModel(
      id: DateTime.now().toString(),
      title: title,
      isCompleted: false,
      dateCreated: DateTime.now(),
    );
    await _box!.put(task.id, task);
    _loadTasks();
  }

  Future<void> updateTask(String id, String newTitle) async {
    if (_box == null) return;
    final task = _box!.get(id);
    if (task == null) return;
    task.title = newTitle;
    await task.save();
    _loadTasks();
  }

  void toggleTask(String id) {
    if (_box == null) return;
    
    if (_pendingToggles.contains(id)) {
       // Reverse visual state if tapped again before 3s
       _pendingToggles.remove(id);
       notifyListeners();
       return;
    }

    _pendingToggles.add(id);
    notifyListeners();

    Future.delayed(const Duration(seconds: 3), () async {
       if (!_pendingToggles.contains(id)) return;
       _pendingToggles.remove(id);
       
       final task = _box!.get(id);
       if (task == null) return;
       task.isCompleted = !task.isCompleted;
       if (task.isCompleted) {
         task.completedAt = DateTime.now();
       } else {
         task.completedAt = null;
       }
       await task.save();
       _loadTasks();
    });
  }

  Future<void> deleteTask(String id) async {
    if (_box == null) return;
    await _box!.delete(id);
    _loadTasks();
  }
}
