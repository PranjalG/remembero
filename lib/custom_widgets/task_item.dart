import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/task_model.dart';
import '../providers/task_provider.dart';

class TaskItem extends StatelessWidget {
  final Task task;

  const TaskItem({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(task.id),
      onDismissed: (_) {
        context.read<TaskProvider>().deleteTask(task.id);
      },
      child: ListTile(
        title: Text(
          task.title,
          style: TextStyle(
            decoration:
            task.isCompleted ? TextDecoration.lineThrough : null,
          ),
        ),
        leading: Checkbox(
          value: task.isCompleted,
          onChanged: (_) {
            context.read<TaskProvider>().toggleTask(task.id);
          },
        ),
      ),
    );
  }
}