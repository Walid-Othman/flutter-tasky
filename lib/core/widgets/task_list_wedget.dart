import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:to_do_app/core/widgets/custome_chick_box.dart';
import 'package:to_do_app/core/widgets/task_item_widget.dart';
import 'dart:convert';

import 'package:to_do_app/models/task_model.dart';

class TaskListWidget extends StatelessWidget {
  TaskListWidget({super.key, required this.tasks, required this.onTap , required this.delTask , required this.updateTask ,required this.onEdit});

  final List<TaskModel> tasks;
  final Function(bool?, int?) onTap;
  final Function( int?) delTask;
  final Function(int?) updateTask;
final Function onEdit;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.only(bottom: 40),
      itemCount: tasks.length,
      itemBuilder: (BuildContext context, int index) {
        final elment = tasks[index];
        // return
        return TaskItemWidget(
          elment: elment,
          onTap: onTap,
          index: index,
          tasks: tasks,
          delTask: delTask,
          updateTask:updateTask,
          onEdit: onEdit,
        );
      },
    );
  }
}
