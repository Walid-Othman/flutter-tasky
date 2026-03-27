import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:to_do_app/Services/taskService.dart';
import 'package:to_do_app/Services/set_tasks.dart';
import 'package:to_do_app/core/Controllers/data_controller.dart';
import 'package:to_do_app/models/task_model.dart';

import 'package:to_do_app/core/components/task_list_wedget.dart';

class TasksScreen extends StatefulWidget {
  const TasksScreen({super.key});

  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  bool isLoding = false;
  @override
  void initState() {
    super.initState();
    _loadTask();
  }

  List<TaskModel> tasks = [];

  Future<void> _loadTask() async {
    // try {
    //   isLoding = true;
    //   final allTasks = await TaskService().getTasks();
    //   final unCompletTasks = allTasks
    //       .where((e) => e.isComplet == false)
    //       .toList();
    //   setState(() {
    //     tasks = unCompletTasks;
    //     isLoding = false;
    //   });
    // } catch (e) {
    //   print("Something went wrong : $e");
    // }
    // context.read<DataController>().handelCompletTasks();
  }

  @override
  Widget build(BuildContext context) {
    tasks = context.watch<DataController>().unCompleteTasks ;
    return Scaffold(
      appBar: AppBar(title: Text('To Do Task'), toolbarHeight: 60),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: isLoding
            ? Center(child: CircularProgressIndicator())
            : tasks.isEmpty
            ? Center(
                child: Text(
                  "There are no un completed tasks here",
                  style: TextStyle(color: Color(0xFFfffcfc), fontSize: 16),
                ),
              )
            : TaskListWidget(
                tasks: tasks,
                onEdit: () {
                  setState(() {
                    _loadTask();
                  });
                },
                updateTask: (index) {
                  setState(() {
                    SetTasks(tasks: tasks).updateTask(index);
                  });
                },
                delTask: (index) {
                  setState(() {
                    SetTasks(tasks: tasks).delTask(index);
                  });
                },
                onTap: (bool? value, int? index) async {
                  if (index == null) return;
                  final updatetedTask = tasks[index];
                  context.read<DataController>().toggleTask(updatetedTask);
                  // updatetedTask.isComplet = value ?? false;
                  // setState(() {
                  //   tasks.removeAt(index);
                  // }
                  // );
                  // bool success = await TaskService().upDateTask(updatetedTask);
                  // if (!success) {
                  //   _loadTask();
                  //   ScaffoldMessenger.of(context).showSnackBar(
                  //     SnackBar(
                  //       content: Text("Failed to update task on server"),
                  //     ),
                  //   );
                  // }
                },
              ),
      ),
    );
  }
}
