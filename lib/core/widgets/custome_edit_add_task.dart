import 'package:flutter/material.dart';
import 'package:to_do_app/core/widgets/custome_text_form_fild_widget.dart';
import 'package:to_do_app/models/task_model.dart';

class CustomeEditAddTask extends StatefulWidget {
  CustomeEditAddTask({
    super.key,

    required this.taskName,
    required this.taskDescription,
    required this.ispriorty,
    required this.formkey,
    required this.callApi,
    required this.buttonName,
    required this.icone,
    this.pageTitle,
    this.taskId,
    this.hasTitle = false
  });
  CustomeEditAddTask.withTitle(
    {
    required this.taskName,
    required this.taskDescription,
    required this.ispriorty,
    required this.formkey,
    required this.callApi,
    required this.buttonName,
    required this.icone,
    this.pageTitle,
    this.taskId,
    }
  ):hasTitle = true;
   
   bool hasTitle;
  final int? taskId;
  final formkey;
  final taskName;
  final taskDescription;
  final icone;
  final String buttonName;
  final String? pageTitle;
  bool ispriorty;
  Function(TaskModel) callApi;
  @override
  State<CustomeEditAddTask> createState() => _CustomeEditAddTaskState();
}

class _CustomeEditAddTaskState extends State<CustomeEditAddTask> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // SizedBox(height: 30,),
        Expanded(
          child: SingleChildScrollView( 
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if(widget.hasTitle)
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    widget.pageTitle ?? "",
                    style: Theme.of(context).textTheme.displaySmall,
                  ),
                ),
                SizedBox(height: 20),
                CustomeTextFormFild(
                  controller: widget.taskName,
                  hintText: 'Finish Log In Page',
                  title: 'Task Name',
                  maxLength: 30,
                  validator: (value) {
                    return 'Please Enter task Name';
                  },
                ),
                
                SizedBox(height: 10),
                CustomeTextFormFild(
                  controller: widget.taskDescription,
                  hintText: "I have to finsh Log In Page Today",
                  title: "Task Description",
                  maxLines: 4,
                  //    validator: (value) {
                  //   return 'Please Enter task Name';
                  // },
                ),
                
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Hight Priority",
                      style: TextStyle(
                        color: Color(0xFFfffcfc),
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Switch(
                      value: widget.ispriorty,
                      onChanged: (value) {
                        setState(() {
                          widget.ispriorty = value;
                        });
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 40),
        ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            fixedSize: Size(MediaQuery.of(context).size.width, 40),
          ),
          onPressed: () async {
            if (widget.formkey.currentState?.validate() ?? false) {
              final model = TaskModel(
                taskId: widget.taskId,
                taskName: widget.taskName.text,
                taskDescription: widget.taskDescription.text,
                ispriorty: widget.ispriorty,
              );
              bool success = await widget.callApi(model);
              if (success) {
                Navigator.of(context).pop(true);
              } else {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text("Something went wrong")));
              }
            }
          },
          icon: Icon(widget.icone),
          label: Text(widget.buttonName),
        ),
      ],
    );
  }
}
