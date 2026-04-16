import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_manager_app/custom_widgets/add_task.dart';
import 'package:task_manager_app/custom_widgets/task_item.dart';
import 'package:task_manager_app/providers/theme_provider.dart';
import '../providers/task_provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<TaskProvider>();

    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.asset(
              'assets/images/remembero_splash.png',
              height: 56,
            ),
            SizedBox(width: 8),
            Text(
              "Your task assistant",
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w600,
                letterSpacing: 0.5,
                fontSize: 18,
              ),
            ),
          ],
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(
              context.watch<ThemeProvider>().isDarkMode
                  ? Icons.dark_mode
                  : Icons.light_mode,
            ),
            onPressed: () {
              context.read<ThemeProvider>().toggleTheme();
            },
          ),
        ],
      ),
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
