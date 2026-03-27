import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/Services/git_user_data.dart';
import 'package:to_do_app/Services/taskService.dart';
import 'package:to_do_app/Services/set_tasks.dart';
import 'package:to_do_app/core/Controllers/data_controller.dart';
import 'package:to_do_app/core/Controllers/profile_controller.dart';
import 'package:to_do_app/models/task_model.dart';
import 'package:to_do_app/core/features/home/components/Achieved_Tasks_widget.dart';
import 'package:to_do_app/core/features/home/components/High_Priority_Widget.dart';
import 'package:to_do_app/core/features/home/components/sliver_task_list_wedget.dart';
import '../add_task/add_task.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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

    context.read<DataController>().toggleTask(tasks[index]);
  }

  String userName = '';
  bool isComblete = true;
  @override
  initState() {
    super.initState();

    _loadTask();
  }

  ImageProvider _getProfileImageProvider(String image) {


    if (image.startsWith('http')) {
      // كسر الـ Cache بإضافة timestamp للرابط
      return NetworkImage(image);
    }

    return FileImage(File(image));
  }


  List<TaskModel> tasks = [];

  int get doneTasksCount => tasks.where((task) => task.isComplet).length;
  double get completionRatio =>
      tasks.isEmpty ? 0.0 : (doneTasksCount / tasks.length);
  Future<void> _loadTask() async {
    try {
      context.read<DataController>().getTasks();
    } catch (e) {
      print("the error is : $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    print(42.h);
    ProfileController controller = context.watch<ProfileController>();
    userName = controller.userName;
    tasks = context.watch<DataController>().tasks;
    bool isLoding = context.watch<DataController>().isLoading;
    return Scaffold(
      appBar: AppBar(),
      floatingActionButton: SizedBox(
        width: 168.w,
        height: 40.h,
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
                      Selector<ProfileController, String>(
                        selector: (context, controller) =>
                            controller.imageFromDB,
                        builder: (_, imageFromDb, _) {
                          return CircleAvatar(
                            backgroundImage: _getProfileImageProvider(
                              imageFromDb,
                            ),
                          );
                        },
                      ),
                      SizedBox(width: 8.w),

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
                        
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 8.h),
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

                  SizedBox(height: 20.h),
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
