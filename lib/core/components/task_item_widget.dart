import 'package:flutter/material.dart';
import 'package:to_do_app/Services/taskService.dart';
import 'package:to_do_app/core/enums/action_enum.dart';
import 'package:to_do_app/core/enums/popup_menu_button_enum.dart';
import 'package:to_do_app/core/theme/theme_controller.dart';
import 'package:to_do_app/core/components/custome_alert_dialog.dart';
import 'package:to_do_app/core/components/custome_chick_box.dart';
import 'package:to_do_app/core/components/custome_edit_add_task.dart';
import 'package:to_do_app/core/components/custome_text_form_fild_widget.dart';
import 'package:to_do_app/models/task_model.dart';

class TaskItemWidget extends StatefulWidget {
  TaskItemWidget({
    super.key,
    required this.elment,
    required this.onTap,
    required this.index,
    required this.delTask,
    required this.updateTask,
    required this.tasks,
    required this.onEdit,
  });
  final TaskModel elment;
  final Function(bool?, int?) onTap;
  final Function(int?) delTask;
  final Function(int?) updateTask;
  final Function onEdit;
  final tasks;
  int index;

  @override
  State<TaskItemWidget> createState() => _TaskItemWidgetState();
}

class _TaskItemWidgetState extends State<TaskItemWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        border: Border.all(
          color: ThemeController.isDark()
              ? Colors.transparent
              : Color(0xffD1DAD6),
        ),
        color: Theme.of(context).colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(width: 8),
          CustomeChickBox(
            value: widget.elment.isComplet,
            onChanged: (value) {
              widget.onTap(value, widget.index);
            },
          ),

          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.elment.taskName,
                  style: widget.elment.isComplet
                      ? Theme.of(
                          context,
                        ).textTheme.titleLarge!.copyWith(fontSize: 18)
                      : Theme.of(
                          context,
                        ).textTheme.titleSmall!.copyWith(fontSize: 18),

                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                if (widget.elment.taskDescription.isNotEmpty)
                  Text(
                    widget.elment.taskDescription,
                    style: widget.elment.isComplet
                        ? Theme.of(context).textTheme.titleLarge
                        : Theme.of(context).textTheme.titleSmall,

                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
              ],
            ),
          ),
          PopupMenuButton<PopupMenuButtonEnum>(
            icon: Icon(
              Icons.more_vert,
              color: ThemeController.isDark()
                  ? (widget.elment.isComplet
                        ? Color(0xFFA0A0A0)
                        : Color(0xFFc6c6c6))
                  : (widget.elment.isComplet
                        ? Color(0xFF6A6A6A)
                        : Color(0xFF3A4640)),
            ),

            onSelected: (value) async {
              switch (value) {
                case PopupMenuButtonEnum.delete:
                  showDialog(
                    context: context,
                    builder: (context) {
                      return CustomeAlertDialog(
                        actionName: "Delete",
                        title: "Delete Task",
                        content: "Are you sure you want to delete this task?",
                        actionType: ActionEnum.delete,
                        onPress: () async {
                          bool response = await TaskService().deleteTask(
                            widget.elment.taskId ?? 0,
                          );
                          if (response) {
                            widget.delTask(widget.elment.taskId);
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  'Failed to delete task. Please try again.',
                                ),
                              ),
                            );
                          }
                          Navigator.of(context).pop();
                        },
                      );
                    },
                  );

                case PopupMenuButtonEnum.edit:
                  TextEditingController taskNameController =
                      TextEditingController(text: widget.elment.taskName);
                  TextEditingController taskDescriptionController =
                      TextEditingController(
                        text: widget.elment.taskDescription,
                      );
                  GlobalKey<FormState> _key = GlobalKey<FormState>();
                  int taskId = widget.elment.taskId ?? 0;
                  bool isPriorty = widget.elment.ispriorty;

                  final result = await showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,

                    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                    builder: (context) => Form(
                      key: _key,
                      child: Padding(
                        padding: const EdgeInsets.only(
                          top: 70,
                          bottom: 20,
                          right: 16,
                          left: 16,
                        ),
                        child: SafeArea(
                          child: CustomeEditAddTask.withTitle(
                            pageTitle: "Edit Task",
                            buttonName: "Edit Task",
                            icone: Icons.edit,
                            taskName: taskNameController,
                            taskDescription: taskDescriptionController,
                            taskId: taskId,
                            ispriorty: isPriorty,
                            formkey: _key,
                            callApi: (model) async {
                              bool success = await TaskService().upDateTask(
                                model,
                              );

                              if (success) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text("Task updated Successfully"),
                                  ),
                                );
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text("Faild to update task"),
                                  ),
                                );
                              }

                              return success;
                            },
                          ),
                        ),
                      ),
                    ),
                  );

                  if (result != null && result) {
                    widget.onEdit();
                  }
                case PopupMenuButtonEnum.markAsDone:
                  widget.onTap(!widget.elment.isComplet, widget.index);
                // elment.isComplet ? value.name = 'Mark as Done' : value.name = 'Mark as Undone';
              }
            },
            itemBuilder: (context) => PopupMenuButtonEnum.values.map((e) {
              return PopupMenuItem<PopupMenuButtonEnum>(
                value: e,
                child: Text(e.getDisplayName(widget.elment.isComplet)),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
