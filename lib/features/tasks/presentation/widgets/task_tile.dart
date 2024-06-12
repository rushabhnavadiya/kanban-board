import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:take_home_challenge_innoscripta/core/styles/app_colors.dart';
import 'package:take_home_challenge_innoscripta/core/styles/app_text_style.dart';
import 'package:take_home_challenge_innoscripta/core/utils/constant/app_constants.dart';
import 'package:take_home_challenge_innoscripta/core/utils/constant/task_utils.dart';
import 'package:take_home_challenge_innoscripta/features/tasks/domain/models/task_model.dart';
import 'package:take_home_challenge_innoscripta/features/tasks/domain/models/update_status_task_params.dart';
import 'package:take_home_challenge_innoscripta/features/tasks/presentation/bloc/tasks_bloc.dart';
import 'package:take_home_challenge_innoscripta/features/tasks/presentation/widgets/task_detail_bottom_sheet.dart';

class TaskTile extends StatefulWidget {
  const TaskTile({
    super.key,
    required this.task,
  });
  final TaskModel task;

  @override
  State<TaskTile> createState() => _TaskTileState();
}

class _TaskTileState extends State<TaskTile> {

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 3),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          color: AppColors.white,
          boxShadow: const [
            BoxShadow(
              offset: Offset(1, 1),
              blurRadius: 1,
              color: Color.fromRGBO(0, 0, 0, 0.16),
            )
          ]
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(6),
          onTap: (){
            TasksBloc value = context.read<TasksBloc>();
            Future.delayed(const Duration(milliseconds: 200),(){
              value.add(GetTaskTrackerStatusEvent(taskId: widget.task.id!));
            });
            value.add(GetCommentsEvent(taskId: widget.task.id!));
            showModalBottomSheet<dynamic>(
              context: context,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(6)),
              ),
              isScrollControlled: true,
              useSafeArea: true,
              builder: (_) {
                return BlocProvider.value(
                  value: value,
                  child: TaskDetailBottomSheet(task: widget.task, value: value,),
                );
              },
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        widget.task.description ?? "",
                        style: AppTextStyle.mediumBlack,
                      ),
                    ),

                    if(widget.task.sectionId == doneSectionID)...[
                      Padding(
                        padding: EdgeInsets.only(left: 2.w,top: 3.h),
                        child: const Icon(Icons.check_circle, size: 20,color: Colors.green,),
                      )
                    ]else...[
                      PopupMenuButton<String>(
                        onSelected: (value) {
                          context.read<TasksBloc>().add(
                            UpdateStatusTaskEvent(
                              param: UpdateStatusTaskParams(
                                taskId: widget.task.id,
                                sectionId: value,
                              ),
                            ),
                          );
                        },
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                        itemBuilder: (context) => [
                          if(widget.task.sectionId == todoSectionID)...[
                            const PopupMenuItem(
                              value: inProgressSectionID,
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Icon(Icons.swap_horiz_rounded,color: AppColors.taskTitle,),
                                  SizedBox(width: 10),
                                  Text('Move to In-progress',
                                    style: AppTextStyle.mediumBlack,
                                  ),
                                ],
                              ),
                            ),
                            const PopupMenuItem(
                              value: doneSectionID,
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Icon(Icons.swap_horiz_rounded,color: AppColors.taskTitle,),
                                  SizedBox(width: 10),
                                  Text('Move to Done',
                                    style: AppTextStyle.mediumBlack,
                                  ),
                                ],
                              ),
                            ),
                          ]else if(widget.task.sectionId == inProgressSectionID)...[
                            const PopupMenuItem(
                              value: todoSectionID,
                              child: Row(
                                children: <Widget>[
                                  Icon(Icons.swap_horiz_rounded,color: AppColors.taskTitle,),
                                  SizedBox(width: 10),
                                  Text('Move to Todo',
                                    style: AppTextStyle.mediumBlack,
                                  ),
                                ],
                              ),
                            ),
                            const PopupMenuItem(
                              value: doneSectionID,
                              child: Row(
                                children: <Widget>[
                                  Icon(Icons.swap_horiz_rounded,color: AppColors.taskTitle,),
                                  SizedBox(width: 10),
                                  Text('Move to Done',
                                    style: AppTextStyle.mediumBlack,
                                  ),
                                ],
                              ),
                            ),

                          ]else...[
                            const PopupMenuItem(
                              value: todoSectionID,
                              child: Row(
                                children: <Widget>[
                                  Icon(Icons.swap_horiz_rounded,color: AppColors.taskTitle,),
                                  SizedBox(width: 10),
                                  Text('Move to Todo',
                                    style: AppTextStyle.mediumBlack,
                                  ),
                                ],
                              ),
                            ),
                            const PopupMenuItem(
                              value: inProgressSectionID,
                              child: Row(
                                children: <Widget>[
                                  Icon(Icons.swap_horiz_rounded,color: AppColors.taskTitle,),
                                  SizedBox(width: 10),
                                  Text('Move to In-progress',
                                    style: AppTextStyle.mediumBlack,
                                  ),
                                ],
                              ),
                            ),
                          ]
                        ],
                        child: Padding(
                          padding: EdgeInsets.only(left: 2.w,top: 3.h),
                          child: const Icon(Icons.swap_horiz_rounded, size: 18,color: Colors.grey,),
                        ),
                      ),
                    ]
                  ],
                ),
                const SizedBox(height: 22),

                Row(
                  children: [
                    Expanded(
                      child: Text(
                        widget.task.content ?? "",
                        maxLines: 2,
                        style: const TextStyle(
                          color: AppColors.taskDescription,
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    SizedBox(width: 5.w,),
                    Icon(CupertinoIcons.ant_circle_fill, size: 18, color: TaskUtils.getColorFromPriority(widget.task.priority),)
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}