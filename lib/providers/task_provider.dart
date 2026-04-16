import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import '../models/task_model.dart';
import '../services/local_storage_service.dart';

class TaskProvider with ChangeNotifier {
  List<Task> _tasks = [];
  final _storage = LocalStorageService();

  List<Task> get tasks => _tasks;

  Future<void> loadTasks() async {
    _tasks = await _storage.loadTasks();
    notifyListeners();
  }

  void addTask(String title) {
    final task = Task(
      id: const Uuid().v4(),
      title: title,
    );
    _tasks.add(task);
    _save();
  }

  void toggleTask(String id) {
    final index = _tasks.indexWhere((t) => t.id == id);
    _tasks[index].isCompleted = !_tasks[index].isCompleted;
    _save();
  }

  void deleteTask(String id) {
    _tasks.removeWhere((t) => t.id == id);
    _save();
  }

  void _save() {
    _storage.saveTasks(_tasks);
    notifyListeners();
  }
}