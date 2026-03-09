import 'package:to_do_app/models/task_model.dart';

class SetTasks {
  SetTasks({required this.tasks});
  final List tasks;
  delTask(int? index) {
    tasks.removeWhere((task) => task.taskId == index);
  }

  updateTask(int? id) {
    // int index = tasks.indexWhere((e) => e.taskId == id);
    // if (index != -1) {
    //   tasks[index] = TaskModel(
    //     taskId: tasks[index].taskId,
    //     taskName: tasks[index].taskName,
    //     taskDescription: tasks[index].taskDescription,
    //     isComplet: true,
    //     ispriorty: tasks[index].ispriorty,
    //   );
    // }
    final task = tasks.firstWhere((e) => e.taskId == id);
    if (task != null) {
      task.isComplet = true;
      tasks.removeWhere((e) => e.taskId == id);
    }

  }
}
