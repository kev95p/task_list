import 'package:flutter/material.dart';
import 'package:task_list/src/tasks_feature/task_item_model.dart';

class TaskDetail extends StatelessWidget {
  static const routeName = '/task-detail';
  final TaskItemModel task;
  const TaskDetail({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(task.name)),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                'Task Title: ${task.name}',
                textAlign: TextAlign.left,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text('Created Date: ${task.createdDate}'),
            )
          ],
        ),
      ),
    );
  }
}
