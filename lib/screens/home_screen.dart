import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_manager_app/custom_widgets/add_task.dart';
import 'package:task_manager_app/custom_widgets/task_item.dart';
import '../providers/task_provider.dart';
// import '../widgets/task_item.dart';
// import '../widgets/add_task_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<TaskProvider>();

    return Scaffold(
      appBar: AppBar(title: const Text("Task Manager")),
      body: Column(
        children: [
          const AddTaskWidget(),
          Expanded(
            child: ListView.builder(
              itemCount: provider.tasks.length,
              itemBuilder: (context, index) {
                return TaskItem(task: provider.tasks[index]);
              },
            ),
          ),
        ],
      ),
    );
  }
}