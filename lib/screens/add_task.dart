import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:to_do_app/Services/taskService.dart';
import 'package:to_do_app/core/widgets/custome_edit_add_task.dart';
import 'package:to_do_app/core/widgets/custome_text_form_fild_widget.dart';
import 'package:to_do_app/models/task_model.dart';

class AddTask extends StatefulWidget {
  AddTask({super.key});

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  /// ToDo : DISPOSE THIS CONTROLLERS
  final TextEditingController taskName = TextEditingController();
  final TextEditingController taskDescription = TextEditingController();

  bool ispriorty = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("New Task"), toolbarHeight: 60),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Form(
            key: _key,
            child: CustomeEditAddTask(
              buttonName: "Add Task",
              icone: Icons.add,
              taskName: taskName,
              taskDescription: taskDescription,
              ispriorty: ispriorty,
              formkey: _key,
              callApi: (TaskModel model) async {
                bool success = await TaskService().addTask(model);
                return success;
              },
            ),
          ),
        ),
      ),
    );
  }
}
