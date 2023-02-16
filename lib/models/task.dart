import 'dart:io';

import 'package:myapp/models/task_status.dart';
import 'package:myapp/models/task_relation.dart';
import 'package:tuple/tuple.dart';

class Task {
  int id;
  String title;
  String description;
  TaskStatus status;
  DateTime updateTime;
  Set<Tuple2<TaskRelation, Task>> relatedTasks = {};
  File? relatedImage;

  Task(
      {required this.id,
      required this.title,
      required this.description,
      required this.status,
      required this.updateTime});
}
