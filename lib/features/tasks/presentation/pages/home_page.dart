import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:take_home_challenge_innoscripta/core/styles/app_colors.dart';
import 'package:take_home_challenge_innoscripta/core/styles/app_text_style.dart';
import 'package:take_home_challenge_innoscripta/core/utils/constant/app_constants.dart';
import 'package:take_home_challenge_innoscripta/features/tasks/domain/models/task_model.dart';
import 'package:take_home_challenge_innoscripta/features/tasks/presentation/bloc/tasks_bloc.dart';
import 'package:take_home_challenge_innoscripta/features/tasks/presentation/widgets/task_class_widget.dart';
import 'package:take_home_challenge_innoscripta/features/tasks/presentation/widgets/task_tile.dart';
import 'package:take_home_challenge_innoscripta/shared/presentation/widgets/app_loader.dart';

class HomePage extends StatelessWidget {
  final List<TaskModel> tasks;
  const HomePage({super.key, required this.tasks});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TasksBloc, TasksState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state is TaskLoading) {
          return const AppLoader();
        }
        return ListView(
          padding: const EdgeInsets.only(left: 5, right: 5, top: 10, bottom: 10),
          scrollDirection: Axis.horizontal,
          physics: const ClampingScrollPhysics(),
          children: [
            SizedBox(
              width: 250,
              child: TaskClass(
                title: "Todo",
                child: Builder(
                  builder: (context) {
                    final todoTasks = tasks.where((task) => task.sectionId == todoSectionID).toList();
                    todoTasks.sort((e1, e2) => DateTime.parse(e2.createdAt!).compareTo(DateTime.parse(e1.createdAt!)));

                    return SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        children: List.generate(
                          todoTasks.length,
                              (index) {
                            final task = todoTasks[index];
                            return TaskTile(
                              task: task,
                            );
                          },
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),

            SizedBox(
              width: 250,
              child: TaskClass(
                title: "InProgress",
                child: Builder(
                  builder: (context) {
                    final inProgressTasks = tasks.where((task) => task.sectionId == inProgressSectionID).toList();
                    inProgressTasks.sort((e1, e2) => DateTime.parse(e2.createdAt!).compareTo(DateTime.parse(e1.createdAt!)));

                    return SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        children: List.generate(
                          inProgressTasks.length,
                              (index) {
                            final task = inProgressTasks[index];
                            return TaskTile(
                              task: task,
                            );
                          },
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),

            SizedBox(
              width: 250,
              child: TaskClass(
                title: "Done",
                child: Builder(
                  builder: (context) {
                    final doneTasks = tasks.where((task) => task.sectionId == doneSectionID).toList();
                    doneTasks.sort((e1, e2) => DateTime.parse(e2.createdAt!).compareTo(DateTime.parse(e1.createdAt!)));

                    return SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        children: List.generate(
                          doneTasks.length,
                              (index) {
                            final task = doneTasks[index];
                            return TaskTile(
                              task: task,
                            );
                          },
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),

            SizedBox(
              width: 250,
              child: TaskClass(
                title: "ADD SECTION",
                child: Column(
                  children: [
                    Container(
                      width: 250,
                      padding: const EdgeInsets.symmetric(vertical: 25),
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
                      child: InkWell(
                        onTap: (){
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Upcoming . . .'),
                            ),
                          );
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            const Icon(CupertinoIcons.plus, size: 30, color: AppColors.boardHeader,),
                            SizedBox(height: 5.h,),
                            Text(
                              "Add Section",
                              maxLines: 2,
                              style: AppTextStyle.xLargeBlack.copyWith(
                                color: AppColors.boardHeader,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}