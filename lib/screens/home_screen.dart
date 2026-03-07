import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:to_do_app/Services/git_user_data.dart';
import 'package:to_do_app/Services/taskService.dart';
import 'package:to_do_app/core/widgets/set_tasks.dart';
import 'package:to_do_app/models/task_model.dart';
import 'package:to_do_app/core/widgets/Achieved_Tasks_widget.dart';
import 'package:to_do_app/core/widgets/High_Priority_Widget.dart';
import 'package:to_do_app/core/widgets/sliver_task_list_wedget.dart';
import 'package:to_do_app/core/widgets/task_list_wedget.dart';
import 'add_task.dart';
import 'dart:math';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isLoding = false;
  int hour = DateTime.now().hour;
  String getGreeting() {
    if (hour >= 0 && hour < 12) {
      return 'Good Morning $userName';
    } else if (hour >= 12 && hour < 17) {
      return 'Good Afternoon $userName';
    } else {
      return 'Good Evening $userName';
    }
  }

  String imageFromDB = "";

  _doneTasks(bool value, int index) async {
    setState(() {
      tasks[index].isComplet = value;
    });
    await TaskService().upDateTask(tasks[index]);
  }

  String userName = 'Guest';
  bool isComblete = true;
  @override
  initState() {
    super.initState();

    _loadTask();
    _loadSettings();
  }

  Future _loadSettings() async {
    final response = await GitUserData().loadSettings();
    if (!mounted) return;
    setState(() {
      if (response != null) {
        userName = response.userName;
        imageFromDB = response.image ?? "";
      }
    });
  }

  ImageProvider _getProfileImage() {
    if (imageFromDB.startsWith('http')) {
      return NetworkImage(imageFromDB);
    } else if (imageFromDB.isNotEmpty) {
      // لو المستخدم لسه مختار صورة من الموبايل، هنعرضها كملف
      return FileImage(File(imageFromDB));
    } else {
      // الصورة الافتراضية
      return const AssetImage('assets/images/personTwo.webp');
    }
  }

  List<TaskModel> tasks = [];
  int get doneTasksCount => tasks.where((task) => task.isComplet).length;
  double get completionRatio =>
      tasks.isEmpty ? 0.0 : (doneTasksCount / tasks.length);
  Future<void> _loadTask() async {
    try {
      isLoding = true;
      final finalTasks = await TaskService().getTasks();

      setState(() {
        tasks = finalTasks;

        isLoding = false;
      });
    } catch (e) {
      print("the error is : $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      floatingActionButton: SizedBox(
        width: 168,
        height: 40,
        child: FloatingActionButton.extended(
          onPressed: () async {
            final bool? result = await Navigator.push(
              context,
              MaterialPageRoute(builder: (BuildContext context) => AddTask()),
            );

            if (result != null && result) {
              setState(() {
                _loadTask();
              });
            }
          },

          label: Text("Add New Task"),
          icon: Icon(Icons.add),
          backgroundColor: Color(0xFF15886c),
          foregroundColor: Color(0xFFfffcfc),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100),
          ),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundImage: _getProfileImage(),
                      ),
                      SizedBox(width: 8),

                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            getGreeting(),
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          // SizedBox(height:8),
                          Text(
                            'One task at a time.One step\n closer. ',
                            style: Theme.of(context).textTheme.titleSmall,
                            // style: TextStyle(
                            //   color: Color(0xFFC6C6C6),
                            //   fontWeight: FontWeight.w400,
                            //   fontSize: 14,
                            // ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "$userName,Your Work Is",
                      style: Theme.of(context).textTheme.displaySmall,
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        " almost done !",
                        style: Theme.of(context).textTheme.displaySmall,
                      ),

                      SvgPicture.asset("assets/images/hand.svg"),
                    ],
                  ),

                  SizedBox(height: 20),
                  HighPriority(
                    tasks: tasks,
                    onTap: (bool value, int index) {
                      _doneTasks(value, index);
                    },
                    loadTask: () {
                      _loadTask();
                    },
                  ),
                  SizedBox(height: 20),
                  AchievedTasks(
                    doneTasksCount: doneTasksCount,
                    tasks: tasks,
                    completionRatio: completionRatio,
                  ),

                  Padding(
                    padding: const EdgeInsets.only(top: 24, bottom: 16),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "My Tasks",
                        style: Theme.of(
                          context,
                        ).textTheme.displaySmall!.copyWith(fontSize: 20),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            isLoding
                ? SliverToBoxAdapter(
                    child: Center(child: CircularProgressIndicator()),
                  )
                : tasks.isEmpty
                ? SliverToBoxAdapter(
                    child: Center(
                      child: Text(
                        "Ther are no tasks here",
                        style: Theme.of(
                          context,
                        ).textTheme.displaySmall!.copyWith(fontSize: 16),
                      ),
                    ),
                  )
                : SliverTaskListWidget(
                    tasks: tasks,
                    onEdit: () {
                      setState(() {
                        _loadTask();
                      });
                    },
                    onTap: (bool? value, int? index) {
                      _doneTasks(value ?? false, index ?? 0);
                    },

                    delTask: (index) {
                      setState(() {
                        SetTasks(tasks: tasks).delTask(index);
                      });
                    },
                    updateTask: (index) {
                      setState(() {
                        SetTasks(tasks: tasks).updateTask(index);
                      });
                    },
                  ),
          ],
        ),
      ),
    );
  }
}
