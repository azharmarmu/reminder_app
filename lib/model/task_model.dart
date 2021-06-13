import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

part 'task_model.g.dart';

@HiveType(typeId: 0)
class TaskModel {
  @HiveField(0)
  final String title;
  @HiveField(1)
  final String description;

  TaskModel({
    @required this.title,
    @required this.description,
  });

  @override
  String toString() => '$title , $description';
}
