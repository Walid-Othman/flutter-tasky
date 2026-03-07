import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:to_do_app/Services/taskService.dart';
import 'package:to_do_app/core/widgets/set_tasks.dart';
import 'package:to_do_app/models/task_model.dart';

import 'package:to_do_app/core/widgets/task_list_wedget.dart';

class CompletedScreen extends StatefulWidget {
  const CompletedScreen({super.key});

  @override
  State<CompletedScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<CompletedScreen> {
  bool isLoding = false;
  @override
  void initState() {
    super.initState();
    _loadTask();
  }

  List<TaskModel> tasks = [];

  Future<void> _loadTask() async {
    try {
      isLoding = true;
      final allTasks = await TaskService().getTasks();
      final completTasks = allTasks.where((e) => e.isComplet).toList();
      setState(() {
        tasks = completTasks;
        isLoding = false;
      });
    } catch (e) {
      print("Some thing went wrong : $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Completed Tasks'), toolbarHeight: 60),
      body: Padding(
        padding: const EdgeInsets.all(16),

        child: isLoding
            ? Center(child: CircularProgressIndicator())
            : tasks.isEmpty
            ? Center(
                child: Text(
                  "there are no completed task here",
                  style: TextStyle(color: Color(0xFFfffcfc), fontSize: 16),
                ),
              )
            : TaskListWidget(
                tasks: tasks,
                onEdit: (){
                  setState(() {
                    _loadTask() ;
                  });
                },
                    updateTask: (index) {
                      setState(() {
                        SetTasks(tasks: tasks).updateTask(index);
                      });
                    },
                 delTask:(index){
                      setState(() {
                       
                        SetTasks(tasks: tasks).delTask(index);
                      });
                    },
                onTap: (bool? value, int? index) async {
                  if (index == null) return;
                  final updtatTask = tasks[index];
                  updtatTask.isComplet = value ?? false;
                  setState(() {
                    tasks.removeAt(index);
                  });
                  bool success = await TaskService().upDateTask(updtatTask);
                  if (!success) {
                    _loadTask();
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Failed to update task on server"),
                      ),
                    );
                  }
                },
              ),
      ),
    );
  }
}
