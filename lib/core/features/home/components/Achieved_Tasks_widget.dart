import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:to_do_app/Services/app_sizes.dart';

class AchievedTasks extends StatelessWidget {
  const AchievedTasks({
    super.key,
    required this.doneTasksCount,
    required this.tasks,
    required this.completionRatio,
  });
  final int doneTasksCount;
  final List tasks;
  final double completionRatio;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color:Theme.of(context).colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,

        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Achieved Tasks",
                style: Theme.of(context).textTheme.titleMedium,
              ),
              SizedBox(height: 4),
              Text(
                "${doneTasksCount} Out of ${tasks.length} Done",
                style: Theme.of(context).textTheme.titleSmall,
              ),
            ],
          ),

          Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width:AppSizes.w48,
                height: AppSizes.h48,
                child: CircularProgressIndicator(
                  strokeWidth: 4,
                  valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF15B86C)),
                  backgroundColor: Color(0xFF6D6D6D),
                  value: completionRatio,
                ),
              ),
              Text(
                "${(completionRatio * 100).toInt()}%",
                style: Theme.of(context).textTheme.titleMedium!.copyWith(fontSize: 14.sp),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
