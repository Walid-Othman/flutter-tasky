import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/Services/taskService.dart';
import 'package:to_do_app/Services/set_tasks.dart';
import 'package:to_do_app/core/Controllers/data_controller.dart';
import 'package:to_do_app/models/task_model.dart';
import 'package:to_do_app/core/components/task_list_wedget.dart';

class HighPriorityScreen extends StatefulWidget {
  const HighPriorityScreen({super.key});

  @override
  State<HighPriorityScreen> createState() => _HighPriorityScreen();
}

class _HighPriorityScreen extends State<HighPriorityScreen> {
  _doneTasks(bool value, int index) async {
    context.read<DataController>().toggleTask(tasks[index]);
  }

  List<TaskModel> tasks = [];

  bool isLoding = false;
  @override
  initState() {
    super.initState();
    _loadTask();
  }

  Future _loadTask() async {
    // try {
    //   isLoding = true;
    //   final allTask = await TaskService().getTasks();
    //   final highTasks = allTask.where((task) => task.ispriorty).toList();
    //   setState(() {
    //     tasks = highTasks;
    //     isLoding = false;
    //   });
    // } catch (e) {
    //   print("the error is : $e");
    // }
  }

  @override
  Widget build(BuildContext context) {
  tasks =  context.watch<DataController>().isHighPriorty;
    return Scaffold(
      appBar: AppBar(title: Text('High Priority Tasks'), toolbarHeight: 50),
      body: isLoding
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16),

              child: TaskListWidget(
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
                onTap: (bool? value, int? index) {
                  _doneTasks(value ?? false, index ?? 0);
                },
              ),
            ),
    );
  }
}
