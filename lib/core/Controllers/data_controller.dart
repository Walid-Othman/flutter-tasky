import 'package:file/memory.dart';
import 'package:flutter/material.dart';
import 'package:to_do_app/Services/taskService.dart';
import 'package:to_do_app/models/task_model.dart';

class DataController with ChangeNotifier {
  List<TaskModel> tasks = [];
  List<TaskModel> get unCompleteTasks =>
      tasks.where((task) => task.isComplet == false).toList();
  List<TaskModel> get completeTasks =>
      tasks.where((task) => task.isComplet).toList();
  List<TaskModel> get isHighPriorty =>
      tasks.where((task) => task.ispriorty).toList();

  bool isLoading = false;
  void getTasks() async {
    if (tasks.isEmpty) {
      isLoading = true;
     
    }
    try {
      List<TaskModel> allTasks = await TaskService().getTasks();
      tasks = allTasks;
    } catch (e) {
      debugPrint("Error fetching tasks: $e");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  void toggleTask(TaskModel task) async {
    task.isComplet = !task.isComplet;
    notifyListeners();
    await TaskService().upDateTask(task);
  }
}
