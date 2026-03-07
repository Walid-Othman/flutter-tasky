import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:to_do_app/core/theme/theme_controller.dart';
import 'package:to_do_app/core/widgets/custome_chick_box.dart';
import 'package:to_do_app/models/task_model.dart';
import 'package:to_do_app/screens/high_priority_screen.dart';

class HighPriority extends StatelessWidget {
  HighPriority({
    super.key,
    required this.tasks,
    required this.onTap,
    required this.loadTask,
  });
  List<TaskModel> tasks;
  final onTap;
  final loadTask;
  @override
  Widget build(BuildContext context) {
    final isPiortytasks = tasks.where((task) => task.ispriorty).toList();

    return Container(
      // height: 343,
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "High Priority Tasks",
                style: TextStyle(
                  color: Color(0xFF15B86C),
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(height: 10),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: isPiortytasks.length > 4 ? 4 : isPiortytasks.length,
                itemBuilder: (BuildContext context, int index) {
                  // final element = tasks[index];
                  final taskIndex = isPiortytasks[index];
                  final originaltaskIndex = tasks.indexOf(taskIndex);

                  // margin: EdgeInsets.only(bottom: 4),
                  return Row(
                    children: [
                      // chicked box //////////////////////////////////
                      CustomeChickBox(
                        value: taskIndex.isComplet,
                        onChanged: (value) {
                          onTap(value, originaltaskIndex);
                        },
                      ),

                      //////////////////////////
                      SizedBox(width: 4),

                      Text(
                        "${isPiortytasks[index].taskName} ",
                        style: isPiortytasks[index].isComplet
                            ? Theme.of(context).textTheme.titleLarge
                            : Theme.of(context).textTheme.titleSmall,
                        // style: TextStyle(
                        //   decoration: isPiortytasks[index].isComplet
                        //       ? TextDecoration.lineThrough
                        //       : TextDecoration.none,
                        //   decorationColor: Color(0xFFfffcfc),
                        //   color: isPiortytasks[index].isComplet
                        //       ? Color(0xFFA0A0A0)
                        //       : Color(0xFFfffcfc),
                        //   fontSize: 14,
                        //   fontWeight: FontWeight.w400,
                        // ),
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
          Positioned(
            right: 0,
            bottom: 0,
            child: GestureDetector(
              onTap: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) => HighPriorityScreen(),
                  ),
                );
                loadTask();
              },
              child: Container(
                alignment: Alignment.center,
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  border: Border.all(
                    color: ThemeController.isDark()
                        ? Color(0xFF6E6E6E)
                        : Color(0xFFD1DAD6),
                    width: 2,
                  ),
                ),

                child: SvgPicture.asset(
                  'assets/images/arrow-up-right.svg',
                  width: 24,
                  height: 24,
                  colorFilter: ColorFilter.mode(
                    ThemeController.isDark()
                        ? Color(0xFFC6C6C6)
                        : Color(0xFF3A4640),
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
