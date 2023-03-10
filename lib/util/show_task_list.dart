// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:myapp/screens/task_details.dart';

import '../models/task.dart';
import '../models/task_status.dart';
import 'database_helper.dart';

class TaskList extends StatefulWidget {
  final Map<String, TaskStatus?> _filters = {
    "All": null,
    "Open": TaskStatus.Open,
    "In Progress": TaskStatus.InProgress,
    "Completed": TaskStatus.Completed
  };

  String _selectedFilterValue = "All";
  List<Task> _visibleTasks = DatabaseHelper.getFilteredTasks(null);

  TaskList({super.key});

  @override
  State<TaskList> createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Text('Filter by: '),
                DropdownButton<String>(
                  key: const Key("dropDownFilterBy"),
                  onChanged: (String? newValue) {
                    setState(() {
                      widget._selectedFilterValue = newValue!;
                      widget._visibleTasks = DatabaseHelper.getFilteredTasks(
                          widget._filters[newValue]);
                    });
                  },
                  value: widget._selectedFilterValue,
                  items: widget._filters.keys.map<DropdownMenuItem<String>>(
                    (String entry) {
                      return DropdownMenuItem<String>(
                        value: entry,
                        child: Text(entry),
                      );
                    },
                  ).toList(),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: ListView.builder(
              key: const Key("taskList"),
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: widget._visibleTasks.length,
              itemBuilder: (context, index) {
                final task = widget._visibleTasks[index];
                return Card(
                  elevation: 4,
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  key: ValueKey(task.id),
                  child: ListTile(
                    title: Text(task.title),
                    trailing: IconButton(
                        key: const Key("goToTask"),
                        icon: const Icon(Icons.edit),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => TaskDetails(task: task),
                            ),
                          );
                        }),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
