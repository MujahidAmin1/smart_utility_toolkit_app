import 'package:hive_ce/hive_ce.dart';

part 'task_model.g.dart';

@HiveType(typeId: 0)
class TaskModel extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  String title;

  @HiveField(2)
  bool isCompleted;

  @HiveField(3)
  final DateTime dateCreated;

  @HiveField(4)
  DateTime? completedAt;

  TaskModel({
    required this.id,
    required this.title,
    required this.isCompleted,
    required this.dateCreated,
    this.completedAt,
  });
}
