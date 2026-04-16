import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/task_model.dart';
import '../providers/task_provider.dart';

class TaskItem extends StatelessWidget {
  final Task task;

  const TaskItem({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Dismissible(
        key: Key(task.id),
        direction: DismissDirection.endToStart,
        onDismissed: (_) {
          context.read<TaskProvider>().deleteTask(task.id);
        },
        background: Container(
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.only(right: 20),
          decoration: BoxDecoration(
            color: Colors.redAccent,
            borderRadius: BorderRadius.circular(18),
          ),
          child: const Icon(Icons.delete, color: Colors.white),
        ),

        child: ClipRRect(
          borderRadius: BorderRadius.circular(18),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18),
                color: isDark
                    ? Colors.white.withValues(alpha: 0.05)
                    : Colors.white.withValues(alpha: 0.3),
                border: Border.all(color: Colors.white.withValues(alpha: 0.2)),
              ),

              child: Row(
                children: [
                  Transform.scale(
                    scale: 1.2,
                    child: Checkbox(
                      value: task.isCompleted,
                      activeColor: Colors.purpleAccent.withValues(alpha: 0.4),
                      onChanged: (_) {
                        context.read<TaskProvider>().toggleTask(task.id);
                      },
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      task.title,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        decoration: task.isCompleted
                            ? TextDecoration.lineThrough
                            : null,
                        color: task.isCompleted ? Colors.grey : null,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      context.read<TaskProvider>().deleteTask(task.id);
                    },
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.red.withValues(alpha: 0.15),
                      ),
                      child: const Icon(
                        Icons.close,
                        size: 18,
                        color: Colors.redAccent,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
