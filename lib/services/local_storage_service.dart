import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/task_model.dart';

class LocalStorageService {
  static const String key = "tasks";

  Future<void> saveTasks(List<Task> tasks) async {
    final prefs = await SharedPreferences.getInstance();
    final data = tasks.map((e) => e.toJson()).toList();
    prefs.setString(key, jsonEncode(data));
  }

  Future<List<Task>> loadTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString(key);

    if (data == null) return [];

    final decoded = jsonDecode(data) as List;
    return decoded.map((e) => Task.fromJson(e)).toList();
  }
}