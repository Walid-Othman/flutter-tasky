import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:to_do_app/core/widgets/custome_chick_box.dart';
import 'package:to_do_app/core/widgets/task_item_widget.dart';
import 'package:to_do_app/core/widgets/task_list_wedget.dart';
import 'dart:convert';

import 'package:to_do_app/models/task_model.dart';

class SliverTaskListWidget extends StatelessWidget {
  SliverTaskListWidget({super.key, required this.tasks, required this.onTap , required this.delTask , required this.updateTask,required this.onEdit});

  final List<TaskModel> tasks;
  final Function(bool?, int?) onTap;
  final Function( int?) delTask;
  final Function(int?) updateTask;
 final Function onEdit;
 
  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: EdgeInsets.only(bottom: 40),
      sliver: SliverList.separated(
        separatorBuilder: (BuildContext context, int index) {
          return const SizedBox(height: 5); // يمكنك تغيير المسافة كما تحب
        },
        // padding: EdgeInsets.only(bottom: 40),
        itemCount: tasks.length,
        itemBuilder: (BuildContext context, int index) {
          final elment = tasks[index];
          // return     
          if(tasks.isNotEmpty)
          return TaskItemWidget(elment: elment, onTap: onTap, index: index ,tasks:tasks,delTask: delTask ,updateTask:updateTask,onEdit: onEdit,);
        },
      ),
    );
  }
}
