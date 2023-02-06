// ignore_for_file: file_names, must_be_immutable

import 'package:flutter/material.dart';
import 'package:myapp/models/task_model.dart';
import 'package:myapp/models/task_relation_model.dart';
import 'package:myapp/util/app_state.dart';
import 'package:myapp/models/task_status_model.dart';
import 'package:myapp/screens/home_page.dart';
import 'package:tuple/tuple.dart';
import 'package:intl/intl.dart';

import '../util/add_related_issue.dart';
import '../util/delete_task.dart';

class TaskDetails extends StatefulWidget {
  Task task;

  TaskStatus modifiedStatus = TaskStatus.Open;
  Set<Tuple2<TaskRelation, Task>> modifiedRelatedTasks = {};

  TaskDetails({super.key, required this.task}) {
    modifiedStatus = task.status;
    modifiedRelatedTasks = task.relatedTasks;
  }

  @override
  State<TaskDetails> createState() => _TaskDetailsState();
}

class _TaskDetailsState extends State<TaskDetails> {
  static const String _title = 'Task Details';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(_title),
        actions: [
          DeleteTaskButton(widget: widget),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            // Task title
            Padding(
              padding: const EdgeInsets.only(
                  left: 4.0, top: 5.0, right: 4.0, bottom: 8.0),
              child: Container(
                alignment: Alignment.topLeft,
                child: Text(widget.task.title,
                    style: const TextStyle(fontSize: 20.0)),
              ),
            ),
            const Divider(),
            // Task description
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Container(
                alignment: Alignment.topLeft,
                padding: const EdgeInsets.all(5.0),
                child: Text(widget.task.description,
                    style: const TextStyle(fontSize: 15.0)),
              ),
            ),
            const Divider(),
            // Task status and last updated time
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Status: '),
                  DropdownButton<TaskStatus>(
                    onChanged: (TaskStatus? newValue) {
                      setState(() {
                        widget.modifiedStatus = newValue!;
                      });
                    },
                    value: widget.modifiedStatus,
                    items: TaskStatus.values.map<DropdownMenuItem<TaskStatus>>(
                      (TaskStatus value) {
                        return DropdownMenuItem<TaskStatus>(
                          value: value,
                          child: Text(value.name),
                        );
                      },
                    ).toList(),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Last update: '),
                  Text(DateFormat('yyyy-MM-dd  kk:mm')
                      .format(widget.task.updateTime)
                      .toString()),
                ],
              ),
            ),
            const Divider(),
            AddRelatedIssue(
              widget: widget,
              task: widget.task,
              modifiedRelatedTasks: widget.modifiedRelatedTasks,
            ),
            const Divider(),
            updateTask(context),
          ],
        ),
      ),
    );
  }

  // updateTask method to update changes in existing task
  ElevatedButton updateTask(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        widget.task.status = widget.modifiedStatus;
        widget.task.updateTime = DateTime.now();
        widget.task.relatedTasks = widget.modifiedRelatedTasks;
        for (int i = 0; i < widget.modifiedRelatedTasks.length; i++) {
          TaskRelation tempTaskRelation =
              widget.modifiedRelatedTasks.elementAt(i).item1.relationOpposite;
          Task relatedTask = widget.modifiedRelatedTasks.elementAt(i).item2;
          relatedTask.relatedTasks.add(Tuple2(tempTaskRelation, widget.task));
        }
        AppState.sortTasks();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Task updated!"),
          ),
        );
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const HomePage()),
        );
      },
      child: const Text('Update task'),
    );
  }
}
